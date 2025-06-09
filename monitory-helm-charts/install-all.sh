#!/bin/bash
set -e

# 1. ConfigMap, Secret 먼저 배포
echo "=== ConfigMap, Secret 배포 ==="
kubectl apply -f configmap.yaml 2>/dev/null || echo "configmap.yaml 없음"
kubectl apply -f secret.yaml    2>/dev/null || echo "secret.yaml 없음"
echo

# 2. 모든 Helm 차트 배포
echo "=== Helm 차트 배포 ==="
for chart in */; do
  [ -f "$chart/Chart.yaml" ] || continue
  release=$(basename "$chart")

  # ingress만 별도 분기
  if [ "$release" = "ingress" ]; then
    if kubectl get ingress monitory-ingress -n default &>/dev/null; then
      echo "--- ingress 리소스가 이미 존재하므로 스킵합니다 ---"
      continue
    fi
  fi

  echo "--- $release 차트 배포 중 ---"
  helm upgrade --install "$release" "./$chart"
  echo
done

echo "=== 전체 배포 완료 ==="
