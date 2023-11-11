# infra
My personal cloud infrastructure as code.


## Install
1. Install Gcloud, Terraform, and Kubectl.
2. `gcloud auth application-default login`
3. In `cluster/`, run `tf init` then `tf apply` to build the cluster.
4. Run `gcloud container clusters get-credentials CLUSTER_NAME --region=CLUSTER_REGION` to create a `kubeconfig` for your `kubectl`.