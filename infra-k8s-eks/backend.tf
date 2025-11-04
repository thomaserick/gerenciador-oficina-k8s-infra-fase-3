# terraform {
#   backend "s3" {
#     bucket = "gerenciador-oficina-fiap"
#     key    = "eks/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt = true
#     use_lockfile = true
#   }
# }