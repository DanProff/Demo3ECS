provider "aws" {
  region     = var.aws_region
  profile    = var.aws_profile
}

module "ecs" {
  source = "./modules/ecs"

  environment          = var.environment
  cluster              = var.environment
  cloudwatch_prefix    = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  key_name             = aws_key_pair.ecs.key_name
  instance_type        = var.instance_type
  ecs_aws_ami          = var.aws_ecs_ami
}

resource "aws_key_pair" "ecs" {
  key_name   = "ecs-key-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCHf+AA3YFtD0JzZqmuSnu0YTkgtjQgAl8eWw6Z+0HeJmC4k3UjNOwB6LRzzr7HwkwiAda2x0BUo00scUDhp92yB5NJiYIAKAco6/lxHmsv7PqgyLmKOXMiLOPhRSIkv6Y4801OazmoTc7ZGrjobBVM6t7OXw9d+0qFJHBNZ07+MPL0HtPmG+xJsokveuI1L9O1ri1Sh0lVfkNwX0CStXx0J26vzttD+oosrItW2bb3atgpJqytC/c/zJGAh0TKtpteHb4ZYOGOM2/Zy69HY3zyHiZUxh82arlZp/7n58NoqvVafNVNJQhDz6nPGvDXkV8Xd32h9Eu0ResaItm5dVHKF7lIBnvvT2vVNdsiR2GLkZ0UCmetNKIjM0V5jV7+clNhAD2ZnQJ5+N2VAVi9JNkr/2grd7cXxnsoptsKu/DdT2DKWp1pwDF1REvB/XzwXslJGBrj3YezQ74fPaJNMS0TQh8oEUpYx6fkDB615d29vrqd5sHLavNlTCbQM+ZMC9M= ecs@aws.fake"
}

variable "environment" {
  description = "A name to describe the environment we're creating."
}
variable "aws_profile" {
  description = "The AWS-CLI profile for the account to create resources in."
}
variable "aws_region" {
  description = "The AWS region to create resources in."
}
variable "aws_ecs_ami" {
  description = "The AMI to seed ECS instances with."
}
variable "vpc_cidr" {
  description = "The IP range to attribute to the virtual network."
}
variable "public_subnet_cidrs" {
  description = "The IP ranges to use for the public subnets in your VPC."
  type        = list(any)
}
variable "private_subnet_cidrs" {
  description = "The IP ranges to use for the private subnets in your VPC."
  type        = list(any)
}
variable "availability_zones" {
  description = "The AWS availability zones to create subnets in."
  type        = list(any)
}
variable "max_size" {
  description = "Maximum number of instances in the ECS cluster."
}
variable "min_size" {
  description = "Minimum number of instances in the ECS cluster."
}
variable "desired_capacity" {
  description = "Ideal number of instances in the ECS cluster."
}
variable "instance_type" {
  description = "Size of instances in the ECS cluster."
}

output "default_alb_target_group" {
  value = module.ecs.default_alb_target_group
}
