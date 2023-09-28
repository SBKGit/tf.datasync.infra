name          = "test_1"
env           = "dev"
aws_region    = "eu-west-2"
instance_type = "t2.medium"
max_size      = 1
min_size      = 1
desired_size  = 1
service_name  = ["ec2.amazonaws.com"]
public_ip     = true
key_name      = ""
managed_arn   = []
ingress_rules = {
  rule1 = {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
  rule2 = {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
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
