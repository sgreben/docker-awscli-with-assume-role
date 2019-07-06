#!/bin/sh -eu

# parameters
arnOfRoleToAssume=$ASSUME_ROLE_ARN

# naming
initialProfileName=initial # the profile with credentials we use to assume the role
assumeRoleProfileName=assume_role # the sub-profile that forces the role-assumption

# generate shared credentials file for env-defined AWS credentials
awsSharedCredentialsFileForInitialCredentials="$(mktemp)";
cat > "$awsSharedCredentialsFileForInitialCredentials" <<EOF
[$initialProfileName]
EOF
if [ -n "${AWS_ACCESS_KEY_ID:-}" ]; then
cat >> "$awsSharedCredentialsFileForInitialCredentials" <<EOF
aws_access_key_id = $AWS_ACCESS_KEY_ID
EOF
fi
if [ -n "${AWS_SECRET_ACCESS_KEY:-}" ]; then
cat >> "$awsSharedCredentialsFileForInitialCredentials" <<EOF
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF
fi
chmod 400 "$awsSharedCredentialsFileForInitialCredentials"; # -r--------

# hide original env credentials (they have higher precedence than AWS_DEFAULT_PROFILE and would otherwise override that)
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY

# generate config file for role assumption
awsConfigFileForAssumeRole="$(mktemp)";
cat > "$awsConfigFileForAssumeRole" <<EOF
[profile $assumeRoleProfileName]
role_arn = $arnOfRoleToAssume
source_profile = $initialProfileName
EOF
chmod 400 "$awsConfigFileForAssumeRole"; # -r--------

# run with assume-role AWS profile
export AWS_DEFAULT_PROFILE=$assumeRoleProfileName
export AWS_SHARED_CREDENTIALS_FILE=$awsSharedCredentialsFileForInitialCredentials
export AWS_CONFIG_FILE=$awsConfigFileForAssumeRole
exec /usr/bin/aws "$@"
