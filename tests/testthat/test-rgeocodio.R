context("basic functionality")
test_that("we can do something", {

  # Doing this for code coverage for now

  expect_that(gio_geocode("1109 N Highland St, Arlington, VA"), is_a("data.frame"))

  expect_that(gio_geocode_components("1109 N Highland St", "Arlington", "VA"), is_a("data.frame"))

  expect_that(gio_reverse(38.9002898, -76.9990361), is_a("data.frame"))

  addresses <- c(
    "1109 N Highland St, Arlington VA",
    "525 University Ave, Toronto, ON, Canada",
    "4410 S Highway 17 92, Casselberry FL",
    "15000 NE 24th Street, Redmond WA",
    "17015 Walnut Grove Drive, Morgan Hill CA"
  )

  expect_that(gio_batch_geocode(addresses), is_a("data.frame"))

  data.frame(
    lat = c(35.9746000, 32.8793700, 33.8337100, 35.4171240),
    lon = c(-77.9658000, -96.6303900, -117.8362320, -80.6784760)
  ) -> to_code

  expect_that(gio_batch_reverse(to_code), is_a("data.frame"))

  expect_that(gio_geocode("1109 N Highland St, Arlington, VA", fields=c("cd", "stateleg")),
              is_a("data.frame"))

  expect_that(gio_geocode_components("1109 N Highland St", "Arlington", "VA",
                         fields=c("census", "stateleg")), is_a("data.frame"))

  expect_that(gio_reverse(38.9002898, -76.9990361, fields=c("census", "stateleg")),
              is_a("data.frame"))

  expect_that(gio_batch_geocode(addresses, fields=c("cd", "stateleg")), is_a("data.frame"))

  expect_that(gio_batch_reverse(to_code, fields=c("census", "stateleg")), is_a("data.frame"))

})
