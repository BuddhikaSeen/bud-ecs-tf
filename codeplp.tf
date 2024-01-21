resource "aws_codepipeline" "ecsdemo_pipeline" {
  name     = "ecsdemo_pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }
  # SOURCE
  stage {
    name = "Source"
    action {
      name             = "Git-Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner                = "BuddhikaSeen"
        Repo                 = "bud-spj-demo"
        Branch               = "main"
        OAuthToken           = "test-token"
        PollForSourceChanges = false
      }
    }
  }
  # BUILD
  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = "${var.build_project}"
      }
    }
  }
  # DEPLOY
  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = "demo-cluster"
        ServiceName = "app"
        FileName    = "imagedefinitions.json"
      }
    }
  }
}