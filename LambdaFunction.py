import boto3
import requests
import tempfile

def lambda_handler(event, context):
  # Replace with the URL you want to fetch data from
  url = "https://www.example.com/data"

  # Fetch data from the URL
  response = requests.get(url)

  # Check for successful response
  if response.status_code == 200:
    # Create a temporary file
    with tempfile.NamedTemporaryFile(delete=False) as temp_file:
      temp_file.write(response.content)
      data_path = temp_file.name

      # Configure S3 connection (replace with your bucket name and credentials)
      s3_client = boto3.client('s3',
          aws_access_key_id='YOUR_ACCESS_KEY',
          aws_secret_access_key='YOUR_SECRET_KEY')

      # Upload the data file to S3 bucket
      s3_client.upload_file(data_path, 'your-bucket-name', 'data.txt')

      # Clean up the temporary file
      temp_file.close()  # This will also delete the file

      return {
          'statusCode': 200,
          'body': f'Data saved to S3 bucket: your-bucket-name/data.txt'
      }
  else:
    return {
        'statusCode': response.status_code,
        'body': f'Error fetching data: {response.reason}'
    }
