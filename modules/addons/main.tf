resource "helm_release" "alb" {
  name = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart = "aws-load-balancer-controller"
    namespace = "kube-system"
    set = [ {
      name = "cluserName", value = var.cluster.name
    },
    {
      name = "region", value = var.region
    },
    {
      name = "vpcID", value = var.vpc_id
    }
    ]
}
resource "helm_release" "metrics_server" {
  name = "metrics-server"
  repository = "https://kubernetes.github.io/metrics-server"
    chart = "metrics-server"
    namespace = "kube-system"
}
resource "helm_release" "cluster_autoscaler" {
  name = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart = "cluster-autoscaler"
  namespace = "kube-system"
  set = [ {
    name = "autoDiscovery.clusterName"
    value = var.cluster_name
  },
  {
    name = "awsRegion"
    value = var.region
  },
  ]
}
resource "helm_release" "argocd" {
  name = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = "argocd"
  create_namespace = true
}
resource "helm_release" "monitoring" {
  name = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  namespace = "monitoring"
  create_namespace = true
}

