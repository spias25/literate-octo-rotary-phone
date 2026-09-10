variable "region" { type = string }
variable "project" { type = string }
variable "environment" { type = string }
variable "cluster_name" { type = string }
variable "kubernetes_version" { type = string }
variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "public_subnet_cidrs" { type = list(string) }
variable "instance_type" { type = list(string) }
variable "node_min" { type = number }
variable "node_desired" { type = number }
variable "node_max" { type = number }
variable "github_org" { type = string }
variable "github_repo" { type = string }

