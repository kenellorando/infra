# infra
My ([kenellorando's](https://github.com/kenellorando)) personal cloud infrastructure as code.

## Directory

```
main/               -   Terraform to build cluster and pet servers.
cluster-service/    -   Scripts to install cluster add-ons.
```

## Install
1. Install Gcloud, Terraform, and Kubectl.
2. `gcloud auth application-default login`
3. In `main/`, run `tf init` then `tf apply` to build.

### Connect to Cluster 
1. Run `gcloud container clusters get-credentials CLUSTER_NAME --region=CLUSTER_REGION` to generate a `kubeconfig` for `kubectl`.
