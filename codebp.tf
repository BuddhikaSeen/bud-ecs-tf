resource "aws_codebuild_project" "repo-project" {
  name         = var.build_project
  service_role = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/BuddhikaSeen/bud-spj-demo"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }
}