# Package Template for the cloudyr project

**aws.ec2metadata** is a package for retrieving Amazon EC2 instance metadata from within the running instance. The package simply contains a single R list, `metadata`, that contains a number of functions for retrieving metadata from within an instance. Most of these functions return character strings, but some will return lists; they default to `NULL` if no value is returned.

```R
library("aws.ec2metadata")

# get instance id
metadata$instance_id()

# get ami id
metadata$ami_id()

# check for IAM role (NULL if none specified)
(role <- metadata$iam_info())
# get role credentials
if (!is.null(role)) {
    metadata$iam_role("myrole")
}

# get an arbitrary metadata item
metadata$item("meta-data/placement/availability-zone")
```


## Installation

[![CRAN](https://www.r-pkg.org/badges/version/aws.ec2metadata)](https://cran.r-project.org/package=aws.ec2metadata)
[![Travis Build Status](https://travis-ci.org/cloudyr/aws.ec2metadata.png?branch=master)](https://travis-ci.org/cloudyr/aws.ec2metadata)
[![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/PROJECTNUMBER?svg=true)](https://ci.appveyor.com/project/cloudyr/aws.ec2metadata)
[![codecov.io](https://codecov.io/github/cloudyr/aws.ec2metadata/coverage.svg?branch=master)](https://codecov.io/github/cloudyr/aws.ec2metadata?branch=master)

This package is not yet on CRAN. To install the latest development version you can install from the cloudyr drat repository:

```R
# latest stable version
install.packages("aws.ec2metadata", repos = c(cloudyr = "http://cloudyr.github.io/drat", getOption("repos")))
```

Or, to pull a potentially unstable version directly from GitHub:

```R
if (!require("ghit")) {
    install.packages("ghit")
}
ghit::install_github("cloudyr/aws.ec2metadata")
```

---
[![cloudyr project logo](https://i.imgur.com/JHS98Y7.png)](https://github.com/cloudyr)
