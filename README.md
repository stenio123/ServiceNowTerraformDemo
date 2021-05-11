# ServiceNow Terraform Demo
This demo shows how Terraform modules can be used to abstract DB creation and password access from users, while still allowing an app to reference the password of this DB.

## Note
This repo has two git tag versions:
- v1.0: Can be used by itself for testing
- v2.0: Is meant to be used alongside Terraform Cloud with private module registry
- v3.0: Is meant to be used with Terraform Cloud integrated with ServiceNow 
- v4.0: This is meant to be used with Vault, and module provisioned externally, such as with https://github.com/stenio123/TerraformConsumerProducer

## Instructions
### V1.0
Execute 
```
terraform init
terraform apply
```

### v2.0
1. Register terraform_aws_db_module as a module in terraform cloud
2. Create workspace pointing to "app" folder
3. Run apply

### v3.0
1. Configure ServiceNow integration
2. Register terraform_aws_db_module in ServiceNow
3. Create workspace pointing to "app" folder
4. User requests DB creation through ServiceNow interface, and retrieves outputs `db_ip_addr` and `aws_secret_id`
5. User enters these information as input variables in the workspace, either manually or through API calls
6. Run apply

### v4.0
1. Workspace provisioned by https://github.com/stenio123/TerraformConsumerProducer
2. Update Vault variables
3. Run apply

Vault config:
```
vault secrets enable aws

vault write aws/config/root \
    access_key=KEY \
    secret_key=SECRET \
    region=us-east-1

vault write aws/roles/create-ec2 \
    credential_type=iam_user \
    policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOF

vault read aws/creds/create-ec2

# Sample Vault server config
storage "file" {
  path    = "/home/ec2-user/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

ui = true
```