# resource "google_container_cluster" "alpha" {
#   name     = "alpha"
#   location = "us-central1-a"

#   # We can't create a cluster with no node pool defined, but we want to only use
#   # separately managed node pools. So we create the smallest possible default
#   # node pool and immediately delete it.
#   remove_default_node_pool = true
#   initial_node_count       = 1

#   addons_config {
#     http_load_balancing {
#       disabled = true
#     }

#     horizontal_pod_autoscaling {
#       disabled = false
#     }
#   }
# }

# resource "google_container_node_pool" "alpha_pool_general" {
#   name       = "general"
#   location   = "us-central1-a"
#   cluster    = google_container_cluster.alpha.name
#   node_count = 0

#   node_config {
#     spot = true
#     machine_type = "e2-small"

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = google_service_account.default.email
#     oauth_scopes    = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }

# output "kubernetes_cluster_name" {
#   value       = google_container_cluster.alpha.name
#   description = "GKE Cluster Name"
# }

# output "kubernetes_cluster_host" {
#   value       = google_container_cluster.alpha.endpoint
#   description = "GKE Cluster Host"
# }
