.onLoad <- function(libname, pkgname) {
    if (is_ec2() && Sys.getenv("AWS_DEFAULT_REGION") == "") {
        reg <- try(instance_document()$region, silent = TRUE)
        if (!inherits(reg, "try-error")) {
            Sys.setenv("AWS_DEFAULT_REGION" = reg)
            packageStartupMessage(sprintf("Setting environment variable AWS_DEFAULT_REGION to '%s'", reg))
        }
    }
}
