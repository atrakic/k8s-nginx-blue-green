#!/usr/bin/env bash
set -o errexit

kind create cluster --config config/kind.yaml --wait 60s || true
kind version

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

kubectl apply -f k8s/blue
kubectl apply -f k8s/green
kubectl wait --for=condition=Ready pods --timeout=300s -l "app=nginx"

kubectl apply -f k8s/svc.yml
kubectl apply -f k8s/ing.yml
sleep 1
#curl -i -D- http://localhost:80 -H "Host: www.demo.io"
