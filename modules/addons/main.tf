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
resource "helm_release" "matrics_server" {
  name = "metrics-server"
  repository = "https://kubernetes.github.io/metrics-server"
    chart = "metrics-server"
    namespace = "kube-system"
}
resource "helm_release" "cluster_autoscaler" {
  
}