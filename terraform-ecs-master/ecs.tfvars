
environment = "Danylo"

aws_profile = "default"

aws_region = "eu-west-1"

aws_ecs_ami = "ami-0d75513e7706cf2d9"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]

private_subnet_cidrs = ["10.0.50.0/24", "10.0.51.0/24"]

availability_zones = ["eu-west-1a", "eu-west-1b"]

max_size = 3

min_size = 1

desired_capacity = 2

instance_type = "t2.micro"
