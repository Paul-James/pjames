# # add startup messages
# .onAttach <- function(libname, pkgname) {
#   packageStartupMessage("strategery...")
# }

# helper non-exported helper functions used across multiple function scripts

pkg_check <- function(req_pkgs){

  # make sure suggested pkgs are installed and available
  # TRUE = pkg missing and needs to be installed
  pkg_missing <- sapply(req_pkgs, function(pkg) !requireNamespace(pkg, quietly = TRUE))

  if(any(pkg_missing)){

    pkg_multi <- sum(pkg_missing) > 1

    stop(
      sprintf(
          "The following package%s needed for this function to work. Please install %s:\n%s"
        , ifelse(pkg_multi, 's are', ' is')
        , ifelse(pkg_multi, 'them', 'it')
        , paste0(sprintf('   %s\n', req_pkgs[pkg_missing]), collapse = '')
        )
      , call. = FALSE
    )
  }

}
