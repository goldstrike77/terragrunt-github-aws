variable "tags" {
  default = {
    location    = "ap-south-1"
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
      s3 = [
        {
          bucket = [
            {
              bucket = "cloudtrail-yejhgtvx"
              policy = {
                "Version" : "2012-10-17",
                "Statement" : [{
                  "Sid" : "AWSCloudTrailAclCheck20150319",
                  "Effect" : "Allow",
                  "Principal" : {
                    "Service" : "cloudtrail.amazonaws.com"
                  },
                  "Action" : "s3:GetBucketAcl",
                  "Resource" : "arn:aws:s3:::cloudtrail-yejhgtvx",
                  "Condition" : {
                    "StringEquals" : {
                      "aws:SourceArn" : "arn:aws:cloudtrail:ap-south-1:601601034655:trail/trail"
                    }
                  }
                  }, {
                  "Sid" : "AWSCloudTrailWrite20150319",
                  "Effect" : "Allow",
                  "Principal" : {
                    "Service" : "cloudtrail.amazonaws.com"
                  },
                  "Action" : "s3:PutObject",
                  "Resource" : "arn:aws:s3:::cloudtrail-yejhgtvx/[optionalPrefix]/AWSLogs/601601034655/*",
                  "Condition" : {
                    "StringEquals" : {
                      "s3:x-amz-acl" : "bucket-owner-full-control",
                      "aws:SourceArn" : "arn:aws:cloudtrail:ap-south-1:601601034655:trail/trail"
                    }
                  }
                  }
                ]
              }
            }
          ]
        }
      ]
    }
  ]
}
