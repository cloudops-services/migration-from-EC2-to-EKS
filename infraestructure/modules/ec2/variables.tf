variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name"
  type        = string
}

variable "key_pair_private_key_path" {
  description = "Path to the private key"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}
