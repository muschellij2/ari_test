
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ari\_test

The goal of `ari_test` is to provide a simple example for using
[`ari`](https://github.com/seankross/ari) on <http://shinyapps.io>. In
order to use `aws.polly`, you need to upload credentials to the repo.  
The app is hosted on <https://jhubiostatistics.shinyapps.io/ari_test/>
currently.

Currently, you must use `video_codec = NULL` and `ffmpeg_opts = "-strict
-2"` for it to work due to the `ffmpeg` installation on that platform.

The code only works with the `muschellij2/ari` version of `ari`
(<https://github.com/muschellij2/ari>) which can be installed by:

``` r
devtools::install_github("muschellij2/ari")
```

## Devtools Info

Here is the setup for running and publishing this app:

``` r
library(ari)
library(animation)
library(tuneR)
library(shiny)
devtools::session_info()
#> Session info -------------------------------------------------------------
#>  setting  value                       
#>  version  R version 3.5.1 (2018-07-02)
#>  system   x86_64, darwin15.6.0        
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  tz       America/Toronto             
#>  date     2018-09-24
#> Packages -----------------------------------------------------------------
#>  package       * version date       source                            
#>  animation     * 2.5     2017-03-30 CRAN (R 3.5.0)                    
#>  ari           * 0.2.0   2018-09-24 Github (muschellij2/ari@3d18d8e)  
#>  assertthat      0.2.0   2017-04-11 CRAN (R 3.5.0)                    
#>  aws.polly       0.1.2   2016-12-08 CRAN (R 3.5.0)                    
#>  aws.signature   0.4.4   2018-07-27 CRAN (R 3.5.0)                    
#>  backports       1.1.2   2017-12-13 CRAN (R 3.5.0)                    
#>  base          * 3.5.1   2018-07-05 local                             
#>  base64enc       0.1-3   2015-07-28 CRAN (R 3.5.0)                    
#>  colorout      * 1.2-0   2018-05-10 Github (jalvesaq/colorout@c42088d)
#>  compiler        3.5.1   2018-07-05 local                             
#>  crayon          1.3.4   2017-09-16 CRAN (R 3.5.0)                    
#>  datasets      * 3.5.1   2018-07-05 local                             
#>  devtools        1.13.6  2018-06-27 CRAN (R 3.5.0)                    
#>  digest          0.6.17  2018-09-12 CRAN (R 3.5.1)                    
#>  evaluate        0.11    2018-07-17 CRAN (R 3.5.0)                    
#>  graphics      * 3.5.1   2018-07-05 local                             
#>  grDevices     * 3.5.1   2018-07-05 local                             
#>  hms             0.4.2   2018-03-10 CRAN (R 3.5.0)                    
#>  htmltools       0.3.6   2017-04-28 CRAN (R 3.5.0)                    
#>  httpuv          1.4.5   2018-07-19 CRAN (R 3.5.0)                    
#>  httr            1.3.1   2017-08-20 CRAN (R 3.5.0)                    
#>  jsonlite        1.5     2017-06-01 CRAN (R 3.5.0)                    
#>  knitr           1.20    2018-09-21 Github (yihui/knitr@0da648b)      
#>  later           0.7.4   2018-08-31 CRAN (R 3.5.0)                    
#>  magrittr        1.5     2014-11-22 CRAN (R 3.5.0)                    
#>  MASS            7.3-50  2018-04-30 CRAN (R 3.5.1)                    
#>  memoise         1.1.0   2017-04-21 CRAN (R 3.5.0)                    
#>  methods       * 3.5.1   2018-07-05 local                             
#>  mime            0.5     2016-07-07 CRAN (R 3.5.0)                    
#>  pkgconfig       2.0.2   2018-08-16 CRAN (R 3.5.0)                    
#>  prettyunits     1.0.2   2015-07-13 CRAN (R 3.5.0)                    
#>  progress        1.2.0   2018-06-14 cran (@1.2.0)                     
#>  promises        1.0.1   2018-04-13 CRAN (R 3.5.0)                    
#>  purrr           0.2.5   2018-05-29 cran (@0.2.5)                     
#>  R6              2.2.2   2017-06-17 CRAN (R 3.5.0)                    
#>  Rcpp            0.12.18 2018-07-23 cran (@0.12.18)                   
#>  rlang           0.2.2   2018-08-16 CRAN (R 3.5.0)                    
#>  rmarkdown       1.10    2018-06-11 cran (@1.10)                      
#>  rprojroot       1.3-2   2018-01-03 CRAN (R 3.5.0)                    
#>  rvest           0.3.2   2016-06-17 CRAN (R 3.5.0)                    
#>  shiny         * 1.1.0   2018-05-17 CRAN (R 3.5.0)                    
#>  signal          0.7-6   2015-07-30 CRAN (R 3.5.0)                    
#>  stats         * 3.5.1   2018-07-05 local                             
#>  stringi         1.2.4   2018-07-20 cran (@1.2.4)                     
#>  stringr         1.3.1   2018-05-10 CRAN (R 3.5.0)                    
#>  tools           3.5.1   2018-07-05 local                             
#>  tuneR         * 1.3.3   2018-07-08 CRAN (R 3.5.0)                    
#>  utils         * 3.5.1   2018-07-05 local                             
#>  webshot         0.5.0   2017-11-29 CRAN (R 3.5.0)                    
#>  withr           2.1.2   2018-03-15 CRAN (R 3.5.0)                    
#>  xml2            1.2.0   2018-01-24 CRAN (R 3.5.0)                    
#>  xtable          1.8-3   2018-08-29 CRAN (R 3.5.0)                    
#>  yaml            2.2.0   2018-07-25 CRAN (R 3.5.0)
```
