# awscli-with-assume-role

[![Docker Repository on Quay](https://quay.io/repository/sisuite/awscli-with-assume-role/status "Docker Repository on Quay")](https://quay.io/repository/sisuite/awscli-with-assume-role) [![Build Status](https://travis-ci.com/sgreben/docker-awscli-with-assume-role.svg?branch=master)](https://travis-ci.com/sgreben/docker-awscli-with-assume-role)

Run `aws` CLI commands under an assumed role (defined by the value of the environment variable `ASSUME_ROLE_ARN`).

Latest releases of `awscli` are automatically tracked, updated in [./requirements.txt](requirements.txt), and built as tagged Docker images (e.g. `quay.io/sisuite/awscli-with-assume-role:1.16.193`) using [Renovate](https://renovatebot.com), [Travis CI](https://travis-ci.com/sgreben/docker-awscli-with-assume-role), and [Quay.io](https://quay.io/repository/sisuite/awscli-with-assume-role?tab=builds).

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
