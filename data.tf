#data "aws_iam_role" "codepipeline_role" {
#  name = "codepipeline-role"
#}

#data "aws_iam_role" "ecs-task" {
#  name = "ecsTaskExecutionRole"
#}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}