## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(nngeo)

## ---- include=FALSE------------------------------------------------------
data(cities)
data(towns)
data(water)

## ------------------------------------------------------------------------
cities

## ------------------------------------------------------------------------
towns

## ------------------------------------------------------------------------
water

## ----layers, fig.align='center', fig.width=5, fig.height=5, fig.cap='Visualization of the \\texttt{water}, \\texttt{towns} and \\texttt{cities} layers'----
plot(st_geometry(towns), col = NA)
plot(st_geometry(water), col = "lightblue", add = TRUE)
plot(st_geometry(towns), col = "grey", pch = 1, add = TRUE)
plot(st_geometry(cities), col = "red", pch = 1, add = TRUE)

## ------------------------------------------------------------------------
nn = st_nn(cities, towns[1:5, ], progress = FALSE)
nn

## ------------------------------------------------------------------------
l = st_connect(cities, towns[1:5, ], ids = nn, progress = FALSE)
l

## ----st_connect, fig.align='center', fig.width=5, fig.height=5, fig.cap="Nearest neighbor match between \\texttt{cities} (in red) and \\texttt{towns[1:5, ]} (in grey)"----
plot(st_geometry(towns[1:5, ]), col = "darkgrey")
plot(st_geometry(l), add = TRUE)
plot(st_geometry(cities), col = "red", add = TRUE)
text(st_coordinates(cities)[, 1], st_coordinates(cities)[, 2], 1:3, col = "red", pos = 4)
text(st_coordinates(towns[1:5, ])[, 1], st_coordinates(towns[1:5, ])[, 2], 1:5, pos = 4)

## ------------------------------------------------------------------------
nn = st_nn(cities, towns[1:5, ], sparse = FALSE, progress = FALSE)
nn

## ------------------------------------------------------------------------
nn = st_nn(cities, towns[1:5, ], k = 2, progress = FALSE)
nn

## ------------------------------------------------------------------------
nn = st_nn(cities, towns[1:5, ], sparse = FALSE, k = 2, progress = FALSE)
nn

## ------------------------------------------------------------------------
nn = st_nn(cities, towns[1:5, ], k = 2, returnDist = TRUE, progress = FALSE)
nn

## ------------------------------------------------------------------------
nn = st_nn(cities, towns[1:5, ], k = 2, maxdist = 50000, progress = FALSE)
nn

## ---- results='hide'-----------------------------------------------------
cities1 = st_join(cities, towns[1:5, ], join = st_nn, k = 2, maxdist = 50000)

## ------------------------------------------------------------------------
cities1

## ---- results='hide', warning=FALSE--------------------------------------
x = st_nn(cities, towns, k = 10)
l = st_connect(cities, towns, ids = x)

## ----cities_towns, fig.align='center', fig.width=5, fig.height=5, warning=FALSE, fig.cap="Nearest 10 \\texttt{towns} features from each \\texttt{cities} feature"----
plot(st_geometry(towns), col = "darkgrey")
plot(st_geometry(l), add = TRUE)
plot(st_geometry(cities), col = "red", add = TRUE)

## ------------------------------------------------------------------------
nn = st_nn(water[-1, ], towns, k = 20, progress = FALSE)

## ---- warning=FALSE------------------------------------------------------
l = st_connect(water[-1, ], towns, ids = nn, progress = FALSE, dist = 100)

## ----water_towns, fig.align='center', fig.width=5, fig.height=5, warning=FALSE, fig.cap="Nearest 20 \\texttt{towns} features from each \\texttt{water} polygon"----
plot(st_geometry(water[-1, ]), col = "lightblue", border = "grey")
plot(st_geometry(towns), col = "darkgrey", add = TRUE)
plot(st_geometry(l), col = "red", add = TRUE)

