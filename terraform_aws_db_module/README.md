# Terraform AWS DB Module
This is an example to be used with the Terraform Cloud/ ServiceNow demo.
In a real world scenario this folder would be in a separate repository managed by the Cloud Architects responsible for managing module lifecycle and ServiceNow integration.

## Description
This is a basic module that creates a AWS RDS using a random string as secret, and stores this secret in AWS Secrets Manager.

It then outputs the DB url, and the reference to the secret. 

The idea is that a client would reference this output in its code, so that the terraform code has permission and can retrieve this secret without user having access to it.