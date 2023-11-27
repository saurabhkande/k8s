resource "google_container_cluster" "primary" {
  name               = var.name
  location           = var.location
  initial_node_count = 2
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      name = "argo-gke"
    }
    tags = ["name", "argo-gke"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }

  /*provisioner "local-exec" {
    command = <<-EOT
    "kubectl create namespace argocd"
	  "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
    EOT
  }
  */
}

resource "null_resource" "apply_manifests" {
  depends_on = [google_container_cluster.primary]

  provisioner "local-exec" {
    command = "kubectl create namespace argocd"
	   
  }
}

resource "null_resource" "apply_manifests_2" {
  depends_on = [google_container_cluster.primary]

  provisioner "local-exec" {
    command = "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
    
  }
}


