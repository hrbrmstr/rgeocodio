#' Geocode up to 10,000 addresses
#'
#' @md
#' @param addresses character vector of addresses (10K max)
#' @param api_key `geocod.io` API key
#' @export
#' @examples
#' gio_batch_geocode(c(
#'   "1109 N Highland St, Arlington VA",
#'   "525 University Ave, Toronto, ON, Canada",
#'   "4410 S Highway 17 92, Casselberry FL",
#'   "15000 NE 24th Street, Redmond WA",
#'   "17015 Walnut Grove Drive, Morgan Hill CA"
#' ))
gio_batch_geocode <- function(addresses, api_key=gio_auth()) {

  if (length(addresses) > 10000) {
    message("Too many addresses. Submitting first 10,000")
    addresses <- addresses[1:10000]
  }

  res <- httr::POST("https://api.geocod.io/v1/geocode",
                    query=list(api_key=api_key),
                    body=as.list(addresses), encode="json")

  httr::stop_for_status(res)

  jsonlite::fromJSON(httr::content(res, as="text", encoding="UTF-8"))

}