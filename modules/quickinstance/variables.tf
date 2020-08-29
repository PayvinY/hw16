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
#    condition     = can(regex("^\w\d\.(\w+\d+)?:wq(nano|micro|small|medium|large|metal)$", var.instance_type))
    condition     = can(regex("[tmacrfgpxzdihi][1-6].(nano|micro|small|medium|large|metal)$", var.instance_type))
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
#variable "private_key" {
#  default = "~/new2"
#}

variable "pub_key_path" {
#  type = string
  default = "/home/oem/hillel.pem"
}

#    condition     = can(regex("^(?\d+\.*", var.instance_type))
# can(regex(("^inf1" or "^t[23]" or "^m[4-6]" or "^a1" or "^c[4-6]" or "^r[45]" or "^f1" or "^g[2-4]" or "^p[23]" or "^x1" or "^z1" or "^d2" or "^i2" or "^h1" or "^i3") && ("?" or "a" or "ad" or "g" or "gd" or "d" or "dn" or "e" or "en" or "n") && "\." && ("?" or "2" or "4" or "8" or "16" or "32" or "64" or "128" or "256") && ("nano" or "micro$" or "small$" or "medium$" or "large$" or "xlarge$" or "metal$") , var.ins))
#     AllowedPattern: "^(?!.*?['\"\\/ @])(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).*{8,32}$"
#    ConstraintDescription: >-
#      AdminPassword must be at least 8 characters long and must contain at least
#      one uppercase character, one lowercase character, and one digit. It must
#      not contain ', ", \, /, @ or spaces. It must not exceed 32 characters in"
#      length.
