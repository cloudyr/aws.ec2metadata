# aws.ec2metadata 0.2.0

* revise timeout for curl checks against instance metadata (Thanks @jmorten)
* curl timeout now respects the AWS_METADATA_SERVICE_TIMEOUT environment variable (like boto3)

# aws.ec2metadata 0.1.6

* Added new functions: `is_ecs()` to check whether R is running in an Elastic Container Store (ECS) instance, and `ecs_metadata()` to retrieve credentials from the container. (#2, h/t @jon-mago)

# aws.ec2metadata 0.1.5

* Now supports querying ECS task role

# aws.ec2metadata 0.1.4

* Previous `.onLoad()` functionality added in 0.1.3 is now moved to `.onAttach()` to comply with CRAN policy.

# aws.ec2metadata 0.1.3

* Added a function `instance_document()` that returns a list of the ["instance identity document"](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html) information. This is useful for identifying the region an instance is running in.
* When the package is loaded on an EC2 instance (as identified by `is_ec2()` during package load), the package attempts to set the `AWS_DEFAULT_REGION` environment variable if it has not already been specified. This helps handle request signing.

# aws.ec2metadata 0.1.2

* Added a function `is_ec2()` that returns a logical based on whether metadata is retrievable.

# aws.ec2metadata 0.1.1

* Initial release.
