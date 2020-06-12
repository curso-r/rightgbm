is_debian_based <- function() {
  version <- Sys.info()["version"]
  grepl("debian|buntu|mint", tolower(version))
}

get_url <- function(platform) {
  if (platform == "Linux") {
    re <- sprintf("ubuntu-[0-9]{2}\\.[0-9]{2}-r-%d\\.%d", getRversion()$major, getRversion()$minor)
  } else if (platform == "Windows") {
    re <- sprintf("windows-r-%d\\.%d", getRversion()$major, getRversion()$minor)
  } else if (platform == "MacOS") {
    re <- sprintf("macos-r-%d\\.%d", getRversion()$major, getRversion()$minor)
  }
  r <- httr::GET("https://api.github.com/repos/curso-r/lightgbm-build/releases")
  if (r$status_code != 200) stop ("Could not access latest builds.")
  json <- httr::content(r, simplifyDataFrame = TRUE)
  da <- json[grepl(re, json$tag_name),]
  da <- da[order(da$created_at, decreasing = TRUE), ]
  da$assets[[1]]$browser_download_url
}

check_macos_deps <- function() {
  TRUE
}

#' Installs LightGBM
#'
#' This function installs `lightgbm` package directly from daily builds
#'   available on [this repository](https://github.com/curso-r/lightgbm-build).
#'   It works on Windows, Debian-based Linux distros and MacOS. Unfortunately
#'   it does not work yet on CentOS and ArchLinux.
#'
#' @param ... additional parameters passed to [utils::install.packages()].
#'
#' @source [Source code from LightGBM](https://lightgbm.readthedocs.io/en/latest/R/index.html)
#'
#' @return invisible `NULL`.
#'
#' @export
install_lightgbm <- function(...) {
  platform <- Sys.info()["sysname"]
  if (platform == "Linux") {
    if (is_debian_based()) {
      utils::install.packages(get_url(platform), repos = NULL, ...)
    } else {
      stop ("Not implemented yet.")
    }
  } else if (platform == "Windows") {
    utils::install.packages(get_url(platform), repos = NULL, type = "win.binary", ...)
  } else if (platform == "MacOS") {
    ## CHECAR
    check_macos_deps()
    utils::install.packages(get_url(platform), repos = NULL, ...)
  }
}


