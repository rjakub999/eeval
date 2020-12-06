#' eeval: Pakiet oceny emisji (emission evaluation)
#'
#' Pakiet zawiera dwie funkcje:
#' eeval_calc oblicza emisje
#' eeval_draw rysuje wykresy emisji
#'
#' @section Dane do obliczen:
#' Funkcje pakietu korzystaja z danych dolaczonych do pakietu.
#'   Dane sa dostepne dla uzytkownika jako obiekty wskazniki i input.
#'
#' @section UWAGA: bez zaimportowania stats NOTE: brak pakietu dla na.omnit
#' po zaimportowaniu stats komunikaty ostrzegawcze, że dplyr::filter
#' nadisane przez stats::filter
#'
#' @docType package
#' @name eeval
#' @import magrittr
#' @import dplyr
#' @import qpdf
#' @import utils
#' @import stats
#' @import ggplot2
#' @importFrom rlang .data
NULL

utils::globalVariables(c("input", "wskazniki"))
