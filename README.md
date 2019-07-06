# aws-cli-with-assumed-role

[![Docker Repository on Quay](https://quay.io/repository/sisuite/awscli-with-assume-role/status "Docker Repository on Quay")](https://quay.io/repository/sisuite/awscli-with-assume-role)

Run `aws` CLI commands under an assumed role (defined by the value of the environment variable `ASSUME_ROLE_ARN`).

## Usage

```
docker pull quay.io/sisuite/awscli-with-assume-role
```

```
export ASSUME_ROLE_ARN=arn:aws:iam::123456789012:role/demo
docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e ASSUME_ROLE_ARN \
    quay.io/sisuite/awscli-with-assume-role \
    aws sts get-caller-identity # prints arn:aws:iam::123456789012:role/demo if the AssumeRole call was successful
```
