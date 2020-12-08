#' Funkcja rysuje wykresy emisji
#'
#' Funkcja rysuje wykresy emisji na podstawie danych utworzonych za pomoca \code{eeval_calc()}
#' Rodzaj wykresow jest ustalany automatycznie w zaleznosci od typu
#' zmiennej na osi x.
#' Dla zmiennej typu numeric rysowane sa wykresy punktowe z wygladzonymi liniami.
#' Dla zmiennej typu character rysowane sa wykresy pudelkowe.
#'
#'
#' @param dane data.frame
#' @param x character lub numeric - kolumna ramki danych na osi x
#' @param y numeric - kolumna ramki danych na osi y
#' @param z character - dane dla kolejnych wykresow
#' @param u character - dane dla kolejnych wykresow
#' @param nrow liczba wykresow w jednym wierszu
#' @param max_y maksymalna wartosc na osi y
#'
#' @return double
#'
#' @export
#'
#' @examples
#' # Narysowanie wykresow dla domyslnych danych
#' eeval_draw()
#'
#'\dontrun{
#' # Narysowanie wykresow dla przykladowych danych input2
#' eeval_draw(dane = eeval_wynik2,
#'            x = .data$Nat,
#'            y = .data$Emisja,
#'            z = .data$Pollutant,
#'            u = .data$Euro.Standard,
#'            nrow = 2,
#'            max_y = 2000)
#'
#' # Narysowanie wykresow dla przykladowych danych input3
#' eeval_draw(dane = eeval_wynik3,
#'            x = .data$Segment,
#'            y = .data$Emisja,
#'            z = .data$Pollutant,
#'            nrow = 2,
#'            max_y = 1000)
#'}
eeval_draw <- function(dane = eeval_wynik,
                       x = .data$Nat,
                       y = .data$Emisja,
                       z = .data$Pollutant,
                       u = .data$Euro.Standard,
                       nrow = 2,
                       max_y =3000) {

  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z)
  u <- enquo(u)

  # zapisanie do zmiennej calej kolumny x z ramki danych dane
  dane_x <- rlang::eval_tidy(enexpr(x), dane)

  if(is.character(dane_x)) {
    dane %>%
      mutate(obj_wrap = !!z) %>%
      ggplot(aes(!!x, !!y, fill = !!x)) +
      geom_boxplot()+
      theme_bw() +
      facet_wrap(~ obj_wrap, nrow = nrow) +
      scale_y_continuous(limits = c(0,max_y)) +
      theme(axis.text.x = element_text(angle = 90)) +
      ggtitle("Wykres dla zmienej kategorycznej na osi x")

  } else if (is.numeric(dane_x)) {
    dane %>%
      mutate(obj_wrap = !!u) %>%
      ggplot(aes(!!x, !!y)) +
      geom_point(aes(color = !!z)) +
      geom_smooth(aes(color = !!z)) +
      theme_bw() +
      facet_wrap(~ obj_wrap, nrow = nrow) +
      scale_y_continuous(limits = c(0,max_y)) +
      ggtitle("Wykres dla zmienej numerycznej na osi x")
  }
  # zabezpieczenie
  else
    print(" Nieprawidlowe dane dla osi x wykresu")
}
