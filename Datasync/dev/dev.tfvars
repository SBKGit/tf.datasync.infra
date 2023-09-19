name          = "datasync"
env           = "dev"
aws_region    = "eu-west-2"
instance_type = "m5.2xlarge"
key_name      = ""
max_size      = 1
min_size      = 1
desired_size  = 1
service_name  = ["ec2.amazonaws.com"]
managed_arn   = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"]
ingress_rules = {
  rule1 = {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
  rule2 = {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
  rule3 = {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
  rule4 = {
    from_port       = 1024
    to_port         = 1064
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
}

egress_rules = {
  rule1 = {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
}

#vpc endpoint variables 

vpc_endpoint_type = "Interface"

#datasync agent variables

agent_ingress_rules = {
  rule1 = {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []

  }
  rule2 = {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
  rule3 = {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
    rule4 = {
    from_port       = 1024
    to_port         = 1064
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = []
  }
}

agent_egress_rules = {
  rule1 = {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
}
