
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

module "ec2_instance" {
  source = "../modules/ec2"

  ami_id                  = "ami-0ebfd941bbafe70c6"
  instance_type           = "t2.micro"
  key_pair_name           = "my-key-pair"
  key_pair_private_key_path = "../keys/my-key.pem"

  subnet_id              = module.vpc.public_subnets[0]
  security_group_id      = module.vpc.default_security_group_id
  name                   = "my-ec2-instance"
}
