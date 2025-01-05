!#/bin/bash
aws lambda invoke --payload $2 --function-name $AWS_SAVE_DEPLOYMENT_FUNC --cli-binary-format raw-in-base64-out outfile.json 