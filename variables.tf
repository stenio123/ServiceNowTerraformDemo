variable "vault_url" {
  description = "Placeholder for a module output name"
  default =""
}
variable "vault_username" {
  description = "Placeholder for another module output name"
  default =""
}
variable "vault_userpass" {
  description = "Placeholder for another module output name"
  default =""
}
variable "vault_secret_path" {
  description = "Secret path for db secret"

}
variable "vault_aws_role" {
  description = "AWS role for Vault to create"

}
variable "vault_aws_secret_path" {
  description = "AWS secret path in Vault"

}

variable "db_ip_addr" {
  description = "DB URL"
}