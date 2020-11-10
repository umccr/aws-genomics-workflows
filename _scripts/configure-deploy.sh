#!/bin/bash

set -e

# This script expects the following environment variable(s)
# ASSET_ROLE_ARN: the AWS role ARN that is used to publish assets

mkdir -p $HOME/.aws
cat << EOF > $HOME/.aws/config
[default]
region = us-east-1
output = json

[profile asset-publisher]
region = us-east-1
role_arn = ${ASSET_ROLE_ARN}
credential_source = Environment
EOF

cat $HOME/.aws/config