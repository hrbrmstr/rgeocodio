#' Reverse geocode up to 10,000 coordinates
#'
#' @md
#' @param coordinates data frame of coordinates with `lat` and `lon` columns
#' @param api_key `geocod.io` API key
#' @export
#' @examples
#' data.frame(
#'   lat = c(35.9746000, 32.8793700, 33.8337100, 35.4171240),
#'   lon = c(-77.9658000, -96.6303900, -117.8362320, -80.6784760)
#' ) -> to_code
#' gio_batch_reverse(to_code)
gio_batch_reverse <- function(coordinates, api_key=gio_auth()) {

  if (nrow(coordinates) > 10000) {
    message("Too many addresses. Submitting first 10,000")
    coordinates <- coordinates[1:10000,]
  }

  if (!("lat" %in% colnames(coordinates))) {
    stop("coordinates data frame must have a 'lat' column")
  }

  if (!("lon" %in% colnames(coordinates))) {
    stop("coordinates data frame must have a 'lon' column")
  }

  pairs <- sprintf("%s,%s", coordinates$lat, coordinates$lon)

  res <- httr::POST("https://api.geocod.io/v1/reverse",
                    query=list(api_key=api_key),
                    body=as.list(pairs), encode="json")

  httr::stop_for_status(res)

  jsonlite::fromJSON(httr::content(res, as="text", encoding="UTF-8"))

}

