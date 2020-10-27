data "aws_secretsmanager_secret" "my_wordpress_secret" {
  name = "my_wordpress_secret"
}

data "aws_secretsmanager_secret_version" "example" {
  secret_id = data.aws_secretsmanager_secret.my_wordpress_secret.id
}

# output "my_wordpress_secrets" {
#   value = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)["password"]
# }

