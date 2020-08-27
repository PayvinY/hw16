terraform {
  required_version = ">= 0.13"
}
provider "aws" {
  profile = var.profile 
  region  = "us-east-1"
  version = "3.1.0"
}

module quickinstance {
  count         = 1
  source        = "./modules/quickinstance"
#  ami_id        = "${var.ami_id}"  
#  ami_id        = "ami-0bcc094591f354be2"  
#  instance_type = "${var.instance_type}"
#  instance_type = "t2.micro"
#  eip_attach    = false
}

output instance_pub_ips {
  value       = module.quickinstance[*].instance_pub_ip
  sensitive   = false

}
