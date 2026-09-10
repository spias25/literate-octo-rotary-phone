data "aws_iam_policy_document" "assume" {
  statement {
    actions = [sts.AssumeRoleWithWebIdentity]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider}:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.service_account_name}"]
    }
  }
}
resource "aws_iam_role" "this" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume.json
}
data "aws_iam_policy_document" "dynamodb" {
  statement {
    effect  = "Allow"
    actions = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Query", "dynamodb:Scan"]
    resources = [
      var.table_arn
    ]
  }
}
resource "aws_iam_policy" "this" {
  name   = "${var.name}-policy"
  policy = data.aws_iam_policy_document.dynamodb.source_json
}
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
output "role_arn" {
  value = aws_iam_role.this.arn
}
