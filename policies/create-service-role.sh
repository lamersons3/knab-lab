#service acc for actions
aws iam create-policy --policy-name knab-lab-terraform --policy-document file://tf-aws-deploy.json
aws iam create-role --role-name knab-lab-terraform --assume-role-policy-document file://tf-trust.json
aws iam attach-role-policy --role-name knab-lab-terraform --policy-arn arn:aws:iam::864899850759:policy/knab-lab-terraform
aws iam update-policy --policy-arn arn:aws:iam::864899850759:policy/knab-lab-terraform --policy-document file://tf-aws-deploy.json
#godaddy secret
aws secretsmanager create-secret --name godaddy_api_secret --secret-string '{"GODADDY_API_KEY":"REPLACE","GODADDY_API_SECRET":"REPLACE"}'
