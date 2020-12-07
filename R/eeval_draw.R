#' Funkcja rysuje wykresy na podstawie danych z obliczen eeval_calc()
#'
#'
#' @param dane data.frame
#' @param x character/numeric
#' @param y character
#' @param z character
#' @param u character
#' @param nrow numeric
#' @param skala_y numeric
#'
#' @return double
#'
#' @export
#'
#' @examples eeval_draw()
#'

eeval_draw <- function(dane = eeval_wynik,
                       x = .data$Nat,
                       y = .data$Emisja,
                       z = .data$Pollutant,
                       u = .data$Euro.Standard,
                       nrow = 2,
                       skala_y =3000) {

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
      scale_y_continuous(limits = c(0,skala_y)) +
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
      scale_y_continuous(limits = c(0,skala_y)) +
      ggtitle("Wykres dla zmienej numerycznej na osi x")
  }
  # zabezpieczenie
  else
    print(" Nieprawidlowe dane dla osi x wykresu")
}
