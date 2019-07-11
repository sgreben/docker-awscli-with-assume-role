# awscli-with-assume-role

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/sgreben/awscli-with-assume-role.svg) [![Docker Repository on Quay](https://quay.io/repository/sgreben/awscli-with-assume-role/status "Docker Repository on Quay")](https://quay.io/repository/sgreben/awscli-with-assume-role) [![pipeline status](https://gitlab.com/sgreben/docker-awscli-with-assume-role/badges/master/pipeline.svg)](https://gitlab.com/sgreben/docker-awscli-with-assume-role/pipelines)

Run `aws` CLI commands under an assumed role (defined by the value of the environment variable `ASSUME_ROLE_ARN`).

Latest releases of `awscli` are automatically tracked, updated in [./requirements.txt](requirements.txt), and built as tagged Docker images (e.g. `sgreben/awscli-with-assume-role:1.16.193`) using [Renovate](https://renovatebot.com), [Gitlab CI](https://gitlab.com/sgreben/docker-awscli-with-assume-role/pipelines), and [Quay.io](https://quay.io/repository/sgreben/awscli-with-assume-role?tab=builds)/[DockerHub](https://hub.docker.com/r/sgreben/awscli-with-assume-role/builds).

## Usage

```
docker pull sgreben/awscli-with-assume-role
```

```
export ASSUME_ROLE_ARN=arn:aws:iam::123456789012:role/demo
docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e ASSUME_ROLE_ARN \
    sgreben/awscli-with-assume-role \
    aws sts get-caller-identity # prints arn:aws:iam::123456789012:role/demo if the AssumeRole call was successful
```
