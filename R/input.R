#' Dane pomocnicze dla funkcji szacowania emisji
#'
#' Z obiektu wskaznik
#' zostało wylosowane 50 wierszy i zapisane do pliku input.rda
#'
#' @format Ramka danych zawiera:
#' \describe{
#'  \item{Nat}{Nat = abs(rnorm(50, mean = 100, sd = 50))}
#'  \item{Segment}{sample(c("Mini","Small","Medium","Large-SUV-Executive"), ...}
#'  \item{Fuel}{sample(unique(wskazniki$Fuel), ...}
#'  \item{Technology}{sample(unique(wskazniki$Technology), ...}
#' }
#'
#' @examples
#' input
"input"
