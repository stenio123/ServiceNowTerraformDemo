# ServiceNow Terraform Demo
This demo shows how Terraform modules can be used to abstract DB creation and password access from users, while still allowing an app to reference the password of this DB.

## Note
This repo has two git tag versions:
v1.0: Can be used by itself for testing
v2.0: Is meant to be used alongside Terraform Cloud with private module registry
v3.0: Is meant to be used with Terraform Cloud integrated with ServiceNow 

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