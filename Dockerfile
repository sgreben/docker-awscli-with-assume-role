FROM python:alpine

# get AWS CLI
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /.aws/cli/cache && \
    chown -R nobody:nobody /.aws && \
    chmod -R a+rwx /.aws

# set up the assume-role wrapper
COPY --chown=nobody:nobody aws.sh /wrapper/aws
RUN chmod a+x /wrapper/aws
ENV PATH=/wrapper:${PATH}
