## Monitory Kubernetes 구성요소 요약 문서

이 문서는 Monitory 시스템의 Kubernetes 배포에서 사용된 주요 리소스(kind type), 파일별 선언 내용, 그리고 각 리소스의 주요 기능을 정리한 것입니다.

---

### 1. 사용된 kind 타입 요약

| Kind                | 주요 목적/역할                                  |
|---------------------|------------------------------------------------|
| Deployment          | 앱/서비스의 파드 자동 관리 및 배포              |
| StatefulSet         | 상태 저장 서비스(예: Kafka, Zookeeper) 관리    |
| Service             | 네트워크 서비스(내부/외부 트래픽 라우팅)       |
| PersistentVolumeClaim (PVC) | 스토리지 영속성 요청                    |
| StorageClass        | 스토리지 동적 프로비저닝 정책                   |
| ConfigMap           | 비밀이 아닌 환경설정 값 저장                    |
| Secret              | 민감 정보(비밀번호, API 키 등) 저장             |
| Ingress             | 외부 트래픽의 내부 서비스 라우팅                |
| Job                 | 일회성 작업(초기화, 커넥터 등록 등)             |

---

### 2. 파일별 선언 내용 및 주요 기능

#### backend.yaml  
- **Deployment, Service**
- Spring Boot 기반 백엔드 서비스 배포 및 NodePort 서비스 노출
- 환경변수는 ConfigMap(`backend-config`)과 Secret(`backend-secret`)에서 주입

#### chronograf.yaml  
- **Deployment, Service**
- InfluxDB 시각화 도구 Chronograf 배포 및 내부 서비스 노출

#### configmap.yaml  
- **ConfigMap**
- DB, Kafka, Grafana 등 여러 서비스의 환경변수 값 관리
- InfluxDB 초기화 스크립트 및 Sink 커넥터 설정 템플릿 포함

#### flink.yaml  
- **Deployment, Service**
- Flink 스트림 처리 엔진 배포 및 내부 서비스 노출
- 환경설정은 ConfigMap/Secret에서 일괄 주입

#### grafana.yaml  
- **Deployment, Service**
- Grafana 대시보드 배포 및 내부 서비스 노출
- 환경변수와 볼륨 설정, 관리자 계정 정보 포함

#### influxdb.yaml  
- **Deployment, Service**
- InfluxDB 데이터베이스 배포 및 내부 서비스 노출
- PVC를 통한 데이터 영속성 보장

#### influxdb-volume.yaml  
- **PersistentVolumeClaim, StorageClass**
- InfluxDB용 EBS 기반 PVC 생성(스토리지 영속성)
- StorageClass(`ebs-retain`)는 AWS EBS 볼륨을 Retain 정책으로 관리

#### ingress.yaml  
- **Ingress**
- ALB를 통한 외부 트래픽의 백엔드, Grafana로의 라우팅

#### init.yaml  
- **Job**
- InfluxDB 초기화(데이터베이스/유저/권한 생성) 및 Kafka Connect Sink 커넥터 등록
- 환경변수는 Secret/ConfigMap에서 받아와 보안성 강화

#### kafka.yaml  
- **StatefulSet, Service**
- Kafka 브로커 배포(StatefulSet, PVC 사용)
- Headless Service로 클러스터 내부 DNS 지원

#### kafka-connect.yaml  
- **Deployment, Service**
- Kafka Connect 배포 및 내부 REST API 서비스 노출
- Kafka와 연결 위한 환경변수 설정

#### mysql.yaml  
- **PersistentVolumeClaim, Service, Deployment**
- MySQL 데이터베이스 배포, PVC로 데이터 영속성 보장
- 비밀번호 등 민감 정보는 Secret, DB명 등은 ConfigMap에서 주입

#### secret.yaml  
- **Secret**
- MySQL, InfluxDB, 백엔드 등에서 사용하는 비밀번호, API 키 등 민감 정보 저장

#### zookeeper.yaml  
- **StatefulSet, Service**
- Kafka를 위한 Zookeeper 배포 및 내부 서비스 제공

---

### 3. 주요 기능별 정리

#### 데이터베이스 및 스토리지
- **MySQL, InfluxDB**: PVC와 StorageClass로 EBS 기반 영속성 보장, Secret/ConfigMap으로 환경변수 관리
- **초기화 작업(Job)**: InfluxDB DB/유저/권한 자동 생성, Kafka Connect Sink 커넥터 자동 등록

#### 메시징/스트림 처리
- **Kafka, Zookeeper, Kafka Connect**: StatefulSet, Deployment, Service로 구성, 내부 DNS 및 PVC 활용

#### 모니터링/시각화
- **Grafana, Chronograf**: Deployment, Service로 배포, ConfigMap/Secret을 통한 환경설정

#### 애플리케이션 및 API
- **Backend(Spring Boot), Flink**: Deployment, Service, ConfigMap/Secret 기반 환경설정

#### 네트워크 및 트래픽 라우팅
- **Service**: ClusterIP/NodePort/Headless로 내부 통신 및 외부 노출
- **Ingress**: ALB를 통한 도메인 기반 라우팅

#### 보안 및 환경설정
- **Secret**: DB, API 키 등 민감 정보 관리
- **ConfigMap**: 비밀이 아닌 설정값 일괄 관리

---

## 4. 사전 생성해야 하는 IAM 정책 및 역할

Monitory 클러스터에서 다음 컴포넌트들이 정상 동작하기 위해서는, Kubernetes 내부의 ServiceAccount에 연계된 IAM 역할(IAM Role)과 정책(IAM Policy)을 미리 생성해 두어야 함 여기서는 **AWS Load Balancer Controller (ALB)**와 **AWS EBS CSI Driver**를 예로 들어 설명

### 4.1. 공통 전제 조건
1. EKS 클러스터가 생성될 때, **OIDC 프로바이더**가 활성화 필요
   - 확인/생성 방법:  
     ```bash
     aws eks describe-cluster \
       --name <cluster_name> \
       --region <region> \
     | jq -r '.cluster.identity.oidc.issuer'
     ```  
     출력된 URL(e.g., `https://oidc.eks.ap-northeast-2.amazonaws.com/id/XXXXXXXXXXXX`)을 바탕으로  
     ```bash
     aws iam list-open-id-connect-providers \
       --query "OpenIDConnectProviderList[?contains(Arn, `XXXXXXXXXXXX`)]"
     ```  
     통해서 확인 가능, 미등록 상태라면 eksctl 또는 콘솔에서 “Enable IAM OIDC Provider” 옵션을 활성화해야 함

2. IAM Role을 생성할 때 사용할 **Trust Policy(신뢰 정책, AssumeRolePolicyDocument)**는 EKS OIDC 엔드포인트와 Kubernetes ServiceAccount를 “서로 믿을 수 있는 주체”로 명시 필요  
   - 예시 Trust Policy 구조:
     ```jsonc
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Principal": {
             "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/oidc.eks.<region>.amazonaws.com/id/<OIDC_ID>"
           },
           "Action": "sts:AssumeRoleWithWebIdentity",
           "Condition": {
             "StringEquals": {
               "oidc.eks.<region>.amazonaws.com/id/<OIDC_ID>:sub": "system:serviceaccount:<namespace>:<serviceaccount-name>"
             }
           }
         }
       ]
     }
     ```

---

### 4.2. AWS Load Balancer Controller용 IAM 정책 및 역할

#### 4.2.1. IAM 정책 생성
AWS Load Balancer Controller가 사용하는 IAM 정책은 아래 JSON 예시를 토대로 생성  
- JSON 파일: `iam_policy.json`
- 주요 액션: ELB 생성·조회·수정, EC2 SecurityGroup 관리 등  
- curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.3.1/docs/install/iam_policy.json 통해서 받아온 내용의 json

1) 정책 생성 명령:
   ```bash
   aws iam create-policy \
     --policy-name ALBControllerIAMPolicy \
     --policy-document file://iam_policy.json

---

## 참고

* **환경변수 주입**: 대부분의 서비스가 ConfigMap/Secret을 통해 환경변수를 받아 보안과 유지보수성을 높임
* **데이터 영속성**: 모든 주요 데이터 서비스(MySQL, InfluxDB, Kafka)는 PVC와 StorageClass로 EBS 기반 영속성 구현
* **초기화 자동화**: InfluxDB, Kafka Connect 등은 Job을 활용해 자동화된 초기화/설정 적용

### 1. Helm values 파일을 이용한 설치 예시

**1.1. AWS Load Balancer Controller (ALB Ingress Controller) 설치**

1. Helm 리포지토리 추가 및 업데이트

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```

2. values-alb.yaml 파일 예시(클러스터명, VPC ID 등은 실제 환경에 맞게 수정)

```yaml
# values-alb.yaml
clusterName: <cluster_name>
region: <region>
vpcId: <vpc_id>
serviceAccount:
  create: false
  name: aws-load-balancer-controller
# 추가 커스텀 옵션이 있다면 이곳에 정의
```

3. Helm으로 설치

```bash
helm install aws-load-balancer-controller \
  eks/aws-load-balancer-controller \
  -n kube-system \
  -f values-alb.yaml
```

* `kube-system` 네임스페이스에 `aws-load-balancer-controller` 릴리스를 생성
* values-alb.yaml에서 `serviceAccount.create: false`로 설정한 경우, 미리 생성된 IRSA 기반 ServiceAccount(`aws-load-balancer-controller`)를 사용

4. 삭제(언인스톨)

```bash
helm uninstall aws-load-balancer-controller -n kube-system
```

* 삭제 시, 관련된 AWS 리소스(예: ALB)나 IAM 리소스 중 일부는 별도로 정리 필요

---

**1.2. AWS EBS CSI Driver 설치**

1. Helm 리포지토리 추가 및 업데이트

```bash
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update
```

2. values-ebs-csi-driver.yaml 파일 예시

```yaml
# values-ebs-csi-driver.yaml
image:
  repository: public.ecr.aws/aws-controllers-k8s/ebs-csi-driver
  tag: v1.12.0  # 실제 최신 버전 확인 후 지정
controller:
  serviceAccount:
    create: false
    name: ebs-csi-controller-sa
# 추가로 필요한 파라미터가 있다면 이곳에 정의
```

3. Helm으로 설치

```bash
helm install aws-ebs-csi-driver \
  aws-ebs-csi-driver/aws-ebs-csi-driver \
  -n kube-system \
  -f values-ebs-csi-driver.yaml
```

* `serviceAccount.create: false`로 설정했을 때는, 미리 `ebs-csi-controller-sa` IRSA ServiceAccount 생성 필요

4. 삭제(언인스톨)

```bash
helm uninstall aws-ebs-csi-driver -n kube-system
```

* 언인스톨 이후에도 EBS 볼륨은 별도 정리 작업(예: DeleteOnTermination 여부 확인)이 필요

---

### 2. kubectl을 이용한 리소스 생성/삭제 예시

아래 예시는 Monitory Kubernetes 구성에서 사용된 yaml 파일들을 기준으로 한 “생성(생산용 배포)”과 “삭제(리소스 정리)” 방법으

1. **리소스 생성**

```bash
# 예: backend.yaml, influxdb.yaml, kafka.yaml 등
kubectl apply -f backend.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f mysql.yaml
kubectl apply -f influxdb-volume.yaml
kubectl apply -f influxdb.yaml
kubectl apply -f zookeeper.yaml
kubectl apply -f kafka.yaml
kubectl apply -f kafka-connect.yaml
kubectl apply -f chronograf.yaml
kubectl apply -f grafana.yaml
kubectl apply -f flink.yaml
kubectl apply -f ingress.yaml
kubectl apply -f init.yaml
```

* 각각의 yaml 파일을 `kubectl apply -f <파일명>.yaml`로 실행하면, 해당 리소스가 클러스터에 생성됨
* 순서가 중요한 경우(예: PVC가 먼저 생성되어야 InfluxDB가 붙음), 순서대로 한 줄씩 실행하거나 스크립트로 묶어서 처리 필요(그냥 해도 재생성 하면서 알아서 되긴함 :D)

2. **리소스 삭제**

```bash
# 예: 이미 생성된 리소스를 정리할 때
kubectl delete -f ingress.yaml
kubectl delete -f flink.yaml
kubectl delete -f grafana.yaml
kubectl delete -f chronograf.yaml
kubectl delete -f kafka-connect.yaml
kubectl delete -f kafka.yaml
kubectl delete -f zookeeper.yaml
kubectl delete -f influxdb.yaml
kubectl delete -f influxdb-volume.yaml
kubectl delete -f mysql.yaml
kubectl delete -f init.yaml
kubectl delete -f secret.yaml
kubectl delete -f configmap.yaml
kubectl delete -f backend.yaml
```

* `kubectl delete -f <파일명>.yaml`을 사용하면 해당 파일에 정의된 모든 리소스를 한꺼번에 제거
* 삭제 순서: 먼저 **상위 의존성 없는(Ingress, Deployment 등)** 리소스를 삭제한 뒤, **PVC, StorageClass** 등 하위 리소스를 제거
* PVC는 삭제 시 `persistentVolumeReclaimPolicy`가 `Retain`으로 설정되어 있으면 볼륨이 남아있음 필요 시 직접 AWS 콘솔에서 EBS 볼륨을 삭제

---

