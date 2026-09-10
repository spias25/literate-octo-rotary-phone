variable "cluster_name" {
  type = string
}
variable "kubernetes_version" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "instance_types" {
  type = list(string)
}
variable "main_size" {
  type = number
}
variable "desired_size" {
  type = number
}
variable "maz_size" {
  type = number
}
variable "tags" {
  type = map(string)
}
