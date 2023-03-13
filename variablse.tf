
variable "cidr" {
  type = string
}

variable "provider_region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "ECR_name" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "EKS_instance_types" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "public_subnet_tags" {
  type = map(string)
}

variable "private_subnet_tags" {
  type = map(string)
}


variable "namespace" {
  type    = string
  default = "argocd"
}


variable "ingress_enabled" {
  type    = bool
  default = false
}

variable "ingress_host" {
  type    = string
  default = ""
}

variable "ingress_path" {
  type    = string
  default = "/"
}