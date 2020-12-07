#' Funkcja przygotowuje dane dla eeval_calc()
#'
#' Funkcja generuje losowe dane natezenia ruchu i dolacza do nich
#' wybrany segment pojazdow i losowo dobrane parametry zuzycia paliwa
#' i technologii silnika.
#'
#' @param segm wektor wartosci Segment dla odpowiadajacej pozycji Category.
#'
#' @param n_spl liczba losowo generowanych danych natezenia ruchu
#'
#' @return data.frame
#'
#' @export
#'
#' @examples
#' #Uruchomienie funkcji z parametrami domyslnymi
#' input2 <- eeval_input()
#'
#' # Wygenerowanie innych danych
#' input3 <- eeval_input(segm = c("Urban Buses Midi <=15 t",
#' "Urban Buses Standard 15 - 18 t",
#' "Urban Buses Articulated >18 t",
#' "Coaches Standard <=18 t"),
#' n_spl = 200)
#'
#' @details
#' W celu uzyskania dostepnych wartosci Segment w danej Category zastosuj np.:
#'
#' \code{wskazniki %>%
#' filter(Category == "Buses") %>%
#' select(Segment) %>% unique()}

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
