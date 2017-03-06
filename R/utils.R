# ensure the passed-in fields are clean and valid for the API as of 2017-03-05
process_fields <- function(fields) {

  ok_fields <- c("cd", "cd113", "cd114", "cd115", "stateleg", "census", "school", "timezone")

  fields <- trimws(fields)
  fields <- tolower(fields)

  fields <- match.arg(fields, choices = ok_fields, several.ok = TRUE)

  # TODO: error, warning or message abt what got left out of `fields`

  paste0(fields, collapse=",")

}
