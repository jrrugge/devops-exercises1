#WAF in front of ALB

resource "aws_wafv2_web_acl" "app" {
  name  = "${var.project}-waf"
  scope = "REGIONAL" # REGIONAL is for ALBs; CLOUDFRONT is the other option

  # Anything no rule matches is allowed through.
  default_action {
    allow {}
  }

  #aws common rule protection
  rule {
    name     = "aws-common-rules"
    priority = 1

    override_action {
      none {} # use the rule group's own actions (block)
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project}-common-rules"
      sampled_requests_enabled   = true
    }
  }

  #rate limiting rule per ip, bots, etc
  rule {
    name     = "rate-limit-per-ip"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 500
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.project}-rate-limit"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.project}-waf"
    sampled_requests_enabled   = true
  }
}

#edge/alb association
resource "aws_wafv2_web_acl_association" "app" {
  resource_arn = aws_lb.app.arn
  web_acl_arn  = aws_wafv2_web_acl.app.arn
}