# Learn IAC for data engineering with Terraform

## Setup 

### Prerequisites

1. [AWS Account with root access](https://signin.aws.amazon.com/signup?request_type=register)
2. [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
4. [AWS cli setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

Initialize terraform as shown below 

```bash 
terraform -chdir=terraform init
terraform -chdir=terraform validate
terraform -chdir=terraform fmt
```

Check that S3 and EC2 are working as expected.

```bash 
aws s3 ls 
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query 'Reservations[].Instances[].{ID:InstanceId, Name:Tags[?Key==`Name`].Value, Type:InstanceType, State:State.Name, PublicIP:PublicIpAddress, PrivateIP:PrivateIpAddress}' \
  --output table
```

Let's look at the state file 

```bash 
cat terraform/terraform.tfstate |jq -r '.resources[] | [.type, .name] | join(",")''
```
