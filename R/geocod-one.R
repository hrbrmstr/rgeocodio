#' Geocode a single address
#'
#' @md
#' @param address address to geocode
#' @param fields vector of additional fields to return with query results. Note that these
#'        count as extra lookups and impact your dailu quota/costs. See [the official documentation](https://geocod.io/docs/#fields)
#'        for more information on costs/pricing. Can be `cd`, `cd113`, `cd114`, or `cd115` for
#'        current or historical Congressional districts (U.S.); `stateleg` for State Legislative District (House & Senate, U.S.);
#'        `school` forSchool District (elementary/secondary or unified, U.S.); `census` for
#'        Census Block/Tract & FIPS codes (U.S.) or `timezone` for timezone.
#' @param api_key `geocod.io` API key
#' @export
#' @examples \dontrun{
#' gio_geocode("1109 N Highland St, Arlcdceington, VA")
#' gio_geocode("1109 N Highland St, Arlington, VA",
#'             fields=c("cd", "stateleg"))
#' }
gio_geocode <- function(address, fields, api_key=gio_auth()) {

  params <- list(q=address, api_key=api_key)
  if (!missing(fields)) params$fields <- paste0(trimws(fields), collapse=",")

  res <- httr::GET("https://api.geocod.io/v1/geocode", query=params)

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

#' Geocode a single address
#'
#' @md
#' @param street,city,state,postal_code,country address components
#' @param fields vector of additional fields to return with query results. Note that these
#'        count as extra lookups and impact your dailu quota/costs. See [the official documentation](https://geocod.io/docs/#fields)
#'        for more information on costs/pricing. Can be `cd`, `cd113`, `cd114`, or `cd115` for
#'        current or historical Congressional districts (U.S.); `stateleg` for State Legislative District (House & Senate, U.S.);
#'        `school` forSchool District (elementary/secondary or unified, U.S.); `census` for
#'        Census Block/Tract & FIPS codes (U.S.) or `timezone` for timezone.
#' @param api_key `geocod.io` API key
#' @export
#' @examples
#' gio_geocode_components("1109 N Highland St", "Arlington", "VA")
#' gio_geocode_components("1109 N Highland St", "Arlington", "VA",
#'                        fields=c("census", "stateleg"))
gio_geocode_components <- function(street, city, state, postal_code, country,
                                   fields, api_key=gio_auth()) {

  params <- list(api_key=api_key)
  if (!missing(fields)) params$fields <- paste0(trimws(fields), collapse=",")

  if (!missing(street)) params$street <- street
  if (!missing(city)) params$city <- city
  if (!missing(state)) params$state <- state
  if (!missing(postal_code)) params$postal_code <- postal_code
  if (!missing(country)) params$country <- country

  res <- httr::GET("https://api.geocod.io/v1/geocode", query=params)

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
