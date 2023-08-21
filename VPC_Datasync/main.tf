# Create VPC1 (datasync dev)
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC1_datasync_${var.env}"
    Environment = var.env
  }
}

# Create a private subnet in VPC1
resource "aws_subnet" "private_subnet_vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.private_subnet_cidr
 # availability_zone = var.private_subnet_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet VPC1 ${var.env}"
    Environment = var.env
  }
}

# Create IAM role for DataSync agent in VPC1
resource "aws_iam_role" "datasync_instance_role" {
  name = "DataSyncInstanceRole_${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      }
    }]
  })
}

# Attach policies to the DataSync agent role
resource "aws_iam_policy_attachment" "datasync_Instance_policy_attachment" {
  name = "datasync-Instance-${var.env}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Replace with appropriate policy ARN
  roles      = [aws_iam_role.datasync_instance_role.name]
}

# Create IAM role for DataSync agent in VPC1
resource "aws_iam_role" "datasync_task_role" {
  name = "DataSyncTaskRole_${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      "Principal": {
        "Service": [
          "datasync.amazonaws.com"
        ]
      }
    }]
  })
}

# Attach policies to the DataSync agent role
resource "aws_iam_policy_attachment" "datasync_task_policy_attachment" {
  name = "datasync-task-${var.env}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Replace with appropriate policy ARN
  roles      = [aws_iam_role.datasync_task_role.name]
}

# Create a security group for the DataSync service
resource "aws_security_group" "data_sync_sg" {
  name        = "data_sync_security_group"
  description = "Security group for AWS DataSync"
  vpc_id      = aws_vpc.vpc1.id

  # Allow inbound traffic on the necessary ports for DataSync
  ingress {
    from_port   = 111
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow inbound traffic on the necessary ports for DataSync
  egress{
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

## Allow DataSync to communicate with the source and destination endpoints
#resource "aws_security_group_rule" "data_sync_ingress_rule" {
#  type        = "egress"
#  from_port   = 0
#  to_port     = 65535
#  protocol    = "tcp"
#  cidr_blocks = ["0.0.0.0/0"]
#  security_group_id = aws_security_group.data_sync_sg.id
#}

# Create the DataSync Task
#resource "aws_datasync_task" "data_sync_task" {
#  name     = "datasync-task-${var.env}"
#  source_location_arn = "arn:aws:s3:::mysource-bucket-datatf"
#  destination_location_arn = aws_s3_bucket.landing_zone_bucket.arn
#  cloudwatch_log_group_arn = "arn:aws:logs:eu-west-2:993765507703:log-group:/aws/datasync:*"
#
#  options {
#    bytes_per_second       = -1
#    verify_mode            = "${var.datasync_task_options["verify_mode"]}"
#    posix_permissions      = "${var.datasync_task_options["posix_permissions"]}"
#    preserve_deleted_files = "${var.datasync_task_options["preserve_deleted_files"]}"
#    uid                    = "${var.datasync_task_options["uid"]}"
#    gid                    = "${var.datasync_task_options["gid"]}"
#    atime                  = "${var.datasync_task_options["atime"]}"
#    mtime                  = "${var.datasync_task_options["mtime"]}"
#  }
#
#  tags = {
#    Name = "datasync-task-${var.env}",
#    Environment  = var.env
#  }
#}

## Create the source location
#resource "aws_datasync_location_s3" "data_sync_source" {
#  s3_bucket_arn = "arn:aws:s3:::<source_bucket_name>"
#  s3_config {
#    bucket_access_role_arn = "arn:aws:iam::<source_bucket_role_arn>"
#  }
#}

## Create the destination location
#resource "aws_datasync_location_s3" "data_sync_destination" {
#  s3_bucket_arn = "arn:aws:s3:::<destination_bucket_name>"
#  s3_config {
#    bucket_access_role_arn = "arn:aws:iam::<destination_bucket_role_arn>"
#  }
#}

resource "aws_datasync_location_s3" "datasync_task" {
  s3_bucket_arn = aws_s3_bucket.landing_zone_bucket.arn
  subdirectory  = "/example/prefix"

  s3_config {
    bucket_access_role_arn = aws_iam_role.datasync_task_role.arn
  }
}

# Create an S3 bucket in VPC2 for landing zone
resource "aws_s3_bucket" "landing_zone_bucket" {
  bucket = "landing-zone-bucket-${var.env}"  # Replace with your bucket name
  acl    = "private"

  tags = {
    Name = "Landing Zone Bucket"
    Environment = var.env
  }
}


resource "aws_iam_instance_profile" "datasync_profile" {
  name = "DatasyncAgent_${var.env}"
  role = aws_iam_role.datasync_instance_role.name
}

# Create EC2 instance for DataSync agent in VPC1
resource "aws_instance" "datasync_instance" {
  ami           = var.ami_version
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet_vpc1.id
  iam_instance_profile = aws_iam_instance_profile.datasync_profile.name
  tags = {
    Name = "DataSync Instance"
    Environment = var.env
  }
}