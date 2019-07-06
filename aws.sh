#!/bin/sh -eu

# parameters
arnOfRoleToAssume=$ASSUME_ROLE_ARN
randomRoleSessionName=$(date +%s)
roleSessionName=${ASSUME_ROLE_SESSION_NAME:-$randomRoleSessionName}

eval "$(/usr/local/bin/aws sts assume-role --role-session-name="$roleSessionName" --role-arn="$arnOfRoleToAssume" --output text --query='
  join(`";"`, [
    join(``, [`"export AWS_ACCESS_KEY_ID="`, Credentials.AccessKeyId]),
    join(``, [`"export AWS_SECRET_ACCESS_KEY="`, Credentials.SecretAccessKey]),
    join(``, [`"export AWS_SESSION_TOKEN="`, Credentials.SessionToken])
  ])'
)"

exec /usr/local/bin/aws "$@"
