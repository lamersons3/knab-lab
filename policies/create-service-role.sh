aws iam create-policy --policy-name knab-lab-terraform --policy-document file://tf-aws-deploy.json

aws iam create-role --role-name knab-lab-terraform --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "Service": "sts.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
  }
}'

aws iam attach-role-policy --role-name knab-lab-terraform --policy-arn arn:aws:iam::864899850759:policy/knab-lab-terraform

