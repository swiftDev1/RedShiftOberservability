variable "region" {
  type        = string
  description = "Specify the region in AWS you want to deploy to."
  default     = "us-east-1"
}

variable "redshift_cluster_identifier" {
  type        = string
  description = "Specify the cluster identifier"
  default     = "redshift-cluster-1"
}

variable "email_endpoints" {
  description = "Emails to be subscribed to the SNS topic"
  default     = ["hope.chika247@gmail.com", "depathfinder247@gmail.com", "anifowoseun11@gmail.com"]
}