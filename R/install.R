#' Installs LightGBM
#'
#' @param ... additional parameters passed to [utils::install.packages()]
#'
#' @export
install_lightgbm <- function(...) {

  platform <- Sys.info()["sysname"]

  if (platform == "Linux") {
    utils::install.packages(
      sprintf(
        "https://github.com/curso-r/lightgbm-build/releases/download/ubuntu-18.04-r-%d.%d/lightgbm_2.3.2_R_x86_64-pc-linux-gnu.tar.gz",
        getRversion()$major, getRversion()$minor
      ), repos = NULL, ...
    )
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
        getRversion()$major, getRversion()$minor
      )
    )
  }



}


