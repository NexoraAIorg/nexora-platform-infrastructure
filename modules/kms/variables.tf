variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "deletion_window_in_days" {
  type    = number
  default = 7
}

variable "common_tags" {
  type    = map(string)
  default = {}
}