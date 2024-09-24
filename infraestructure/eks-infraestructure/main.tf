
# VPC
module "vpc" {
  source = "../modules/vpc"
  vpc_cidr_block = "172.16.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  name = "production-vpc"
  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}

module "eks_cluster" {
  source               = "../modules/eks"

  eks_cluster_name     = "my-eks-cluster"
  subnet_ids           = module.vpc.public_subnets

  eks_cluster_role_name = "eks-cluster-role"
  eks_node_role_name    = "eks-node-role"

  node_group_name      = "my-eks-node-group"
  instance_types       = ["t3.medium"]

  desired_size         = 2
  min_size             = 1
  max_size             = 3
}


