FROM python:alpine

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /.aws/cli/cache && \
    chown -R nobody:nobody /.aws/cli/cache && \
    chmod -R a+rwx /.aws/cli/cache

COPY --chown=nobody:nobody aws.sh /wrapper/aws
RUN chmod a+x /wrapper/aws
ENV PATH=/wrapper:${PATH}
CMD [ "aws" ]
