variable "tags" {
  default = {
    environment = "prd"
    customer    = "Learn"
    owner       = "Somebody"
    email       = "somebody@mail.com"
    title       = "Engineer"
    department  = "IS"
  }
}

variable "aws_resources" {
  default = [
    {
      account = [
        {
          alias = [
            {
              account_alias = "aws-demo-dev-fwksfc"
            }
          ]
        }
      ],
      iam = [
        {
          role = [
            {
              assume_role_policy = {
                "Version" : "2012-10-17",
                "Statement" : [{
                  "Effect" : "Allow",
                  "Action" : "sts:AssumeRole",
                  "Principal" : {
                    "AWS" : "601601034655"
                  },
                  "Condition" : {}
                  }
                ]
              }
              name = "ReadOnlyAccessRole"
            },
            {
              assume_role_policy = {
                "Version" : "2012-10-17",
                "Statement" : [
                  {
                    "Effect" : "Allow",
                    "Principal" : {
                      "Service" : "s3.amazonaws.com"
                    },
                    "Action" : "sts:AssumeRole"
                  }
                ]
              }
              name        = "S3-Access-Logs-CRR-Role",
              description = "Create for s3 access logs cross account replication."
            }
          ],
          policy = [
            {
              name = "S3-Access-Logs-CRR-Policy"
              policy = {
                "Version" : "2012-10-17",
                "Statement" : [{
                  "Effect" : "Allow",
                  "Action" : [
                    "s3:GetReplicationConfiguration",
                    "s3:ListBucket"
                  ],
                  "Resource" : [
                    "arn:aws:s3:::s3-access-logs-315922616014-zhy",
                    "arn:aws:s3:::s3-access-logs-315922616014-bjs"
                  ]
                  }, {
                  "Effect" : "Allow",
                  "Action" : [
                    "s3:GetObjectVersionForReplication",
                    "s3:GetObjectVersionAcl",
                    "s3:GetObjectVersionTagging"
                  ],
                  "Resource" : [
                    "arn:aws:s3:::s3-access-logs-315922616014-zhy/*",
                    "arn:aws:s3:::s3-access-logs-315922616014-bjs/*"
                  ]
                  }, {
                  "Effect" : "Allow",
                  "Action" : [
                    "s3:ReplicateObject",
                    "s3:ReplicateDelete",
                    "s3:ReplicateTags",
                    "s3:ObjectOwnerOverrideToBucketOwner"
                  ],
                  "Resource" : "arn:aws:s3:::s3-access-aggregated-logs/*"
                  }
                ]
              }
              role = "S3-Access-Logs-CRR-Role"
            }
          ]
          policy_attachment = [
            {
              role   = "ReadOnlyAccessRole"
              policy = "ReadOnlyAccess"
            }
          ]
        }
      ]
    }
  ]
}
