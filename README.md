
`rgeocodio` : Tools to Work with the <https://geocod.io/> 'API'

NOTE: You need an [API key](https://dash.geocod.io/) to use this package.

The following functions are implemented:

-   `gio_auth`: Get or set GEOCODIO\_API\_KEY value
-   `gio_batch_geocode`: Geocode up to 10,000 addresses
-   `gio_batch_reverse`: Reverse geocode up to 10,000 coordinates
-   `gio_geocode`: Geocode a single address
-   `gio_geocode_components`: Geocode a single address
-   `gio_reverse`: Reverse geocode a single lat/lon pair

### TODO

-   enable selection of additional fields
-   better return types
-   more error checking
-   tests

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

    ## $input
    ## $input$address_components
    ## $input$address_components$number
    ## [1] "1109"
    ## 
    ## $input$address_components$predirectional
    ## [1] "N"
    ## 
    ## $input$address_components$street
    ## [1] "Highland"
    ## 
    ## $input$address_components$suffix
    ## [1] "St"
    ## 
    ## $input$address_components$formatted_street
    ## [1] "N Highland St"
    ## 
    ## $input$address_components$city
    ## [1] "Arlington"
    ## 
    ## $input$address_components$state
    ## [1] "VA"
    ## 
    ## $input$address_components$zip
    ## [1] "22201"
    ## 
    ## $input$address_components$country
    ## [1] "US"
    ## 
    ## 
    ## $input$formatted_address
    ## [1] "1109 N Highland St, Arlington, VA 22201"
    ## 
    ## 
    ## $results
    ##   address_components.number address_components.predirectional address_components.street address_components.suffix
    ## 1                      1109                                 N                  Highland                        St
    ##   address_components.formatted_street address_components.city address_components.county address_components.state
    ## 1                       N Highland St               Arlington          Arlington County                       VA
    ##   address_components.zip address_components.country                       formatted_address location.lat location.lng
    ## 1                  22201                         US 1109 N Highland St, Arlington, VA 22201     38.88667    -77.09473
    ##   accuracy accuracy_type                     source
    ## 1        1       rooftop Virginia GIS Clearinghouse

``` r
gio_geocode_components("1109 N Highland St", "Arlington", "VA")
```

    ## $input
    ## $input$address_components
    ## $input$address_components$number
    ## [1] "1109"
    ## 
    ## $input$address_components$predirectional
    ## [1] "N"
    ## 
    ## $input$address_components$street
    ## [1] "Highland"
    ## 
    ## $input$address_components$suffix
    ## [1] "St"
    ## 
    ## $input$address_components$formatted_street
    ## [1] "N Highland St"
    ## 
    ## $input$address_components$city
    ## [1] "Arlington"
    ## 
    ## $input$address_components$state
    ## [1] "VA"
    ## 
    ## $input$address_components$zip
    ## [1] "22201"
    ## 
    ## $input$address_components$country
    ## [1] "US"
    ## 
    ## 
    ## $input$formatted_address
    ## [1] "1109 N Highland St, Arlington, VA 22201"
    ## 
    ## 
    ## $results
    ##   address_components.number address_components.predirectional address_components.street address_components.suffix
    ## 1                      1109                                 N                  Highland                        St
    ##   address_components.formatted_street address_components.city address_components.county address_components.state
    ## 1                       N Highland St               Arlington          Arlington County                       VA
    ##   address_components.zip address_components.country                       formatted_address location.lat location.lng
    ## 1                  22201                         US 1109 N Highland St, Arlington, VA 22201     38.88667    -77.09473
    ##   accuracy accuracy_type                     source
    ## 1        1       rooftop Virginia GIS Clearinghouse

``` r
gio_reverse(38.9002898, -76.9990361)
```

    ## $results
    ##   address_components.number address_components.street address_components.suffix address_components.postdirectional
    ## 1                       500                         H                        St                                 NE
    ## 2                       800                       5th                        St                                 NE
    ## 3                       474                         H                        St                                 NE
    ##   address_components.formatted_street address_components.city address_components.county address_components.state
    ## 1                             H St NE              Washington      District of Columbia                       DC
    ## 2                           5th St NE              Washington      District of Columbia                       DC
    ## 3                             H St NE              Washington      District of Columbia                       DC
    ##   address_components.zip address_components.country                   formatted_address location.lat location.lng
    ## 1                  20002                         US   500 H St NE, Washington, DC 20002      38.9002    -76.99951
    ## 2                  20002                         US 800 5th St NE, Washington, DC 20002      38.9002    -76.99951
    ## 3                  20002                         US   474 H St NE, Washington, DC 20002      38.9002    -76.99994
    ##   accuracy  accuracy_type                                        source
    ## 1     1.00 nearest_street TIGER/Line® dataset from the US Census Bureau
    ## 2     0.18 nearest_street TIGER/Line® dataset from the US Census Bureau
    ## 3     0.18 nearest_street TIGER/Line® dataset from the US Census Bureau

``` r
gio_batch_geocode(c(
  "1109 N Highland St, Arlington VA",
  "525 University Ave, Toronto, ON, Canada",
  "4410 S Highway 17 92, Casselberry FL",
  "15000 NE 24th Street, Redmond WA",
  "17015 Walnut Grove Drive, Morgan Hill CA"
))
```

    ## $results
    ##                                      query response.input.address_components.number
    ## 1         1109 N Highland St, Arlington VA                                     1109
    ## 2  525 University Ave, Toronto, ON, Canada                                      525
    ## 3     4410 S Highway 17 92, Casselberry FL                                     4410
    ## 4         15000 NE 24th Street, Redmond WA                                    15000
    ## 5 17015 Walnut Grove Drive, Morgan Hill CA                                    17015
    ##   response.input.address_components.predirectional response.input.address_components.street
    ## 1                                                N                                 Highland
    ## 2                                             <NA>                               University
    ## 3                                             <NA>                             State Rte 17
    ## 4                                               NE                                     24th
    ## 5                                             <NA>                             Walnut Grove
    ##   response.input.address_components.suffix response.input.address_components.formatted_street
    ## 1                                       St                                      N Highland St
    ## 2                                      Ave                                     University Ave
    ## 3                                     <NA>                                       State Rte 17
    ## 4                                       St                                         NE 24th St
    ## 5                                       Dr                                    Walnut Grove Dr
    ##   response.input.address_components.city response.input.address_components.state response.input.address_components.zip
    ## 1                              Arlington                                      VA                                 22201
    ## 2                                Toronto                                      ON                                  <NA>
    ## 3                            Casselberry                                      FL                                 32707
    ## 4                                Redmond                                      WA                                 98052
    ## 5                            Morgan Hill                                      CA                                 95037
    ##   response.input.address_components.country             response.input.formatted_address
    ## 1                                        US      1109 N Highland St, Arlington, VA 22201
    ## 2                                        CA              525 University Ave, Toronto, ON
    ## 3                                        US     4410 State Rte 17, Casselberry, FL 32707
    ## 4                                        US          15000 NE 24th St, Redmond, WA 98052
    ## 5                                        US 17015 Walnut Grove Dr, Morgan Hill, CA 95037
    ##                                                                                                                                                                                                                                                                                                                                                                                                              response.results
    ## 1                                                                                                                                                                                                                                    1109, N, Highland, St, N Highland St, Arlington, Arlington County, VA, 22201, US, 1109 N Highland St, Arlington, VA 22201, 38.886665, -77.094733, 1, rooftop, Virginia GIS Clearinghouse
    ## 2                                                                                                                                                                                                                                                                        525, University, Ave, University Ave, Toronto, ON, CA, 525 University Ave, Toronto, ON, 43.656258, -79.388223, 1, rooftop, City of Toronto Open Data
    ## 3 4410, 4410, Us Hwy 17, Us Hwy 17, Us Hwy 17, Us Hwy 17, Casselberry, Casselberry, Seminole County, Seminole County, FL, FL, 32707, 32707, US, US, 4410 Us Hwy 17, Casselberry, FL 32707, 4410 Us Hwy 17, Casselberry, FL 32707, 28.671168, 28.670668, -81.33834, -81.338163, 1, 0.8, range_interpolation, range_interpolation, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau
    ## 4        15000, 15000, NE, NE, 24th, 24th, St, St, NE 24th St, NE 24th St, Redmond, Redmond, King County, King County, WA, WA, 98052, 98052, US, US, 15000 NE 24th St, Redmond, WA 98052, 15000 NE 24th St, Redmond, WA 98052, 47.631663, 47.631363, -122.141532, -122.141535, 1, 0.8, range_interpolation, range_interpolation, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau
    ## 5                                                                                                                                                                                                         Walnut Grove, Dr, Walnut Grove Dr, Morgan Hill, Santa Clara County, CA, 95037, US, Walnut Grove Dr, Morgan Hill, CA 95037, 37.138619, -121.64061, 0.8, street_center, TIGER/Line® dataset from the US Census Bureau

``` r
data.frame(
  lat = c(35.9746000, 32.8793700, 33.8337100, 35.4171240),
  lon = c(-77.9658000, -96.6303900, -117.8362320, -80.6784760)
) -> to_code

gio_batch_reverse(to_code)
```

    ## $results
    ##                  query
    ## 1     35.9746,-77.9658
    ## 2   32.87937,-96.63039
    ## 3 33.83371,-117.836232
    ## 4 35.417124,-80.678476
    ##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                results
    ## 1   101, 100, 125, State Hwy 58, Alston, Alston, State Hwy 58, N Alston St, S Alston St, Nashville, Nashville, Nashville, Nash County, Nash County, Nash County, NC, NC, NC, 27856, 27856, 27856, US, US, US, NA, N, S, NA, St, St, 101 State Hwy 58, Nashville, NC 27856, 100 N Alston St, Nashville, NC 27856, 125 S Alston St, Nashville, NC 27856, 35.974536, 35.974536, 35.974263, -77.965716, -77.965716, -77.965823, 1, 0.37, 0.36, nearest_street, nearest_street, nearest_street, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau
    ## 2                          100, 2961, 3084, E, S, S, Kingsley, 1st, 1st, Rd, St, St, E Kingsley Rd, S 1st St, S 1st St, Garland, Garland, Garland, Dallas County, Dallas County, Dallas County, TX, TX, TX, 75041, 75041, 75041, US, US, US, 100 E Kingsley Rd, Garland, TX 75041, 2961 S 1st St, Garland, TX 75041, 3084 S 1st St, Garland, TX 75041, 32.878693, 32.881541, 32.878897, -96.630918, -96.630962, -96.630992, 1, 0.92, 0.87, nearest_street, nearest_street, nearest_street, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau
    ## 3                     2700, 2566, 2790, N, N, N, Tustin, Tustin, Tustin, St, St, St, N Tustin St, N Tustin St, N Tustin St, Orange, Orange, Orange, Orange County, Orange County, Orange County, CA, CA, CA, 92865, 92865, 92865, US, US, US, 2700 N Tustin St, Orange, CA 92865, 2566 N Tustin St, Orange, CA 92865, 2790 N Tustin St, Orange, CA 92865, 33.832923, 33.830224, 33.834775, -117.836211, -117.836152, -117.836249, 1, 0, 0, nearest_street, nearest_street, nearest_street, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau
    ## 4 5968, 5500, 450, Village, York, Sportsman, Dr, St, Dr, NW, NW, NA, Village Dr NW, York St NW, Sportsman Dr, Concord, Concord, Concord, Cabarrus County, Cabarrus County, Cabarrus County, NC, NC, NC, 28027, 28027, 28027, US, US, US, 5968 Village Dr NW, Concord, NC 28027, 5500 York St NW, Concord, NC 28027, 450 Sportsman Dr, Concord, NC 28027, 35.413592, 35.41373, 35.420958, -80.675786, -80.67508, -80.675289, 1, 0.92, 0.89, nearest_street, nearest_street, nearest_street, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau, TIGER/Line® dataset from the US Census Bureau

### Test Results

``` r
library(rgeocodio)
library(testthat)

date()
```

    ## [1] "Sun Mar  5 14:40:22 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
