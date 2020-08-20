terraform {
  required_version = ">= 0.13"
}
provider "aws" {
  profile = "payvinroot"
  region  = "us-east-1"
  version = "3.1.0"
}

module quickinstance {
  count         = 1
  source        = "./modules/quickinstance"
  ami_id        = var.ami_id  
  instance_type = var.instance_type
  eip_attach    = false
}

output instance_pub_ips {
  value       = module.quickinstance[*].instance_pub_ip
  sensitive   = false

}
