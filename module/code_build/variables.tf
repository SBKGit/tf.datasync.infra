variable "name" {

}

variable "env" {

}

variable "aws_region" {

}

variable "artifacts_type" {
  default = "NO_ARTIFACTS"
}

variable "build_timeout" {
  default     = "60"
  description = "default time out 1 hour"
}

variable "queued_timeout" {
  default     = "20"
  description = "default time for queue to exit is 20 min"
}

variable "source_dir" {

}

variable "role_arn" {

}

variable "source_type" {
  default = "GITHUB"

}

variable "build_spec" {

}

variable "github_url" {

}