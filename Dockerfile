FROM python:alpine

# get AWS CLI and its dependencies (groff)
RUN apk -uv add --no-cache groff
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /.aws/cli/cache && \
    chown -R nobody:nobody /.aws && \
    chmod -R a+rwx /.aws

# set up /etc/profile
RUN mv /usr/local/bin/aws /usr/bin/aws
COPY --chown=nobody:nobody aws.sh /usr/local/bin/aws
RUN chmod a+x /usr/local/bin/aws
