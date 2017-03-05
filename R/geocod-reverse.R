#' Reverse geocode a single lat/lon pair
#'
#' @md
#' @param lat,lon lat/lon pair to reverse geocode
#' @param api_key `geocod.io` API key
#' @export
#' @examples
#' gio_reverse(38.9002898, -76.9990361)
gio_reverse <- function(lat, lon, api_key=gio_auth()) {

  res <- httr::GET("https://api.geocod.io/v1/reverse",
                   query=list(q=sprintf("%s,%s", lat, lon), api_key=api_key))

  httr::stop_for_status(res)

  jsonlite::fromJSON(httr::content(res, as="text", encoding="UTF-8"))

}