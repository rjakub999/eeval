#' Funkcja przygotowuje danedla funkcji eeval_calc() (wersja v2)
#'
#'
#' @param segm wektor wartosci Segment dla odpowiadajacej pozycji Category
#' @param nsample double
#'
#' @return data.frame
#'
#' @export
#'
#' @examples input2 <- eeval_input()
#'

eeval_input <- function(segm = c("Mini","Small","Medium","Large-SUV-Executive"),
                        n_spl = 300) {
  out <-
    data.frame(Nat = abs(rnorm(n_spl, mean = n_spl*2, sd = n_spl)),  # dodatnie
               Segment = sample(segm,
                                size = n_spl,replace = T) %>% as.character(),
               Fuel = sample(unique(wskazniki$Fuel),
                             size = n_spl, replace = T) %>% as.character(),
               Technology = sample(unique(wskazniki$Technology),
                                   size = n_spl, replace = T) %>% as.character())

  out$Segment = as.character(out$Segment)
  out$Fuel = as.character(out$Fuel)
  out$Technology = as.character(out$Technology)
  return(out)
}
