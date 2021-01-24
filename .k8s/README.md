# local development

This is super-basic at the moment and assumes you're using something like [microk8s.io](https://microk8s.io) locally.

Setup your local hosts file (`/etc/hosts` on unix-like systems) to resolve `raisingable` to your clusterIP. If you're running microk8s, this is your machine's primary IP address.

```
192.168.1.10 raisingable
```

```
microk8s kubectl apply -f local-deploy.yaml
```

nginx ingress will do the rest.