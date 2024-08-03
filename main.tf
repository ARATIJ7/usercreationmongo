provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "mongodb" {
  count         = 3  # Create three instances
  ami           = var.ami_id  # Amazon Linux 2 AMI
  instance_type = var.instance_type

  user_data = templatefile("${path.module}/userdata.sh", {
    count_index     = count.index,
    admin_user      = var.admin_user,
    admin_pass      = var.admin_pass,
    database2       = var.database2,
    readwrite_user  = var.readwrite_user,
    readwrite_pass  = var.readwrite_pass,
    database3       = var.database3,
    readonly_user   = var.readonly_user,
    readonly_pass   = var.readonly_pass
  })

  tags = {
    Name = "MongoDBInstance${count.index}"
  }

  # Create a security group that allows SSH and MongoDB access
  vpc_security_group_ids = [aws_security_group.mongodb_sg.id]

  # Specify a key pair for SSH access
  key_name = var.key_name
}

resource "aws_security_group" "mongodb_sg" {
  name        = "mongodb_sg"
  description = "Allow SSH and MongoDB access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
