variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "web_instance_type" {
  description = "Type d'instance EC2 pour le serveur web."
  type        = string
  default     = "t2.micro"
}

variable "db_instance_type" {
  description = "Type d'instance EC2 pour le serveur base de donnees."
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name_prefix" {
  description = "Prefixe du nom de la key pair creee par Terraform."
  type        = string
  default     = "deployer-key"
}

variable "ssh_allowed_cidrs" {
  description = "Liste des CIDR autorises en SSH (port 22)."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


