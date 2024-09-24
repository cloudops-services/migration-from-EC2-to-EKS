variable "eks_cluster_role_name" {
  description = "IAM Role name for the EKS cluster"
  type        = string
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "eks_node_role_name" {
  description = "IAM Role name for the EKS node group"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "instance_types" {
  description = "Instance types for the EKS node group"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired size of the node group"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the node group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the node group"
  type        = number
}
