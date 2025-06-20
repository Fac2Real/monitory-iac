# Monitory IaC (Infrastructure as Code) 레포지토리

이 레포지토리는 **Monitory**의 Kubernetes 인프라 및 Helm 차트 배포를 코드로 관리하는 IaC(Infrastructure as Code) 저장소입니다.  
AWS EKS 환경에서 데이터베이스, 메시징, 모니터링, 백엔드, 네트워크 등 다양한 컴포넌트를 효율적으로 배포/운영/관리할 수 있도록 설계되었습니다.

---

## 목차

1. [레포지토리 구조](#레포지토리-구조)
2. [주요 구성요소 및 역할](#주요-구성요소-및-역할)
3. [사전 준비 사항](#사전-준비-사항)
4. [배포 방법](#배포-방법)
5. [삭제(정리) 방법](#삭제정리-방법)
6. [Helm 차트 관리](#helm-차트-관리)
7. [운영 팁](#운영-팁)
8. [참고: IAM, ALB, EBS 등 외부 리소스](#참고-iam-alb-ebs-등-외부-리소스)

---

## 레포지토리 구조

```
.
├── .gitignore
├── configmap-argocd-rbac-cm.yaml
├── values-alb.yaml
├── values-argocd.yaml
├── values-ebs-csi-driver.yaml
├── applications/
│   ├── monitoring.yaml
│   ├── monitory.yaml
│   └── monitory-app/
├── kubernetes/
│   ├── backend.yaml
│   ├── chronograf.yaml
│   ├── deploy.sh
│   ├── destroy.sh
│   ├── flink.yaml
│   ├── grafana.yaml
│   ├── influxdb-volume.yaml
│   ├── influxdb.yaml
│   ├── ingress.yaml
│   ├── init.yaml
│   ├── kafka-connect.yaml
│   ├── kafka.yaml
│   ├── mysql.yaml
│   ├── readme.md
│   └── zookeeper.yaml
├── monitory-helm-charts/
│   ├── check-all-charts.sh
│   ├── install-all.sh
│   ├── uninstall-all.sh
│   └── ... (각종 Helm 차트 디렉터리)
├── permanent/
│   └── ... (영구적 리소스)
├── temporary/
│   └── ... (임시 리소스)
```

---

## 주요 구성요소 및 역할

### 1. 루트 파일

- **configmap-argocd-rbac-cm.yaml**: ArgoCD RBAC 설정용 ConfigMap
- **values-alb.yaml**: AWS ALB Ingress Controller Helm 차트 values 예시
- **values-argocd.yaml**: ArgoCD Helm 차트 values 예시
- **values-ebs-csi-driver.yaml**: AWS EBS CSI Driver Helm 차트 values 예시

### 2. `applications/`

- ArgoCD 등 GitOps 도구에서 사용하는 Application 선언 및 관련 리소스

### 3. `kubernetes/`

- **각종 서비스별 YAML**: DB, 메시징, 모니터링, 백엔드, 네트워크 등 모든 주요 리소스 선언
- **deploy.sh**: 전체 리소스 일괄 배포 스크립트
- **destroy.sh**: 전체 리소스 일괄 삭제(정리) 스크립트
- **readme.md**: 구성요소별 상세 설명 및 운영 가이드

### 4. `monitory-helm-charts/`

- **install-all.sh**: 모든 Helm 차트 일괄 설치
- **uninstall-all.sh**: 모든 Helm 차트 일괄 삭제
- **check-all-charts.sh**: 모든 Helm 차트 유효성 검사
- **각종 차트 디렉터리**: 서비스별 Helm 차트 소스

### 5. `permanent/`, `temporary/`

- **permanent/**: 장기적으로 유지되는 리소스
- **temporary/**: 임시로 사용하는 리소스

---

## 사전 준비 사항

1. **kubectl, helm, awscli** 등 필수 CLI 도구 설치
2. **AWS EKS 클러스터** 및 **kubectl context** 정상 연결 확인
3. **IAM 역할/정책**: ALB Controller, EBS CSI Driver 등 외부 리소스용 IAM 역할/정책 사전 생성 필요
4. **(선택) ArgoCD 등 GitOps 도구**: `applications/` 활용 시

---

## 배포 방법

### 1. kubernetes/ 디렉터리 기반 수동 배포

```bash
cd kubernetes/
./deploy.sh
```

- `deploy.sh`는 ConfigMap/Secret → PVC/Storage → DB/메시징/모니터링/백엔드/네트워크 순서로 모든 리소스를 배포합니다.
- 개별 리소스만 배포하려면 `kubectl apply -f <파일명.yaml>` 사용

### 2. Helm 차트 기반 배포

```bash
cd monitory-helm-charts/
./install-all.sh
```

- `install-all.sh`는 ConfigMap/Secret 적용 후, 모든 Helm 차트를 순차적으로 설치합니다.
- 개별 차트만 설치하려면 `helm install <릴리즈명> <차트경로> -f <values.yaml>` 사용

### 3. ArgoCD 등 GitOps 연동

- `applications/` 내 Application YAML을 ArgoCD에 등록하여 GitOps 방식으로 배포 자동화 가능

---

## 삭제(정리) 방법

### 1. kubernetes/ 리소스 일괄 삭제

```bash
cd kubernetes/
./destroy.sh
```

- `destroy.sh`는 Init Job → Backend → 모니터링/시각화 → DB/메시징 → 네트워크 → 기타 순서로 리소스를 안전하게 삭제합니다.

### 2. Helm 차트 일괄 삭제

```bash
cd monitory-helm-charts/
./uninstall-all.sh
```

- 모든 Helm 릴리즈를 삭제합니다.

### 3. 수동 삭제 예시

```bash
kubectl delete -f backend.yaml
kubectl delete -f influxdb.yaml
# ... 기타 리소스
```

---

## Helm 차트 관리

- **install-all.sh**: 전체 차트 설치
- **uninstall-all.sh**: 전체 차트 삭제
- **check-all-charts.sh**: 모든 차트의 `helm lint` 실행 (유효성 검사)
- **values-\*.yaml**: 각종 Helm 차트의 커스텀 파라미터 정의

### Helm values 파일 예시

- [values-alb.yaml](values-alb.yaml): ALB Ingress Controller용
- [values-ebs-csi-driver.yaml](values-ebs-csi-driver.yaml): EBS CSI Driver용

---

## 운영 팁

- **ConfigMap/Secret**: 환경변수, 민감정보는 반드시 분리 관리
- **PVC/StorageClass**: DB, 메시징 등 데이터 서비스는 EBS 등 영속 볼륨 사용
- **초기화 Job**: DB/유저/권한 자동 생성, Kafka Connect 자동 등록 등 자동화
- **네트워크**: Ingress(ALB), Service(ClusterIP/NodePort/Headless)로 트래픽 라우팅
- **Helm 차트**: values 파일로 환경별 커스터마이징, 릴리즈명 관리 주의
- **삭제 시 주의**: ALB, EBS 등 AWS 리소스는 Helm/Kubernetes 삭제 후에도 남아있을 수 있으니 별도 정리 필요

---

## 참고: IAM, ALB, EBS 등 외부 리소스

### 1. ALB Ingress Controller 설치 예시

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm install aws-load-balancer-controller \
  eks/aws-load-balancer-controller \
  -n kube-system \
  -f values-alb.yaml
```

- `serviceAccount.create: false`인 경우, IRSA 기반 ServiceAccount(`aws-load-balancer-controller`)를 미리 생성해야 함

### 2. EBS CSI Driver 설치 예시

```bash
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update
helm install aws-ebs-csi-driver \
  aws-ebs-csi-driver/aws-ebs-csi-driver \
  -n kube-system \
  -f values-ebs-csi-driver.yaml
```

- `serviceAccount.create: false`인 경우, IRSA 기반 ServiceAccount(`ebs-csi-controller-sa`)를 미리 생성해야 함

---

## 참고 문서

- [kubernetes/readme.md](kubernetes/readme.md): 각 리소스별 상세 설명, 운영 가이드, 예시 등
- [Helm 공식 문서](https://helm.sh/docs/)
- [AWS EKS 공식 문서](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)

---

**문의/기여/이슈는 PR 또는 Issue로 남겨주세요.**
