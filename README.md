* [Learn IAC for data engineering with Terraform](#learn-iac-for-data-engineering-with-terraform)
    * [Setup](#setup)
        * [Prerequisites](#prerequisites)
        * [Grant permissions to your AWS cli Account](#grant-permissions-to-your-aws-cli-account)
            * [Create an IAM user](#create-an-iam-user)
            * [Create an Inline Policy](#create-an-inline-policy)
            * [Grant Full S3, EC2, IAM access to the Inline Policy](#grant-full-s3-ec2-iam-access-to-the-inline-policy)
    * [Create infrastructure](#create-infrastructure)
    * [Destroy infrastructure](#destroy-infrastructure)

# Learn IAC for data engineering with Terraform

Code for blog: [Infrastructure-as-code for Data Engineers with Terraform](https://www.startdataengineering.com/post/iac-for-data-engineering-terraform)

## Setup 

### Prerequisites

1. [AWS Account with root access](https://signin.aws.amazon.com/signup?request_type=register)
2. [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
4. [AWS cli setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

### Grant permissions to your AWS cli Account

#### Create an IAM user 

![Create IAM User](./create_iam_user.png)

#### Create an Inline Policy 

![Add Inline Policy](./add_inline_policy.png)

#### Grant Full S3, EC2, IAM access to the Inline Policy

![Grant S3, EC2, IAM full access](./s3_ec2_iam_all_access.png)

> [!CAUTION]
> This is not recommended for production use cases


## Create infrastructure 

Initialize terraform as shown below 

> [!WARNING]
> Change the bucket name at [main.tf](./terraform/main.tf)

```bash 
terraform -chdir=terraform init 
terraform -chdir=terraform validate 
terraform -chdir=terraform fmt 
terraform -chdir=terraform apply
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
cat terraform/terraform.tfstate |jq -r '.resources[] | [.type, .name] | join(",")'
# or 
terraform -chdir=terraform state list
```

## Destroy infrastructure 

Once done, don't forget to destroy infrastructure as shown below.

```bash 
terraform -chdir=terraform destroy
```
