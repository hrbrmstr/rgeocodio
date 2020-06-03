#' Reverse geocode up to 10,000 coordinates
#'
#' If you have several addresses that you need to reverse geocode, batch rev-geocoding is a much
#' faster option since it removes the overhead of having to perform multiple HTTP requests.
#'
#' @md
#' @param coordinates data frame with coordinates in `lat` and `lon` columns
#' @param fields vector of additional fields to return with query results. Note that these
#'        count as extra lookups and impact your dailu quota/costs. See [the official documentation](https://geocod.io/docs/#fields)
#'        for more information on costs/pricing. Can be `cd`, `cd113`, `cd114`, or `cd115` for
#'        current or historical Congressional districts (U.S.); `stateleg` for State Legislative District (House & Senate, U.S.);
#'        `school` forSchool District (elementary/secondary or unified, U.S.); `census` for
#'        Census Block/Tract & FIPS codes (U.S.) or `timezone` for timezone.
#' @param api_key `geocod.io` API key
#' @return `tibble`
#' @references [Official Geocodio API documentation](https://geocod.io/docs/)
#' @export
#' @examples
#' data.frame(
#'   lat = c(35.9746000, 32.8793700, 33.8337100, 35.4171240),
#'   lon = c(-77.9658000, -96.6303900, -117.8362320, -80.6784760)
#' ) -> to_code
#' gio_batch_reverse(to_code)
#' gio_batch_reverse(to_code, fields=c("census", "stateleg"))
gio_batch_reverse <- function(coordinates, fields, api_key=gio_auth()) {

  # API max as of 2017-03-05 is 10K
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

  params <- list(api_key=api_key)
  if (!missing(fields)) params$fields <- process_fields(fields)

  res <- httr::POST("https://api.geocod.io/v1.6/reverse",
                    query=params, body=as.list(pairs), encode="json")

  httr::stop_for_status(res)

  res <- jsonlite::fromJSON(httr::content(res, as="text", encoding = "UTF-8"),
                            flatten = TRUE)

  res <- res$results$response.results

  res <- map_df(res, ~.)

  new_names <- gsub("\\.", "_", colnames(res))
  new_names <- gsub("response_input|address_components|fields", "", new_names)
  new_names <- gsub("[_]+", "_", new_names)
  new_names <- sub("^_", "", new_names)

  res <- set_names(res, new_names)

  as_tibble(res)

}