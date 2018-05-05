#' Geocode up to 10,000 addresses
#'
#' If you have several addresses that you need to geocode, batch geocoding is a much faster
#' option since it removes the overhead of having to perform multiple HTTP requests.
#'
#' **You can also geocode intersections.** Just specify the two streets that you want to
#' geocode in your query.
#'
#' @md
#' @param addresses character vector of addresses (10K max)
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
#' addresses <- c(
#'   "1109 N Highland St, Arlington VA",
#'   "525 University Ave, Toronto, ON, Canada",
#'   "4410 S Highway 17 92, Casselberry FL",
#'   "15000 NE 24th Street, Redmond WA",
#'   "17015 Walnut Grove Drive, Morgan Hill CA"
#' )
#'
#' gio_batch_geocode(addresses)
#' gio_batch_geocode(addresses, fields=c("cd", "stateleg"))
gio_batch_geocode <- function(addresses, fields, api_key=gio_auth()) {

  if (length(addresses) > 10000) {
    message("Too many addresses. Submitting first 10,000")
    addresses <- addresses[1:10000]
  }

  params <- list(api_key=api_key)
  if (!missing(fields)) params$fields <- process_fields(fields)

  res <- httr::POST("https://api.geocod.io/v1.3/geocode",
                    query=params, body=as.list(addresses), encode="json")

  httr::stop_for_status(res)

  res <- jsonlite::fromJSON(httr::content(res, as="text", encoding = "UTF-8"),
                            flatten = TRUE)

  res <- res$results

  new_names <- gsub("\\.", "_", colnames(res))
  new_names <- gsub("response_input|address_components|fields", "", new_names)
  new_names <- gsub("[_]+", "_", new_names)
  new_names <- sub("^_", "", new_names)

  res <- set_names(res, new_names)

  as_tibble(res)

}