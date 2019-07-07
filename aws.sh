#!/bin/sh -eu

# parameters
arnOfRoleToAssume=$ASSUME_ROLE_ARN
randomRoleSessionName=$(date +%s)
roleSessionName=${ASSUME_ROLE_SESSION_NAME:-$randomRoleSessionName}

temporaryCredentialsEnv() {
  /usr/local/bin/aws sts assume-role \
    --role-session-name="$roleSessionName" \
    --role-arn="$arnOfRoleToAssume" \
    --output text \
    --query='Credentials.[
      join(`=`, [`AWS_ACCESS_KEY_ID`, AccessKeyId]),
      join(`=`, [`AWS_SECRET_ACCESS_KEY`, SecretAccessKey]),
      join(`=`, [`AWS_SESSION_TOKEN`, SessionToken])
    ]'
}

assumeRoleEnv=$(temporaryCredentialsEnv)
exec env $assumeRoleEnv /usr/local/bin/aws "$@"
