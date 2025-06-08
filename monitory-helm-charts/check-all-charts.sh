#!/bin/bash
set -x

CHARTS_DIR="."
RELEASE_PREFIX="testrelease"

echo "=== Helm Chart 검증 스크립트 시작 ==="
echo "대상 디렉토리: $CHARTS_DIR"
echo

for chart in "$CHARTS_DIR"/*; do
  if [ -d "$chart" ] && [ -f "$chart/Chart.yaml" ]; then
    chart_name=$(basename "$chart")
    echo "---------------------------------------------"
    echo "▶ 차트: $chart_name"
    echo

    echo "[helm lint] $chart_name"
    helm lint "$chart"
    echo

    echo "[helm template] $chart_name"
    helm template "$RELEASE_PREFIX-$chart_name" "$chart"
    echo

    echo "[helm install --dry-run --debug] $chart_name"
    helm install "$RELEASE_PREFIX-$chart_name" "$chart" --dry-run --debug
    echo

    echo "---------------------------------------------"
    echo
  fi
done

echo "=== 모든 차트 검증 완료 ==="
