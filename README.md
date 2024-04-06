# k8s-nginx-blue-green

**Blue/green deployment technique for a single service using ConfigMaps and [Nginx Ingress controller](https://github.com/kubernetes/ingress-nginx).**

[![ci](https://github.com/atrakic/k6-nginx-blue-green/actions/workflows/ci.yml/badge.svg)](https://github.com/atrakic/k6-nginx-blue-green/actions/workflows/ci.yml)


## Deployment
- Version B(green) is deployed alongside version A (blue) with exactly the same amount of
instances:

```bash
$ make all
```

- Traffic can be switched from version A to version B.
```bash
$ make ping
```

## Test
Use [k6][https://k6.io/] and test that new version meets all the requirements:

```bash
$ make test
```

# If everything is working as expected, you can then delete old version:

```bash
$ kubectl delete deployments.apps blue
```

# Clean up

```bash
$ make clean
```
