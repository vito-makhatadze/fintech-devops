# Define the Kubernetes namespace for kyc-dev
resource "kubernetes_namespace" "kyc_dev" {
  metadata {
    name = var.namespace_kyc
  }
}

# Deploy ArgoCD via Helm for GitOps management
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.8"
  namespace  = "argocd"
  create_namespace = true
  values = [
    yamlencode({
      server = {
        service = {
          type = "ClusterIP"  # Use ClusterIP for local Minikube
        }
        extraArgs = [
          "--insecure"
        ]
      }
      configs = {
        params = {
          "server.insecure" = true
        }
      }
    })
  ]
}

# Deploy Vault in dev mode for testing
resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.28.1"
  namespace  = "vault"
  create_namespace = true
  set {
    name  = "server.dev.enabled"
    value = "true"
  }
}

# Define ArgoCD Application for kyc-service
resource "kubernetes_manifest" "kyc_service_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "kyc-service"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/your-username/fintech-devops.git"
        path           = "k8s-manifests/georgia/dev"
        targetRevision = "main"
        kustomize = {}
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.namespace_kyc
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
  depends_on = [helm_release.argocd]
}

# Optional: Deploy a local image pull secret if needed (e.g., for GHCR)
resource "kubernetes_secret" "ghcr_secret" {
  metadata {
    name      = "ghcr-secret"
    namespace = var.namespace_kyc
  }
  type = "kubernetes.io/dockerconfigjson"
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "ghcr.io" = {
          username = var.docker_username
          password = var.docker_password
          auth     = base64encode("${var.docker_username}:${var.docker_password}")
        }
      }
    })
  }
}