#!/usr/bin/env bash
set -e

# —— 사전 안내 ——
echo "🟢 Monitory Kubernetes 배포 스크립트 시작"
echo "   * kubectl context가 올바른 클러스터를 가리키는지 확인하세요."
echo

# 1) ConfigMap / Secret 생성 (먼저)
echo "1. ConfigMap 및 Secret 생성"
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
echo "   ✅ configmap.yaml, secret.yaml 적용 완료"
echo

# 2) PVC / StorageClass 생성 (InfluxDB용 영속 볼륨)
echo "2. InfluxDB용 PVC/StorageClass 생성"
kubectl apply -f influxdb-volume.yaml
echo "   ✅ influxdb-volume.yaml 적용 완료"
echo

# 3) 데이터베이스 컴포넌트 배포
# echo "3. MySQL, InfluxDB 배포"
# kubectl apply -f mysql.yaml
# echo "   ✅ mysql.yaml 적용 완료"
kubectl apply -f influxdb.yaml
echo "   ✅ influxdb.yaml 적용 완료"
echo

# 4) Kafka+Zookeeper 배포
echo "4. Zookeeper, Kafka, Kafka Connect 배포"
kubectl apply -f zookeeper.yaml
echo "   ✅ zookeeper.yaml 적용 완료"
kubectl apply -f kafka.yaml
echo "   ✅ kafka.yaml 적용 완료"
kubectl apply -f kafka-connect.yaml
echo "   ✅ kafka-connect.yaml 적용 완료"
echo

# 5) 모니터링/시각화 툴 배포 (Chronograf, Grafana, Flink)
echo "5. Chronograf, Grafana, Flink 배포"
kubectl apply -f chronograf.yaml
echo "   ✅ chronograf.yaml 적용 완료"
kubectl apply -f grafana.yaml
echo "   ✅ grafana.yaml 적용 완료"
kubectl apply -f flink.yaml
echo "   ✅ flink.yaml 적용 완료"
echo

sleep 5  # 잠시 대기 (리소스 생성 안정성 확보를 위해)

# 6) 백엔드(Backend) + Ingress 배포
echo "6. Backend(Spring Boot) 및 Ingress 배포"
kubectl apply -f backend.yaml
echo "   ✅ backend.yaml 적용 완료"
kubectl apply -f ingress.yaml
echo "   ✅ ingress.yaml 적용 완료"
echo

# 7) 초기화 Job (DB / Kafka Connect 초기화) 실행
echo "7. Init Job 배포 (influxDB 초기화, Kafka Connect Sink 등록)"
kubectl apply -f init.yaml
echo "   ✅ init.yaml 적용 완료"
echo

echo "🟢 모든 리소스가 정상적으로 생성(Apply)되었습니다."
