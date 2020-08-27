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
}

output instance_pub_ips {
  value       = module.quickinstance[*].instance_pub_ip
  sensitive   = false

}
