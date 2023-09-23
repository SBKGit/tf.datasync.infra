variable "aws_region" {
  default = ""

}

variable "name" {
  
}

variable "env" {
  
}

variable "endpoint" {
  default        = ""
  description = "(Required) Endpoint to send data to. The contents vary with the protocol. See details below."
}

variable "topic_arn" {
  default     = ""
  description = " (Required) ARN of the SNS topic to subscribe to."

}

variable "protocol" {
  default     = ""
  description = "(Required) Protocol to use. Valid values are: sqs, sms, lambda, firehose, and application."

}

variable "confirmation_timeout" {
  default     = 3
  description = "(Optional) Integer indicating number of minutes to wait in retrying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols. Default is 3."

}

variable "auto_confirms" {
  default     = true
  description = "(Optional) Whether the endpoint is capable of auto confirming subscription (e.g., PagerDuty). Default is True."

}

# variable "enable_filter_policy" {
#   description = "Enable or disable the subscription filter policy"
#   type        = bool
#   default     = false
# }

# variable "filter_policy" {
#   description = "Filter policy for SNS subscription"
#   type        = map(string)
#   default     = {}
# }