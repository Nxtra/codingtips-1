#!/usr/bin/env bash

# Zip the lambda functions
rm -r getTipsLambda getTipsByAuthorLambda.zip postTipLambda.zip
cd get
zip -r ../getTipsLambda.zip getTipsLambda.js
zip -r ../getTipsByAuthorLambda.zip getTipsByAuthorLambda.js
cd ../post
zip -r ../postTipLambda.zip postTipLambda.js
cd ..

# Create bucket
aws s3api create-bucket --bucket codingtips-node-bucket-jago --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1

# Upload code to s3
aws s3 cp getTipsLambda.zip s3://codingtips-node-bucket-jago/v1.0.0/getTipsLambda.zip
aws s3 cp getTipsByAuthorLambda.zip s3://codingtips-node-bucket-jago/v1.0.0/getTipsByAuthorLambda.zip
aws s3 cp postTipLambda.zip s3://codingtips-node-bucket-jago/v1.0.0/postTipLambda.zip
