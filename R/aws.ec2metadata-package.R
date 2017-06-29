parse_lines <- function(x) {
    strsplit(x, "\n")[[1]]
}

get_instance_metadata <- 
function(item,
         version = "latest",
         base_url = "http://169.254.169.254/", 
         parse = "text",
         ...) {
    if (!missing(item)) {
        uri <- paste0(base_url, version, "/", item)
    } else {
        uri <- base_url
    }
    response <- try(curl_fetch_memory(uri), silent = TRUE)
    if (inherits(response, "try-error")) {
        stop("Request failed", call. = FALSE)
    } else if (response[["status_code"]] >= 400) {
        return(NULL)
    }
    if (parse == "json") {
        jsonlite::fromJSON(rawToChar(response[["content"]]))
    } else {
        parse_lines(rawToChar(response[["content"]]))
    }
}

#' @rdname ec2metadata
#' @name aws.ec2metadata-package
#' @title Get EC2 Instance Metadata
#' @aliases aws.ec2metadata-package aws.ec2metadata
#' @docType package
#' @description Retrieve EC2 instance metadata from the instance
#' @author Thomas J. Leeper <thosjleeper@gmail.com>
#' @keywords package 
NULL

#' @rdname ec2metadata
#' @export
is_ec2 <- function() {
    x <- try(get_instance_metadata(), silent = TRUE)
    if (inherits(x, "try-error")) {
        FALSE
    } else {
        TRUE
    }
}

#' @rdname ec2metadata
#' @details \code{is_ec2} returns a logical for whether the current R session appears to be running in an EC2 instance.
#' 
#' \code{metadata} is a list of functions to return various metadata values for the currently running EC2 instance. These are only meant to be called from an EC2 instance; no guarantees are made about behavior on other platforms. Two functions: \code{versions()} and \code{meta_data_items()} return the versions of the metadata, and the set of top-level metadata items, respectively.
#' 
#' The function \code{item()} retrieves a particular metadata item specified by its full path.
#'
#' The remaining functions in the list are aliases for potentially commonly needed metadata items
#' @details Generally, this will return a character string containing the requested information, otherwise a \code{NULL} if the response is empty. The \code{iam_role()} function returns a list. An error will occur if, for some reason, the request otherwise fails.
#' @examples
#' names(metadata)
#' 
#' \dontrun{
#'   metadata$versions()
#'   metadata$items()
#' 
#'   # get instance id
#'   metadata$instance_id()
#'   # get ami id
#'   metadata$ami_id()
#'   
#'   # get IAM role (NULL if none specified)
#'   metadata$iam_info()
#'   metadata$iam_role("myrole")
#' 
#'   # get an arbitrary metadata item
#'   metadata$item("meta-data/placement/availability-zone")
#' }
#' @references \href{http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html}{Metadata Documentation}
#' @importFrom jsonlite fromJSON
#' @importFrom curl curl_fetch_memory
#' @export
metadata <- list(
    versions = function(...) {
        get_instance_metadata(version = , ...)
    },
    meta_data_items = function(...) {
        get_instance_metadata(item = "meta-data", ...)
    },
    item = function(item, ...) {
        get_instance_metadata(item = item, ...)
    },
    ami_id = function(...) {
        get_instance_metadata(item = "meta-data/ami-id", ...)
    },
    launch_index = function(...) {
        get_instance_metadata(item = "meta-data/ami-launch-index", ...)
    },
    ancestor_ami_ids = function(...) {
        get_instance_metadata(item = "meta-data/ancestor-ami-ids", ...)
    },
    hostname = function(...) {
        get_instance_metadata(item = "meta-data/hostname", ...)
    },
    iam_info = function(...) {
        info <- get_instance_metadata(item = "meta-data/iam/info", parse = "json", ...)
    },
    iam_role_names = function(...) {
        get_instance_metadata(item = "meta-data/iam/security-credentials/", ...)
    },
    iam_role = function(role, ...) {
        get_instance_metadata(item = paste0("meta-data/iam/security-credentials/", role), parse = "json", ...)
    },
    instance_action = function(...) {
        get_instance_metadata(item = "meta-data/instance-action", ...)
    },
    instance_id = function(...) {
        get_instance_metadata(item = "meta-data/instance-id", ...)
    },
    instance_type = function(...) {
        get_instance_metadata(item = "meta-data/instance-type", ...)
    },
    kernel_id = function(...) {
        get_instance_metadata(item = "meta-data/kernel-id", ...)
    },
    local_hostname = function(...) {
        get_instance_metadata(item = "meta-data/local-hostname", ...)
    },
    local_ipv4 = function(...) {
        get_instance_metadata(item = "meta-data/local-ipv4", ...)
    },
    availability_zone = function(...) {
        get_instance_metadata(item = "placement/availability-zone", ...)
    },
    public_hostname = function(...) {
        get_instance_metadata(item = "meta-data/public-hostname", ...)
    },
    public_ipv4 = function(...) {
        get_instance_metadata(item = "meta-data/public-ipv4", ...)
    },
    public_key = function(key = 0, ...) {
        get_instance_metadata(item = paste0("meta-data/public-keys/", key, "/openssh-key"), ...)
    },
    ramdisk_id = function(...) {
        get_instance_metadata(item = "meta-data/ramdisk-id", ...)
    },
    reservation_id = function(...) {
        get_instance_metadata(item = "meta-data/reservation-id", ...)
    },
    security_groups = function(...) {
        get_instance_metadata(item = "meta-data/security-groups", ...)
    },
    domain = function(...) {
        get_instance_metadata(item = "meta-data/services/domain", ...)
    },
    partition = function(...) {
        get_instance_metadata(item = "meta-data/services/partition", ...)
    }
)
