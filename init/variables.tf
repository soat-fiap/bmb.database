variable "username" {
  default = "tcuser"
}

variable "password" {
  default = "F#P9ia-3-default"
}

variable "engine" {
  default = "mysql"
}

variable "host" {
  default = "techchallenge-mysql-tf.cluster-local.us-east-1.rds.amazonaws.com"
}

variable "port" {
  default = 3306
}

variable "dbClusterIdentifier" {
  default = "techchallenge-mysql-local"
}