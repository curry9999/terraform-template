module "prod" {
  source = "../../../modules/ec2"
  env = "prod"
  vpc_cidr_block = "172.16.0.0/16"
  subnet_cidr_block = "172.16.10.0/24"
  network_interface_ips = ["172.16.10.100"]
  subnet_availability_zone = "ap-northeast-1a"
  ec2_instance_type = "t3.micro"
}
