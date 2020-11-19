#' Funkcja oblicza wartosc emisji
#'
#' Argumentami sa norma emisji spalin i rodzaj substancji (wskaznika)
#'
#' @param euro character
#' @param substancja character
#'
#' @return double
#' @export
#'
#' @examples eeval_calc(euro = "Euro 5", substancja = c("EC", "CO", "NOx"))
eeval_calc <- function(dane = input,
                        kategoria = "Passenger Cars",
                        # paliwo = "Petrol",   # wylaczamy, jezeli w inpucie
                        # segment = "Mini",    # wylaczamy, jezeli w inpucie
                        euro = "Euro 5",
                        # technologia = "GDI", # wylaczamy, jezeli w inpucie
                        mode = "",
                        substancja = c("EC", "CO")) {

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

  out <-
    wskazniki %>%
    filter(Category %in% kategoria) %>%  #zawiera sie w.. mozna wybrac 1,lub kilka
    # filter(Fuel %in% paliwo) %>%                # wylaczamy, jezeli w inpucie
    filter(Euro.Standard %in% euro) %>%
    # filter(Technology %in% technologia) %>%     # wylaczamy, jezeli w inpucie
    filter(Pollutant %in% substancja)
  # filter(Mode == mode)

  # SPRAWDZENIE POPRAWNOSCI DANYCH
  # sprawdzenie czy sa wszytkie wymagane kolumny w danych
  if(!(("Nat" %in% colnames(input)) &&
       ("Segment" %in% colnames(input)) &&
       ("Fuel" %in% colnames(input)) &&
       ("Technology" %in% colnames(input)))) {
    stop("Nieprawidlowe dane wejsciowe (brak kolumny)")
  } else if(ncol(input) != 4) {
    stop("Nieprawidlowe dane wejsciowe (liczba kolumn)")
  } else if((nrow(input)  < 1) || (nrow(input)  > 1000)) {
    stop("Nieprawidlowe dane wejsciowe (liczba wierszy)")
  }

  if(!(is.data.frame(input))) {stop("Nieprawidlowe dane wejsciowe (format)")}
  if(any(is.null(input))) {stop("Nieprawidlowe dane wejsciowe (puste wartosci)")}

  # zeby policzyc wskazniki laczymy out i input po kolumnie Segment, Fuel, Techn.
  out <- inner_join(x = out, y = input, by =c("Segment", "Fuel", "Technology"))

  out <- out %>%
    mutate(Emisja = Nat * ((Alpha * Procent^2 + Beta * Procent + Gamma + (Delta/Procent))/
                             (Epsilon * Procent^2 + Zita * Procent + Hta) * (1- Reduction))
    ) %>%
    select(Category, Fuel, Euro.Standard, Technology, Pollutant, Mode, Segment, Nat, Emisja)

  return(out)
}
