
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eeval

Pakiet utworzony w języku programowania R, w ramach przedmiotu
Inwentaryzacja i Szacowanie Emisji.  
Służy do wyznaczania emisji zanieczyszczeń generowanych przez pojazdy z
silnikami spalinowymi.  
Wyniki obliczeń można zaprezentowac na wykresach.  
Funkcje pakietu korzystają z danych dołączonych do pakietu.  
Plik źródłowy z surowymi danymi: `1.A.3.b.i-iv Road Transport Appendix 4
Emission Factors 2019.xlsx`  
nie jest dołączony do pakietu. Został on wstępnie przetworzony i
zapisany do obiektu `wskazniki`

Można też pobrać aktualną wersję pliku surowych danych ze strony: [eea
dane](https://www.eea.europa.eu/publications/emep-eea-guidebook-2019/part-b-sectoral-guidance-chapters/1-energy/1-a-combustion/road-transport-appendix-4-emission/view)

Dokumemntacja do tych danych jest zamieszczona na stronie: [eea
pdf](https://www.eea.europa.eu/publications/emep-eea-guidebook-2019/part-b-sectoral-guidance-chapters/1-energy/1-a-combustion/1-a-3-b-i/view)

Następnie można samodzielnie utworzyć obiekt `wskazniki`. W tym celu
należy użyć następującego kodu:

    library("openxlsx")
    katalog = "c:/sciezka_do_pliku/"
    setwd(katalog)
    plik_xlsx = "1.A.3.b.i-iv Road Transport Appendix 4 Emission Factors 2019.xlsx"
    wskazniki <- openxlsx::read.xlsx(xlsxFile = plik_xlsx, sheet = 2)
    
    wskazniki$Mode[is.na(wskazniki$Mode)] <- ""
    
    wskazniki <-wskazniki %>% 
      select(-`EF.[g/km].or.ECF.[MJ/km]`,
             -`Min.Speed.[km/h]`,
             -`Max.Speed.[km/h]`,
             -`Road.Slope`,
             -`Load`)
    
    colnames(wskazniki)[15:17] <- c("Reduction", "Bio", "Procent")
    
    save(wskazniki, file = "wskazniki.rda")

Peny opis pakietu znajduje się na stronie
[RPubs](https://rpubs.com/rjakub/eeval_winieta)

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
# utuchomienie funkcji z parametrami domyślnymi
eeval_calc()
eeval_draw()
```

## Podgląd winiety

``` r
browseVignettes("eeval")
```
