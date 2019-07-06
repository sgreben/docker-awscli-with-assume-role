FROM python:3.7.3-alpine3.10
ARG CLI_VERSION=1.16.190

# get AWS CLI and its dependencies (groff)
RUN apk -uv add --no-cache groff
RUN pip install --no-cache-dir awscli=="${CLI_VERSION}"

RUN mkdir -p /.aws/cli/cache && \
    chown -R nobody:nobody /.aws && \
    chmod -R a+rwx /.aws

# set up /etc/profile
RUN mv /usr/local/bin/aws /usr/bin/aws
COPY --chown=nobody:nobody aws.sh /usr/local/bin/aws
RUN chmod a+x /usr/local/bin/aws
