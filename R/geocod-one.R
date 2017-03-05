#' Geocode a single address
#'
#' @md
#' @param address address to geocode
#' @param api_key `geocod.io` API key
#' @export
#' @examples
#' gio_geocode("1109 N Highland St, Arlington, VA")
gio_geocode <- function(address, api_key=gio_auth()) {

  res <- httr::GET("https://api.geocod.io/v1/geocode",
                   query=list(q=address, api_key=api_key))

  httr::stop_for_status(res)

  jsonlite::fromJSON(httr::content(res, as="text", encoding="UTF-8"))

}

#' Geocode a single address
#'
#' @md
#' @param street,city,state,postal_code,country address components
#' @param api_key `geocod.io` API key
#' @export
#' @examples
#' gio_geocode_components("1109 N Highland St", "Arlington", "VA")
gio_geocode_components <- function(street, city, state, postal_code, country,
                                   api_key=gio_auth()) {

  params <- list(api_key=api_key)

  if (!missing(street)) params$street <- street
  if (!missing(city)) params$city <- city
  if (!missing(state)) params$state <- state
  if (!missing(postal_code)) params$postal_code <- postal_code
  if (!missing(country)) params$country <- country

  res <- httr::GET("https://api.geocod.io/v1/geocode", query=params)

  httr::stop_for_status(res)

  jsonlite::fromJSON(httr::content(res, as="text", encoding="UTF-8"))

}
