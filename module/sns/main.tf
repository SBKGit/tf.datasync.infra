#create sns topic
resource "aws_sns_topic" "sns_topic" {
  name = "${var.name}-${var.env}-sns-topic"

  tags = {
    Name = var.name
    Environment = var.env
  }
}
