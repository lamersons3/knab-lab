aws s3api create-bucket \
  --bucket knab-lab-terraform-state \
  --region eu-central-1 \
  --create-bucket-configuration LocationConstraint=eu-central-1

aws s3api put-bucket-versioning \
  --bucket knab-lab-terraform-state \
  --versioning-configuration Status=Enabled

aws dynamodb create-table \
  --table-name knab-lab-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
