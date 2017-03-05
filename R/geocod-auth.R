#' Get or set GEOCODIO_API_KEY value
#'
#' The API wrapper functions in this package all rely on a geocod.io API
#' key residing in the environment variables `GEOCODIO_API_KEY`. The easiest way to
#' accomplish this is to set it in the `.Renviron` file in your home directory.
#'
#' @md
#' @param force force setting a new geocod.io API key for the
#'        current environment?
#' @return `list` containing the combined geocod.io API key
#' @export
gio_auth <- function(force=FALSE) {

  key <- Sys.getenv('GEOCODIO_API_KEY')

  if ((!identical(key, "")) && !force) {
    return(key)
  }

  if (!interactive()) {
    stop(paste0("Please set env var GEOCODIO_API_KEY",
                "to your geocod.io API key", sep="", collapse=""),
                call. = FALSE)
  }

  if (identical(key, "")) {

    message("Couldn't find env var GEOCODIO_API_KEY See ?gio_auth for more details.")
    message("Please enter your API key and press enter:")
    pat <- readline(": ")

    if (identical(pat, "")) {
      stop("geocod.io API key entry failed", call. = FALSE)
    }

    message("Updating GEOCODIO_API_KEY env var to PAT")
    Sys.setenv(GEOCODIO_API_KEY = pat)

    return(pat)

  }

}
