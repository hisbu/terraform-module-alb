module "instance" {
  source = "github.com/hisbu/terraform-module-ec2.git"

  INSTANCE_COUNT  = 2
  AMI             = "ami-0c20b8b385217763f"
  INSTANCE_TYPE   = "t2.micro"
  SECURITY_GROUPS = ["sg-0b7bb20f90aa0c30f","sg-0634805f2592b1a8d"]
  KEYNAME         = "jcde-key"
  USERDATA        = "./userdata.txt"
  TAG_NAME        = "webapp"
}

module "alb" {
  source = "../module/alb/"

  ALB_NAME = "app-loadbalacer"
  ALB_SCHEME = false
  ALB_TYPE = "application"
  ALB_SG = ["sg-06e0b1274acdecf88"]
  SUBNETS = ["subnet-56bf050f","subnet-34f83752","subnet-8f9768c7"]
  ALB_DELETE_PROTEC = false
  TG_NAME = "tg-tf-grouop"
  TG_PORT = 80
  TG_POROTO = "HTTP"
  VPC_ID =  "vpc-345b4153"
  ALB_PORT = 80
  ALB_PROTO =  "HTTP"
  LISTENER_TYPE = "forward"
  TG_INSTANCE_ID = module.instance.instance_id
  INSTANCE_PORT = 80
}