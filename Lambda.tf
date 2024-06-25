data "archive_file" "lambda" {
  type        = "zip"
  source_file = "LambdaFunction.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "my_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "S3Move"
  role          = aws_iam_role.S3Access.arn
  handler       = "index.test"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"


  environment {
    variables = {
      foo = "bar"
    }
  }
}