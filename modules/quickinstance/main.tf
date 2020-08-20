resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.this.id,aws_security_group.that.id]
  key_name = "hillel"
  tags = {
    Name    = "temporary server"
    Purpose = "education"
    Project = "hillel"
  }
}

resource "aws_eip" "this" {
  count = (var.eip_attach ? 1 : 0)
  instance = aws_instance.this.id
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.this.id
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = var.ebs_az
  size = var.ebs_volume_size
#  tags = {
#    Name = "EBS volume for hillel labwork"
#    value = "Default size 8gb"
#  }
}

resource "aws_security_group" "that" {
  name_prefix = "trafic 6100 port"
  ingress {
    description = "Allow TCP port 6100 in trafic"
    from_port = 6100
    to_port = 6100
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow TCP port 6100 out trafic"
    from_port = 6100
    to_port = 6100
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "this" {
  name_prefix = "temporary" 
  ingress {
    description = "Allow SSH fron anywhere"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH fron anywhere"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP fron anywhere"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS fron anywhere"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output instance_pub_ip {
  value       = var.eip_attach ? aws_eip.this[0].public_ip : aws_instance.this.public_ip
}
