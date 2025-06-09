#!/bin/bash

set -e

# 1. Helm 릴리즈 삭제 (모든 차트)
echo "=== Helm 릴리즈 삭제 ==="
for chart in */; do
  if [ -f "$chart/Chart.yaml" ]; then
    release=$(basename "$chart")
    echo "--- $release 릴리즈 삭제 중 ---"
    helm uninstall "$release" || true
    echo
  fi
done

# # 2. ConfigMap, Secret 삭제
# echo "=== ConfigMap, Secret 삭제 ==="
# if [ -f configmap.yaml ]; then
#   kubectl delete -f configmap.yaml --ignore-not-found
# fi
# if [ -f secret.yaml ]; then
#   kubectl delete -f secret.yaml --ignore-not-found
# fi

echo "=== 전체 삭제 완료 ==="
