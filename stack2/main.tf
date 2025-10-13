module "bedrock_kb" {
  source = "../modules/bedrock_kb"

  knowledge_base_name        = "my-bedrock-kb"
  knowledge_base_description = "Knowledge base connected to Aurora Serverless database"

  aurora_arn          = "arn:aws:rds:us-west-2:702127849341:cluster:my-aurora-serverless"
  aurora_db_name      = "myapp"
  aurora_endpoint     = "my-aurora-serverless.cluster-c50g8em80997.us-west-2.rds.amazonaws.com"
  aurora_table_name   = "bedrock_integration.bedrock_kb"
  aurora_primary_key_field = "id"
  aurora_metadata_field = "metadata"
  aurora_text_field   = "chunks"
  aurora_verctor_field = "embedding" # Note: there's a typo here, should be "vector_field"
  aurora_username     = "dbadmin"
  aurora_secret_arn   = "arn:aws:secretsmanager:us-west-2:702127849341:secret:my-aurora-serverless-HWx9g4"

  # Fill in the bucket ARN here
  s3_bucket_arn       = "arn:aws:s3:::bedrock-kb-702127849341"
}