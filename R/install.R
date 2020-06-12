is_debian_based <- function() {
  version <- Sys.info()["version"]
  grepl("debian|buntu|mint", tolower(version))
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
      utils::install.packages(
        sprintf(
          "https://github.com/curso-r/lightgbm-build/releases/download/ubuntu-18.04-r-%d.%d/lightgbm_2.3.2_R_x86_64-pc-linux-gnu.tar.gz",
          getRversion()$major, getRversion()$minor
        ), repos = NULL, ...
      )
    } else {
      stop ("Not implemented yet.")
    }
  } else if (platform == "Windows") {
    utils::install.packages(
      sprintf(
        "https://github.com/curso-r/lightgbm-build/releases/download/windows-r-%d.%d/lightgbm_2.3.2.zip",
        getRversion()$major, getRversion()$minor
      ),
      repos = NULL,
      type = "win.binary",
      ...
    )
  } else if (platform == "MacOS") {

    ## CHECAR

    utils::install.packages(
      sprintf(
        "https://github.com/curso-r/lightgbm-build/releases/download/macos-r-%d.%d/lightgbm_2.3.2.zip",
        getRversion()$major,
        getRversion()$minor,
        ...
      )
    )
  }
}


