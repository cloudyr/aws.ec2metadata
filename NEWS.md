# CHANGES TO aws.ec2metadata 0.1.3

* Added a function `instance_document()` that returns a list of the ["instance identity document"](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html) information. This is useful for identifying the region an instance is running in.
* When the package is loaded on an EC2 instance (as identified by `is_ec2()` during package load), the package attempts to set the `AWS_DEFAULT_REGION` environment variable if it has not already been specified. This helps handle request signing.

# CHANGES TO aws.ec2metadata 0.1.2

* Added a function `is_ec2()` that returns a logical based on whether metadata is retrievable.

# CHANGES TO aws.ec2metadata 0.1.1

* Initial release.
