variable "ami_id" {
  type        = string
  default     = "ami-0bcc094591f354be2"
  description = "ami ID"
  validation {
    condition     = length(var.ami_id) > 4 && length(var.ami_id) < 22 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"#ami-\". and no more then 21 chapters..."
  }
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "type instance"
  validation {
    condition     = can(regex("[tmacrfgpxzdih][1-6].+(nano|micro|small|medium|large|metal)$", var.instance_type))
    error_message = "You need to input valid ami name ..."
  }
}


variable eip_attach {
  type        = bool
  default     = false
  description = "Selector for ElasticIP: true == create and attach"
}

variable "ebs_volume_size" {
  type        = number
  default     = "8"
  description = "size EBS volume"
  validation {
    condition = var.ebs_volume_size > 1 && var.ebs_volume_size < 16384
    error_message = "The size of volume must be from 1Gb to 16384Gb..."
  }
}

variable "pub_key_path" {
  default = "/home/oem/hillel.pem"
}

