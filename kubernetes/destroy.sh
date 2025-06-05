#!/usr/bin/env bash
set -e

# —— 사전 안내 ——
echo "🔴 Monitory Kubernetes 정리 스크립트 시작"
echo

# 1) Init Job 삭제 (먼저)
echo "1. Init Job 삭제"
kubectl delete -f init.yaml --ignore-not-found
echo "   ✅ init.yaml 삭제 완료"
echo

# 2) Ingress / Backend 삭제
# echo "2. Ingress 및 Backend 삭제"
# kubectl delete -f ingress.yaml --ignore-not-found
# echo "   ✅ ingress.yaml 삭제 완료"
kubectl delete -f backend.yaml --ignore-not-found
echo "   ✅ backend.yaml 삭제 완료"
echo

# 3) 모니터링/시각화 툴 삭제 (Chronograf, Grafana, Flink)
echo "3. Chronograf, Grafana, Flink 삭제"
kubectl delete -f flink.yaml --ignore-not-found
echo "   ✅ flink.yaml 삭제 완료"
kubectl delete -f grafana.yaml --ignore-not-found
echo "   ✅ grafana.yaml 삭제 완료"
kubectl delete -f chronograf.yaml --ignore-not-found
echo "   ✅ chronograf.yaml 삭제 완료"
echo

# 4) Kafka Connect / Kafka / Zookeeper 삭제
echo "4. Kafka Connect, Kafka, Zookeeper 삭제"
kubectl delete -f kafka-connect.yaml --ignore-not-found
echo "   ✅ kafka-connect.yaml 삭제 완료"
kubectl delete -f kafka.yaml --ignore-not-found
echo "   ✅ kafka.yaml 삭제 완료"
kubectl delete -f zookeeper.yaml --ignore-not-found
echo "   ✅ zookeeper.yaml 삭제 완료"
echo

# 5) InfluxDB, MySQL 삭제
echo "5. InfluxDB, MySQL 삭제"
kubectl delete -f influxdb.yaml --ignore-not-found
echo "   ✅ influxdb.yaml 삭제 완료"
kubectl delete -f mysql.yaml --ignore-not-found
echo "   ✅ mysql.yaml 삭제 완료"
echo

# 6) Secret / ConfigMap 삭제 (마지막)
echo "6. Secret 및 ConfigMap 삭제"
kubectl delete -f secret.yaml --ignore-not-found
echo "   ✅ secret.yaml 삭제 완료"
kubectl delete -f configmap.yaml --ignore-not-found
echo "   ✅ configmap.yaml 삭제 완료"
echo

echo "🔴 모든 리소스가 정상적으로 삭제되었습니다."
