variable "region" {
  type = string
  description = "Specify the region in AWS you want to deploy to."
  default = "us-east-1"
}

variable "redshift_cluster_identifier" {
  type = string
  description = "Specify the cluster identifier"
  default = "redshift-cluster-1"
}