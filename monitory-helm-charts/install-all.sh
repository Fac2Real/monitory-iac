#!/bin/bash

set -e

# 1. ConfigMap, Secret 먼저 배포
echo "=== ConfigMap, Secret 배포 ==="
if [ -f configmap.yaml ]; then
  kubectl apply -f configmap.yaml
else
  echo "configmap.yaml 파일이 없습니다."
fi

if [ -f secret.yaml ]; then
  kubectl apply -f secret.yaml
else
  echo "secret.yaml 파일이 없습니다."
fi

echo

# 2. 모든 Helm 차트 배포
echo "=== Helm 차트 배포 ==="
for chart in */; do
  if [ -f "$chart/Chart.yaml" ]; then
    release=$(basename "$chart")
    echo "--- $release 차트 배포 중 ---"
    helm upgrade --install "$release" "./$chart"
    echo
  fi
done

echo "=== 전체 배포 완료 ==="
