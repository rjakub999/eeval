
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eeval

Pakiet utworzony w ramach przedmiotu Inwentaryzacja i Szacowanie
Emisji.  
Służy do obliczania emisji zanieczyszczeń generowanych przez pojazdy z
silnikami spalinowymi i wyswietlania wyników na wykresach.  
Funkcje korzystają z danych dołączonych do pakietu.  
Plik źródłowy z pierwotnymi danymi: `1.A.3.b.i-iv Road Transport
Appendix 4 Emission Factors 2019.xlsx` został wstępnie przetworzony i
zpisany do obiektu `wskazniki`.

## Instalacja z winietą

``` r
# W razie potrzeby trzeba zainstalować pakiet devtools
if (!require(devtools)) {install.packages("devtools"); require(devtools)}

# Instalacja z GitHub
install_github("rjakub999/eeval", force = T, build_vignettes = T)
library(eeval)
```

## Przykład zastosowania

``` r
library(eeval)
## basic example code
```

## Podgląd winiety

``` r
# w przeglądarce
browseVignettes("eeval")

# w oknie pomocy
vignette("eeval")
```
