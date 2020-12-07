#' eeval: Pakiet oceny emisji (emission evaluation)
#'
#' Pakiet zawiera trzy funkcje eeval_input(), eeval_calc(), eeval_draw()
#'
#' \code{eeval_input()} generuje dane wejsciowe
#'
#' \code{eeval_calc()} oblicza emisje
#'
#' \code{eeval_draw()} rysuje wykresy emisji
#'
#' @section Dane do obliczen:
#' Funkcje pakietu korzystaja z danych dolaczonych do pakietu.
#'
#' Dane sa dostepne dla uzytkownika jako obiekty \code{wskazniki}, \code{input}, \code{wynik_eeval}.
#'
#' @docType package
#' @name eeval
#' @import magrittr
#' @import dplyr
#' @import qpdf
#' @import utils
#' @import ggplot2
#' @importFrom rlang .data eval_tidy
#' @importFrom stats na.omit rnorm
NULL

utils::globalVariables(c("input", "wskazniki", "eeval_wynik"))
