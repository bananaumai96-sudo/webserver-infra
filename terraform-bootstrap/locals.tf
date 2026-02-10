locals {
    EC2_Actions = [
        "ec2:RunInstances",
        "ec2:TerminateInstances",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "ec2:RebootInstances",
        "ec2:DescribeInstances",
        "ec2:CreateLaunchTemplate",
        "ec2:DeleteLaunchTemplate",
        "ec2:ModifyInstanceAttribute",
        "ec2:CreateLaunchTemplateVersion",
        "ec2:GetManagedPrefixListEntries",
        "ec2:DescribeImages",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeKeyPairs",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeInstanceAttribute",
        "ec2:DescribeVolumes",
        "ec2:DescribeInstanceCreditSpecifications",
        "ec2:DescribeLaunchTemplates",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:DescribeManagedPrefixLists",
        "ec2:DescribeSecurityGroupRules",
        "ec2:CreateTags",
        "ec2:DescribeTags",
        "ec2:DeleteTags",
        "ec2:AssociateRouteTable",
        "ec2:DisassociateRouteTable",
        "ec2:ReplaceRouteTableAssociation"
    ]

    VPC_Actions = [
        "ec2:CreateVpc",
        "ec2:DeleteVpc",
        "ec2:DescribeVpcs",
        "ec2:ModifyVpcAttribute",
        "ec2:DescribeVpcAttribute",
    ]

    subnet_Actions = [
        "ec2:CreateSubnet",
        "ec2:DeleteSubnet",
        "ec2:DescribeSubnets",
        "ec2:ModifySubnetAttribute"
    ]

    sg_Actions = [
        "ec2:CreateSecurityGroup",
        "ec2:DeleteSecurityGroup",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:DescribeSecurityGroups"
    ]

    igw_Actions = [
        "ec2:CreateInternetGateway",
        "ec2:DeleteInternetGateway",
        "ec2:AttachInternetGateway",
        "ec2:DetachInternetGateway",
        "ec2:DescribeInternetGateways"
    ]

    rtb_Actions = [
        "ec2:CreateRouteTable",
        "ec2:DeleteRouteTable",
        "ec2:AssociateRouteTable",
        "ec2:DisassociateRouteTable",
        "ec2:CreateRoute",
        "ec2:ReplaceRoute",
        "ec2:DeleteRoute",
        "ec2:DescribeRouteTables"
    ]

    nat_Actions = [
        "ec2:AllocateAddress",
        "ec2:ReleaseAddress",
        "ec2:CreateNatGateway",
        "ec2:DeleteNatGateway",
        "ec2:DescribeNatGateways"
    ]

    eip_Actions = [
        "ec2:AssociateAddress",
        "ec2:DescribeAddresses",
        "ec2:DisassociateAddress",
        "ec2:DescribeAddressesAttribute"
    ]



    s3_Actions = [
        "s3:CreateBucket",
        "s3:PutBucketPolicy",
        "s3:PutBucketAcl",
        "s3:PutEncryptionConfiguration",
        "s3:PutLifecycleConfiguration",
        "s3:PutBucketPublicAccessBlock",
        "s3:PutBucketLogging",
        "s3:HeadBucket",
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:GetBucketTagging",
        "s3:PutBucketTagging",
        "s3:GetBucketPolicy",
        "s3:GetBucketAcl",
        "s3:GetObject",
        "s3:PutObject",
        "s3:GetBucketCORS",
        "s3:GetBucketWebsite",
        "s3:GetBucketVersioning",
        "s3:GetAccelerateConfiguration",
        "s3:GetBucketRequestPayment",
        "s3:GetBucketLogging",
        "s3:GetLifecycleConfiguration",
        "s3:GetReplicationConfiguration",
        "s3:GetEncryptionConfiguration",
        "s3:GetBucketObjectLockConfiguration",
        "s3:GetBucketPublicAccessBlock",
        "s3:DeleteBucket",
        "s3:DeleteObject",
        "s3:PutBucketOwnershipControls",
        "s3:GetBucketOwnershipControls",
        "s3:DeleteBucketPolicy"

        ]

    elb_Actions = [
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:ModifyTargetGroupAttributes",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeListenerAttributes",
        "elasticloadbalancing:DescribeTargetHealth"
    ]

    asg_Actions = [
        "autoscaling:CreateAutoScalingGroup",
        "autoscaling:UpdateAutoScalingGroup",
        "autoscaling:DeleteAutoScalingGroup",
        "autoscaling:PutScalingPolicy",
        "autoscaling:DeletePolicy",
        "autoscaling:PutLifecycleHook",
        "autoscaling:DeleteLifecycleHook",
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribePolicies",
        "autoscaling:DescribeScalingActivities",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:PutNotificationConfiguration",
        "autoscaling:DeleteNotificationConfiguration",
        "autoscaling:DescribeNotificationConfigurations"
    ]

    cloudfornt_Actions = [
        "cloudfront:CreateDistribution",
        "cloudfront:GetDistribution",
        "cloudfront:GetDistributionConfig",
        "cloudfront:ListDistributions",
        "cloudfront:TagResource",
        "cloudfront:ListTagsForResource",
        "cloudfront:UpdateDistribution",
        "cloudfront:DeleteDistribution"
    ]

    waf_Actions = [
        "wafv2:CreateWebACL",
        "wafv2:DeleteWebACL",
        "wafv2:UpdateWebACL",
        "wafv2:GetWebACL",
        "wafv2:ListWebACLs",
        "wafv2:AssociateWebACL",
        "wafv2:DisassociateWebACL",
        "wafv2:ListAvailableManagedRuleGroups",
        "wafv2:DescribeManagedRuleGroup",
        "wafv2:ListTagsForResource",
    ]

    sns_Actions = [
        "sns:CreateTopic",
        "sns:DeleteTopic",
        "sns:GetTopicAttributes",
        "sns:SetTopicAttributes",
        "sns:Subscribe",
        "sns:Unsubscribe",
        "sns:ListSubscriptionsByTopic",
        "sns:ListTagsForResource",
        "sns:TagResource",
        "sns:UntagResource",
        "sns:GetSubscriptionAttributes",
        "sns:SetSubscriptionAttributes"
    ]

    rds_Actions = [
        "rds:CreateDBParameterGroup",
        "rds:ModifyDBParameterGroup",
        "rds:DeleteDBParameterGroup",
        "rds:CreateDBSubnetGroup",
        "rds:ModifyDBSubnetGroup",
        "rds:DeleteDBSubnetGroup",
        "rds:DescribeDBParameterGroups",
        "rds:DescribeDBSubnetGroups",
        "rds:DescribeDBParameters",
        "rds:AddTagsToResource",
        "rds:RemoveTagsFromResource",
        "rds:ListTagsForResource", 
        "rds:CreateDBInstance",
        "rds:DeleteDBInstance",
        "rds:ModifyDBInstance",
        "rds:DescribeDBInstances"
    ]

    iam_Actions = [
        "iam:CreateRole",
        "iam:AttachRolePolicy",
        "iam:PassRole",
        "iam:GetRole",
        "iam:ListRolePolicies",
        "iam:DeleteRole",
        "iam:ListAttachedRolePolicies",
        "iam:DetachRolePolicy",
        "iam:ListInstanceProfilesForRole",
        "iam:PutRolePolicy",
        "iam:GetRolePolicy",
        "iam:DeleteRolePolicy"
    ]

    cloudwatch_Actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutMetricFilter",
        "logs:PutRetentionPolicy",
        "logs:DescribeLogGroups",
        "logs:DeleteLogGroup",
        "logs:ListTagsForResource",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:DescribeMetricFilters",
        "cloudwatch:DescribeLogGroups",
        "cloudwatch:PutMetricFilter",
        "cloudwatch:ListTagsForResource",
        "logs:DeleteMetricFilter",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:DeleteAlarms",
        "cloudwatch:DescribeAlarmsForMetric",
        "cloudwatch:PutMetricData"
    ]

    cloudtrail_Actions = [
        "cloudtrail:CreateTrail",
        "cloudtrail:DeleteTrail",
        "cloudtrail:UpdateTrail",
        "cloudtrail:GetTrail",
        "cloudtrail:DescribeTrails",
        "cloudtrail:StartLogging",
        "cloudtrail:StopLogging",
        "cloudtrail:ListTags",
        "cloudtrail:AddTags",
        "cloudtrail:RemoveTags",
        "cloudtrail:GetTrailStatus",
        "cloudtrail:PutEventSelectors",
        "cloudtrail:GetEventSelectors"
    ]

  common_tags = {
    Project   = var.project_name
    ManagedBy = "terraform"
  }

}
