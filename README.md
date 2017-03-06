
`rgeocodio` : Tools to Work with the <https://geocod.io/> 'API'

NOTE: You need an [API key](https://dash.geocod.io/) to use this package.

There is a *great deal* of API documentation in the main pacakge help page. It is *highly* suggested you do `help("rgeocodio-package")` after installing the package.

The following functions are implemented:

-   `gio_auth`: Get or set GEOCODIO\_API\_KEY value
-   `gio_batch_geocode`: Geocode up to 10,000 addresses
-   `gio_batch_reverse`: Reverse geocode up to 10,000 coordinates
-   `gio_geocode`: Geocode a single address
-   `gio_geocode_components`: Geocode a single address
-   `gio_reverse`: Reverse geocode a single lat/lon pair

All functions return tidy `tibble`s with sane column names.

### TODO

-   <strike>enable selection of additional fields</strike>
-   <strike>better return types</strike>
-   a tad more error checking (especially processing API [status codes](https://geocod.io/docs/#errors)
-   more/better tests along with full code coverage
-   Add R examples to the [official documentation](https://github.com/geocodio/docs)

### Installation

``` r
devtools::install_github("hrbrmstr/rgeocodio")
```

### Usage

``` r
library(rgeocodio)

# current verison
packageVersion("rgeocodio")
```

    ## [1] '0.1.0'

``` r
gio_geocode("1109 N Highland St, Arlington, VA")
```

    ## # A tibble: 1 × 16
    ##                         formatted_address accuracy accuracy_type                     source number predirectional
    ## *                                   <chr>    <int>         <chr>                      <chr>  <chr>          <chr>
    ## 1 1109 N Highland St, Arlington, VA 22201        1       rooftop Virginia GIS Clearinghouse   1109              N
    ## # ... with 10 more variables: street <chr>, suffix <chr>, formatted_street <chr>, city <chr>, county <chr>,
    ## #   state <chr>, zip <chr>, country <chr>, location_lat <dbl>, location_lng <dbl>

``` r
gio_geocode_components("1109 N Highland St", "Arlington", "VA")
```

    ## # A tibble: 1 × 16
    ##                         formatted_address accuracy accuracy_type                     source number predirectional
    ## *                                   <chr>    <int>         <chr>                      <chr>  <chr>          <chr>
    ## 1 1109 N Highland St, Arlington, VA 22201        1       rooftop Virginia GIS Clearinghouse   1109              N
    ## # ... with 10 more variables: street <chr>, suffix <chr>, formatted_street <chr>, city <chr>, county <chr>,
    ## #   state <chr>, zip <chr>, country <chr>, location_lat <dbl>, location_lng <dbl>

``` r
gio_reverse(38.9002898, -76.9990361)
```

    ## # A tibble: 3 × 16
    ##                     formatted_address accuracy  accuracy_type                                        source number
    ## *                               <chr>    <dbl>          <chr>                                         <chr>  <chr>
    ## 1   500 H St NE, Washington, DC 20002     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau    500
    ## 2 800 5th St NE, Washington, DC 20002     0.18 nearest_street TIGER/Line® dataset from the US Census Bureau    800
    ## 3   474 H St NE, Washington, DC 20002     0.18 nearest_street TIGER/Line® dataset from the US Census Bureau    474
    ## # ... with 11 more variables: street <chr>, suffix <chr>, postdirectional <chr>, formatted_street <chr>, city <chr>,
    ## #   county <chr>, state <chr>, zip <chr>, country <chr>, location_lat <dbl>, location_lng <dbl>

``` r
addresses <- c(
  "1109 N Highland St, Arlington VA",
  "525 University Ave, Toronto, ON, Canada",
  "4410 S Highway 17 92, Casselberry FL",
  "15000 NE 24th Street, Redmond WA",
  "17015 Walnut Grove Drive, Morgan Hill CA"
)

gio_batch_geocode(addresses)
```

    ## # A tibble: 5 × 12
    ##                                      query      response_results                            formatted_address number
    ## *                                    <chr>                <list>                                        <chr>  <chr>
    ## 1         1109 N Highland St, Arlington VA <data.frame [1 × 16]>      1109 N Highland St, Arlington, VA 22201   1109
    ## 2  525 University Ave, Toronto, ON, Canada <data.frame [1 × 13]>              525 University Ave, Toronto, ON    525
    ## 3     4410 S Highway 17 92, Casselberry FL <data.frame [2 × 14]>     4410 State Rte 17, Casselberry, FL 32707   4410
    ## 4         15000 NE 24th Street, Redmond WA <data.frame [2 × 16]>          15000 NE 24th St, Redmond, WA 98052  15000
    ## 5 17015 Walnut Grove Drive, Morgan Hill CA <data.frame [1 × 14]> 17015 Walnut Grove Dr, Morgan Hill, CA 95037  17015
    ## # ... with 8 more variables: predirectional <chr>, street <chr>, suffix <chr>, formatted_street <chr>, city <chr>,
    ## #   state <chr>, zip <chr>, country <chr>

``` r
data.frame(
  lat = c(35.9746000, 32.8793700, 33.8337100, 35.4171240),
  lon = c(-77.9658000, -96.6303900, -117.8362320, -80.6784760)
) -> to_code

gio_batch_reverse(to_code)
```

    ## # A tibble: 12 × 17
    ##                        formatted_address accuracy  accuracy_type                                        source number
    ##                                    <chr>    <dbl>          <chr>                                         <chr>  <chr>
    ## 1  101 State Hwy 58, Nashville, NC 27856     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau    101
    ## 2   100 N Alston St, Nashville, NC 27856     0.37 nearest_street TIGER/Line® dataset from the US Census Bureau    100
    ## 3   125 S Alston St, Nashville, NC 27856     0.36 nearest_street TIGER/Line® dataset from the US Census Bureau    125
    ## 4   100 E Kingsley Rd, Garland, TX 75041     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau    100
    ## 5       2961 S 1st St, Garland, TX 75041     0.92 nearest_street TIGER/Line® dataset from the US Census Bureau   2961
    ## 6       3084 S 1st St, Garland, TX 75041     0.87 nearest_street TIGER/Line® dataset from the US Census Bureau   3084
    ## 7     2700 N Tustin St, Orange, CA 92865     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau   2700
    ## 8     2566 N Tustin St, Orange, CA 92865     0.00 nearest_street TIGER/Line® dataset from the US Census Bureau   2566
    ## 9     2790 N Tustin St, Orange, CA 92865     0.00 nearest_street TIGER/Line® dataset from the US Census Bureau   2790
    ## 10 5968 Village Dr NW, Concord, NC 28027     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau   5968
    ## 11    5500 York St NW, Concord, NC 28027     0.92 nearest_street TIGER/Line® dataset from the US Census Bureau   5500
    ## 12   450 Sportsman Dr, Concord, NC 28027     0.89 nearest_street TIGER/Line® dataset from the US Census Bureau    450
    ## # ... with 12 more variables: street <chr>, formatted_street <chr>, city <chr>, county <chr>, state <chr>, zip <chr>,
    ## #   country <chr>, predirectional <chr>, suffix <chr>, location_lat <dbl>, location_lng <dbl>, postdirectional <chr>

### Extra Fields

``` r
gio_geocode("1109 N Highland St, Arlington, VA", fields=c("cd", "stateleg"))
```

    ## # A tibble: 1 × 24
    ##                         formatted_address accuracy accuracy_type                     source number predirectional
    ## *                                   <chr>    <int>         <chr>                      <chr>  <chr>          <chr>
    ## 1 1109 N Highland St, Arlington, VA 22201        1       rooftop Virginia GIS Clearinghouse   1109              N
    ## # ... with 18 more variables: street <chr>, suffix <chr>, formatted_street <chr>, city <chr>, county <chr>,
    ## #   state <chr>, zip <chr>, country <chr>, location_lat <dbl>, location_lng <dbl>, congressional_district_name <chr>,
    ## #   congressional_district_district_number <int>, congressional_district_congress_number <chr>,
    ## #   congressional_district_congress_years <chr>, state_legislative_districts_senate_name <chr>,
    ## #   state_legislative_districts_senate_district_number <chr>, state_legislative_districts_house_name <chr>,
    ## #   state_legislative_districts_house_district_number <chr>

``` r
gio_geocode_components("1109 N Highland St", "Arlington", "VA",
                      fields=c("census", "stateleg"))
```

    ## # A tibble: 1 × 27
    ##                         formatted_address accuracy accuracy_type                     source number predirectional
    ## *                                   <chr>    <int>         <chr>                      <chr>  <chr>          <chr>
    ## 1 1109 N Highland St, Arlington, VA 22201        1       rooftop Virginia GIS Clearinghouse   1109              N
    ## # ... with 21 more variables: street <chr>, suffix <chr>, formatted_street <chr>, city <chr>, county <chr>,
    ## #   state <chr>, zip <chr>, country <chr>, location_lat <dbl>, location_lng <dbl>,
    ## #   state_legislative_districts_senate_name <chr>, state_legislative_districts_senate_district_number <chr>,
    ## #   state_legislative_districts_house_name <chr>, state_legislative_districts_house_district_number <chr>,
    ## #   census_census_year <int>, census_state_fips <chr>, census_county_fips <chr>, census_place_fips <chr>,
    ## #   census_tract_code <chr>, census_block_code <chr>, census_block_group <chr>

``` r
gio_reverse(38.9002898, -76.9990361, fields=c("census", "stateleg"))
```

    ## # A tibble: 3 × 25
    ##                     formatted_address accuracy  accuracy_type                                        source number
    ## *                               <chr>    <dbl>          <chr>                                         <chr>  <chr>
    ## 1   500 H St NE, Washington, DC 20002     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau    500
    ## 2 800 5th St NE, Washington, DC 20002     0.18 nearest_street TIGER/Line® dataset from the US Census Bureau    800
    ## 3   474 H St NE, Washington, DC 20002     0.18 nearest_street TIGER/Line® dataset from the US Census Bureau    474
    ## # ... with 20 more variables: street <chr>, suffix <chr>, postdirectional <chr>, formatted_street <chr>, city <chr>,
    ## #   county <chr>, state <chr>, zip <chr>, country <chr>, location_lat <dbl>, location_lng <dbl>,
    ## #   state_legislative_districts_senate_name <chr>, state_legislative_districts_senate_district_number <chr>,
    ## #   census_census_year <int>, census_state_fips <chr>, census_county_fips <chr>, census_place_fips <chr>,
    ## #   census_tract_code <chr>, census_block_code <chr>, census_block_group <chr>

``` r
gio_batch_geocode(addresses, fields=c("cd", "stateleg"))
```

    ## # A tibble: 5 × 12
    ##                                      query      response_results                            formatted_address number
    ## *                                    <chr>                <list>                                        <chr>  <chr>
    ## 1         1109 N Highland St, Arlington VA <data.frame [1 × 24]>      1109 N Highland St, Arlington, VA 22201   1109
    ## 2  525 University Ave, Toronto, ON, Canada <data.frame [1 × 13]>              525 University Ave, Toronto, ON    525
    ## 3     4410 S Highway 17 92, Casselberry FL <data.frame [2 × 22]>     4410 State Rte 17, Casselberry, FL 32707   4410
    ## 4         15000 NE 24th Street, Redmond WA <data.frame [2 × 24]>          15000 NE 24th St, Redmond, WA 98052  15000
    ## 5 17015 Walnut Grove Drive, Morgan Hill CA <data.frame [1 × 22]> 17015 Walnut Grove Dr, Morgan Hill, CA 95037  17015
    ## # ... with 8 more variables: predirectional <chr>, street <chr>, suffix <chr>, formatted_street <chr>, city <chr>,
    ## #   state <chr>, zip <chr>, country <chr>

``` r
gio_batch_reverse(to_code, fields=c("census", "stateleg"))
```

    ## # A tibble: 12 × 28
    ##                        formatted_address accuracy  accuracy_type                                        source number
    ##                                    <chr>    <dbl>          <chr>                                         <chr>  <chr>
    ## 1  101 State Hwy 58, Nashville, NC 27856     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau    101
    ## 2   100 N Alston St, Nashville, NC 27856     0.37 nearest_street TIGER/Line® dataset from the US Census Bureau    100
    ## 3   125 S Alston St, Nashville, NC 27856     0.36 nearest_street TIGER/Line® dataset from the US Census Bureau    125
    ## 4   100 E Kingsley Rd, Garland, TX 75041     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau    100
    ## 5       2961 S 1st St, Garland, TX 75041     0.92 nearest_street TIGER/Line® dataset from the US Census Bureau   2961
    ## 6       3084 S 1st St, Garland, TX 75041     0.87 nearest_street TIGER/Line® dataset from the US Census Bureau   3084
    ## 7     2700 N Tustin St, Orange, CA 92865     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau   2700
    ## 8     2566 N Tustin St, Orange, CA 92865     0.00 nearest_street TIGER/Line® dataset from the US Census Bureau   2566
    ## 9     2790 N Tustin St, Orange, CA 92865     0.00 nearest_street TIGER/Line® dataset from the US Census Bureau   2790
    ## 10 5968 Village Dr NW, Concord, NC 28027     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau   5968
    ## 11    5500 York St NW, Concord, NC 28027     0.92 nearest_street TIGER/Line® dataset from the US Census Bureau   5500
    ## 12   450 Sportsman Dr, Concord, NC 28027     0.89 nearest_street TIGER/Line® dataset from the US Census Bureau    450
    ## # ... with 23 more variables: street <chr>, formatted_street <chr>, city <chr>, county <chr>, state <chr>, zip <chr>,
    ## #   country <chr>, predirectional <chr>, suffix <chr>, location_lat <dbl>, location_lng <dbl>,
    ## #   state_legislative_districts_senate_name <chr>, state_legislative_districts_senate_district_number <chr>,
    ## #   state_legislative_districts_house_name <chr>, state_legislative_districts_house_district_number <chr>,
    ## #   census_census_year <int>, census_state_fips <chr>, census_county_fips <chr>, census_place_fips <chr>,
    ## #   census_tract_code <chr>, census_block_code <chr>, census_block_group <chr>, postdirectional <chr>

### Test Results

``` r
library(rgeocodio)
library(testthat)

date()
```

    ## [1] "Mon Mar  6 11:44:09 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 10 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
