
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eeval

Pakiet utworzony w języku programowania R, w ramach przedmiotu
Inwentaryzacja i Szacowanie Emisji.  
Służy do wyznaczania emisji zanieczyszczeń generowanych przez pojazdy z
silnikami spalinowymi.  
Wyniki obliczeń można zaprezentowac na wykresach.  
Funkcje pakietu domyślnie korzystają z danych dołączonych do pakietu.  
Plik źródłowy z surowymi danymi: `1.A.3.b.i-iv Road Transport Appendix 4
Emission Factors 2019.xlsx`  
nie jest dołączony do pakietu. Został on wstępnie przetworzony i
zapisany do obiektu `wskazniki`.  
Dodatkowo do działania pakietu używany jest obiekt `input`.

## Instalacja z winietą

``` r
# w razie potrzeby należy zainstalować pakiet devtools
if (!require(devtools)) {install.packages("devtools"); require(devtools)}

# instalacja z GitHub
install_github("rjakub999/eeval", force = T, build_vignettes = T)
library(eeval)
```

## Przykład zastosowania

Pliki danych `wskaźniki` i `input` zawarte w pakiecie umożliwiają
szybkie zaznajomienie się z funkcjami pakietu.  
W tym celu uruchomiamy funkcje z domyślnymi parametrami i od razu mamy
obliczone emisje i narysowane wykresy.

``` r
eeval_calc()
eeval_draw()
```

## Przygotowanie własnych danych

W celu lepszego wykorzystanie możliwośći pakietu (w tym przeprowadzanie
analiz na innych danych) zachęcam do zapoznania się z winietą.
Uruchomienie winiety z poziomu RStudio można wywołać poleceniem:

``` r
browseVignettes("eeval")
```

Pełny opis pakietu znajduje się też na stronie
[RPubs](https://rpubs.com/rjakub/eeval_winieta)
