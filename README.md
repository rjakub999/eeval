
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eeval

Pakiet utworzony w ramach przedmiotu Inwentaryzacja i Szacowanie
Emisji.  
Służy do obliczania emisji i wyswietlania wyników na wykresie.  
Funkcje korzystają z danych dołączonych do pakietu.

# Instalacja z winietą

``` r
# W razie potrzeby trzeba zainstalować pakiet devtools
if (!require(devtools)) {install.packages("devtools"); require(devtools)}

# Instalacja z GitHub
install_github("rjakub999/eeval", force = T, build_vignettes = T)
library(eeval)
```

Podgląd winiety

``` r
# w przeglądarce
browseVignettes("eeval")

# w oknie pomocy
vignette("eeval")
```
