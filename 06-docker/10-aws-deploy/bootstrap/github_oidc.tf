#github actions -> AWS via OIDC

resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

#only tokens from this repo, and only from main or a pull request.
data "aws_iam_policy_document" "github_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.github_repo_claim}:ref:refs/heads/main",
        "repo:${var.github_repo_claim}:pull_request",
      ]
    }
  }
}

#workflows temp role
resource "aws_iam_role" "github_deploy" {
  name                 = "${var.project}-github-deploy"
  assume_role_policy   = data.aws_iam_policy_document.github_trust.json
  max_session_duration = 3600 # credentials last one hour
}

#role authorisation
resource "aws_iam_role_policy_attachment" "github_deploy" {
  role       = aws_iam_role.github_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}