#' Funkcja do wyznaczania wartosci emisji
#'
#'  Funkcja oblicza emisje na podstawie danych zawartych w zmiennej
#' \code{wskazniki} oraz przygotowanej w odpowiedni sposob zmiennej \code{input}.
#' W obiekcie \code{wskazniki} zapisane sa dane emisji z podzialem na rozne kategorie.
#' W obiekcie \code{input} zapisane sa wygenerowane losowo dane natezenia ruchu.
#'
#' @details Algorytm obliczen emisji:
#' Emisja = Nat x ((Alpha  x Procent^2 + Beta x Procent + Gamma +
#' (Delta/Procent)) / (Epsilon x Procent^2 + Zita x Procent + Hta) x (1- Reduction))
#'
#' @param dane data.frame - dane wejsciowe w formacie jak w obiekcie input
#' @param kategoria character - kategoria pojazdu - Passenger Cars itd.
#' @param euro character - norma dopuszczalnych emisji spalin - Euro 4 itd.
#' @param mode character - tryb jazdy pojazdu - Urban Peak itd.
#' @param substancja character - rodzaj emitowanego zanieczyszczenia - NOx itd.
#'
#' @return double
#'
#' @export
#'
#' @examples
#' # Obliczenie emisji dla parametrow domyslnych (input)
#'   eeval_wynik <- eeval_calc()
#'
#'\dontrun{
#' # Obliczenie emisji dla przykladowych danych input2
#' eeval_wynik2 <-
#'  eeval_calc(dane = input2,
#'             kategoria = "Passenger Cars",
#'             euro = c("Euro 3", "Euro 4", "Euro 5", "Euro 6 up to 2016"),
#'             substancja = c("EC", "CO", "NOx"),
#'             mode = "")
#'
#' # Obliczenie emisji dla przykladowych danych inut3
#' eeval_wynik3 <-
#'  eeval_calc(dane = input3,
#'             kategoria = "Buses",
#'             euro = c("Euro II", "Euro III", "Euro IV", "Euro V"),
#'             substancja = c("EC", "CO", "NOx", "NH3"),
#'             mode = "")
#'}
eeval_calc <- function(dane = input,
                       kategoria = "Passenger Cars",
                       # paliwo = "Petrol",   # wylaczamy, jezeli w inpucie
                       # segment = "Mini",    # wylaczamy, jezeli w inpucie
                       euro = c("Euro 3", "Euro 4", "Euro 5", "Euro 6 up to 2016"),
                       # technologia = "GDI", # wylaczamy, jezeli w inpucie
                       mode = "",
                       substancja = c("EC", "CO", "NOx")) {

  # SPRAWDZENIE POPRAWNOSCI ARGUMENTOW FUNKCJI
  if(!(is.character(kategoria)) ||
     !(is.character(euro)) ||
     !(is.character(mode)) ||
     !(is.character(substancja)))
  {stop("Nieprawidlowe parametry wejsciowe (musza byc character)")}

  if(length(kategoria) != length(intersect(kategoria,wskazniki$Category)))
  {stop("Nieprawidlowa wartosc dla parametru kategoria")}

  if(length(euro) != length(intersect(euro,wskazniki$Euro.Standard)))
  {stop("Nieprawidlowa wartosc dla parametru euro")}

  if(length(mode) != length(intersect(mode,wskazniki$Mode)))
  {stop("Nieprawidlowa wartosc dla parametru mode")}

  if(length(substancja) != length(intersect(substancja,wskazniki$Pollutant)))
  {stop("Nieprawidlowa wartosc dla parametru substancja")}

  # wyfiltrowanie
  wskazniki %>%
    dplyr::filter(.data$Category %in% kategoria) %>%
    # %in% oznacza: zawiera sie w... mozna wybrac 1,lub kilka
    # filter(Fuel %in% paliwo) %>%                # wylaczamy, jezeli w inpucie
    dplyr::filter(.data$Euro.Standard %in% euro) %>%
    # filter(Technology %in% technologia) %>%     # wylaczamy, jezeli w inpucie
    dplyr::filter(.data$Pollutant %in% substancja) %>%
    dplyr::filter(.data$Mode %in% mode) -> out

  # SPRAWDZENIE POPRAWNOSCI DANYCH
  # sprawdzenie czy sa wszytkie wymagane kolumny w danych
  if(!(("Nat" %in% colnames(dane)) &&
       ("Segment" %in% colnames(dane)) &&
       ("Fuel" %in% colnames(dane)) &&
       ("Technology" %in% colnames(dane)))) {
    stop("Nieprawidlowe dane wejsciowe (brak kolumny)")
  } else if(ncol(dane) != 4) {
    stop("Nieprawidlowe dane wejsciowe (liczba kolumn)")
  } else if((nrow(dane)  < 1) || (nrow(dane)  > 1000)) {
    stop("Nieprawidlowe dane wejsciowe (liczba wierszy min = 1, max = 1000)")
  }

  if(!(is.data.frame(dane))) {stop("Nieprawidlowe dane wejsciowe (format)")}
  if(any(is.null(dane))) {stop("Nieprawidlowe dane wejsciowe (puste wartosci)")}

  # print("************* INPUT ******************")
  # print(input)
  # print("************* DANE *******************")
  # print(dane)

  # obliczenia emisji
  # zeby policzyc wskazniki laczymy out i input po kolumnie Segment, Fuel, Techn.
  out <- dplyr::inner_join(x = out, y = dane, by =c("Segment", "Fuel", "Technology"))
  # powinno byc polaczenie out i dane, a nie out i input

  out <- na.omit(out) %>%
    dplyr::mutate(Emisja = .data$Nat * ((.data$Alpha * .data$Procent^2 +
                                           .data$Beta * .data$Procent +
                                           .data$Gamma +
                                           (.data$Delta/.data$Procent))/
                                          (.data$Epsilon * .data$Procent^2 +
                                             .data$Zita * .data$Procent +
                                             .data$Hta) * (1- .data$Reduction))
    ) %>%
    dplyr::select(.data$Category, .data$Fuel, .data$Euro.Standard,
                  .data$Technology, .data$Pollutant, .data$Mode,
                  .data$Segment, .data$Nat, .data$Emisja)

  if(nrow(out) == 0)
    stop("Dla podanej kombinacji parametrow nie itnieje zestaw danych")
  return(out)
}
