#' Reverse geocode a single lat/lon pair
#'
#' @md
#' @param lat,lon lat/lon pair to reverse geocode
#' @param api_key `geocod.io` API key
#' @param fields vector of additional fields to return with query results. Note that these
#'        count as extra lookups and impact your dailu quota/costs. See [the official documentation](https://geocod.io/docs/#fields)
#'        for more information on costs/pricing. Can be `cd`, `cd113`, `cd114`, or `cd115` for
#'        current or historical Congressional districts (U.S.); `stateleg` for State Legislative District (House & Senate, U.S.);
#'        `school` forSchool District (elementary/secondary or unified, U.S.); `census` for
#'        Census Block/Tract & FIPS codes (U.S.) or `timezone` for timezone.
#' @export
#' @return `tibble`
#' @references [Official Geocodio API documentation](https://geocod.io/docs/)
#' @examples
#' gio_reverse(38.9002898, -76.9990361)
#' gio_reverse(38.9002898, -76.9990361, fields=c("census", "stateleg"))
gio_reverse <- function(lat, lon, fields, api_key=gio_auth()) {

  params <- list(q=sprintf("%s,%s", lat, lon), api_key=api_key)
  if (!missing(fields)) params$fields <- process_fields(fields)

  res <- httr::GET("https://api.geocod.io/v1.6/reverse", query=params)

  httr::stop_for_status(res)

  res <- jsonlite::fromJSON(httr::content(res, as="text", encoding = "UTF-8"),
                            flatten = TRUE)

  res <- res$results

  new_names <- gsub("\\.", "_", colnames(res))
  new_names <- gsub("address_components|fields", "", new_names)
  new_names <- sub("^_", "", new_names)

  res <- set_names(res, new_names)

  as_tibble(res)

}