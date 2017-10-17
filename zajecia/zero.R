
####################################################################
#                                                                  #
#               LEKCJA ZEROWA  16.10.2017 @LaCH UW                 #
#                                                                  #
####################################################################

#w R komentarze rozpoczynają się hasztagiem #
#najpierw przygotujemy środowisko
#potrzebujemy bibliotek
# - dplyr - do łatwego przetwarzania ramek danych (data.frame)
# - ggplot2 - do przygotowywania wykresów

#po instalacji tych paczek ładujemy je do środowiska
# uwaga: postawienie kursora na końcu linii i wciśnięcie CRTL + ENTER uruchomi nam polecenie z tej linii
# wciśnięcie CRTL + ALT + ENTER uruchomi nam wszystkie polecenia z pliku (będą wczytywane od góry do dołu)

library(dplyr)

library(ggplot2)

#teraz stwórzmy sobie pusty wektor (zmienną) a

a <- ""

# zobaczymy ją w panelu środowisko (po prawej stronie okna RStudio)
# do a możemy wrzucić jakieś dane

a <- "Witaj świecie!"

# właśnie nadpisaliśmy wektor a
# możemy też do wektora wrzucić kilka elementów
# robimy to za pomocą funkcji c()

a <- c("Adam","Jarosław","Zygmut","Aniela","Bartek","dom")

# zobaczmy teraz zawartość tego wektora

a

# złożony z wielu elementów wektor to zbiór, z którego w razie potrzeby możemy wyciągać wybrane elementy
# np. adresując je bezpośrednio

a[2]

# wyświetli 
# [1] "Jarosław"

a[2:4]

# wyświetli elementy 2,3 i 4
# w odróżnieniu od innych popularnych języków programowania (np. PHP czy js) kolejność elementów
# liczymy nie od 0 ale od 1
# możemy też wyświetlić elementy w alternatywnej kolejności

a[c(2,1,4)]

# dzięki zastosowaniu funkcji c() wyświetliliśmy jako pierwszy element 2 (Jarosław), potem 1 (Adam)
# i na końcu element 4 (Aniela)

# możemy też wyszukiwać w takim wektorze

a[a == "Aniela"]

# otrzymamy 
#> a[a == "Aniela"]
#  [1] "Aniela"

# czy jest na sali Marek?

a[a == "Marek"]

# nie ma - otrzymaliśmy pusty ciąg
# character(0)

# dodajmy Marka do naszego wektora (który oryginalnie ma 5 elementów)
# możemy dodać go na koniec (jako element 6)

a[6] <- "Marek"

# mamy teraz 6 elementów
# ale może być tak, że liczba elementów będzie bardzo duża i bez sensu byłoby je liczyć 
# żeby sprawdzić, w którym miejscu dodać nowy element
# albo chcielibyśmy dodać nowy element np. na miejscu 2 czy 342
# aby to zrobić wykorzystujemy funkcję append()
# składnia jest taka
# append(nazwa_wektora,element,miejsce)
# czyli polecenie

a <- append(a, "Klaudia", 4)

# wrzuci nam obiekt "Klaudia" do wektora tuż za miejscem 4 (czyli na 5 miejsce)

a[5]

# a[5]
# [1] "Klaudia"
# bardziej zaawansowane działania z takimi wektorami będziemy ćwiczyć na kolejnych zajęciach 
# (m.in. wyszukiwanie po wyrażeniach regularnych)

# warto pamiętać, że funkcja c() przekształca swoje elementy
# zróbmy taki przykład: do wektora b wrzućmy 
# ciąg tekstowy (character), liczbę (numeric) i wartość logiczną (logic)

b <- c("Adam Mickiewicz", 1978, TRUE)

# po sprawdzeniu podsumowania tego wektora

summary(b)

# okazuje się, że mamy już do czynienia wyłącznie z elementami tekstowymi
# i przez to działanie takie jak to:

b[2] + 50 

# wygeneruje błąd (bo nie da się dodawać tekstów do liczb)
# aby zachować klasy obiektów w złożonym wektorze
# wykorzystujmy funkcję list()

c <- list("Adam Mickiewicz", 1978, TRUE)

# elementy z list adresujemy trochę inaczej niż w przypadku płaskiego złożonego wektora 
# generowanego funkcją c()

c[[1]][1]

# da nam obiekt/ciąg tekstowy "Adam Mickiewicz"
# tak samo jak

c[[1]]

# adresowanie komplikuje się przy bardziej złożonych listach
# poniższa lista zawiera nie tylko ciąg tekstowy i wartość logiczną,
# ale też złożone wektory (zbudowane za pomocą c())

lista <- list("Adam Mickiewicz",c(1798,1855),TRUE,c("Pan Tadeusz", "Dziady", "Konrad Wallenrod", "Grażyna", "Oda do młodości"))

# zobaczmy jaka jest struktura tej list (wykorzystamy funkcję str())

str(lista)

# List of 4
# $ : chr "Adam Mickiewicz"
# $ : num [1:2] 1798 1855
# $ : logi TRUE
# $ : chr [1:5] "Pan Tadeusz" "Dziady" "Konrad Wallenrod" "Grażyna" ...

# aby wyciągnąć "Pana Tadeusza" musimy zaadresować głębiej niż na jeden poziom
# zaadresowanie

lista[[4]]

# da nam cały wektor 
# dopiero

lista[[4]][1]

# da nam "Pana Tadeusza"
# oczywiście taki wynik możemy sobie wyciągnąć

tytul <- lista[[4]][1]

# dodajmy "Redutę Ordona" do zestawu tytułów na poziom 4 listy na pierwsze miejsce

lista[[4]] <- append(lista[[4]],"Reduta Ordona",0)

# a gdyby do listy dodać jeszcze inną listę (np. z wykazem prac o Mickiewiczu?)
# stwórzmy sobie pierwszą bibliografię
# źródło: https://pl.wikipedia.org/wiki/Adam_Mickiewicz

b1 <- list("S. Skwarczyńska", "Mickiewicza „Historia przyszłości” i jej realizacje literackie", "Łódź",1964)

# korzystam z list() a nie z c() żeby zachować datę wydania jako liczbę
# powtórzmy do dla innej pozycji

b2 <- list("Wł. Szturc","Teoria dramatu romantycznego w Europie XIX wieku","Kraków",1999)

# i teraz dodajmy do listy lista (na nowy poziom 5)

lista[[5]] <- list(b1,b2)

# struktura listy się nam komplikuje

str(lista)

# i np. żeby wyciągnąć datę wydania pracy Wł. Szturca (1999) musimy zrobić takie adresowanie:

lista[[5]][[2]][4][[1]]

# wyjaśnienie:
# schodzimy na poziom [[5]], gdzie mamy dwie listy
# potrzebujemy listy [[2]]
# wybieramy element [4] 
# jeśli na tym się zatrzymamy, dostaniemy listę z jednym elementem

# str(lista[[5]][[2]][4])
# List of 1
# $ : num 1999

# aby otrzymać tylko datę (jako obiekt numeric) musimy zejść jeszcze niżej, stąd [[1]]

str(lista[[5]][[2]][4][[1]])

# str(lista[[5]][[2]][4][[1]])
# num 1999

# proszę spróbować w podobny sposób wyciągnąć miejsce wydania pracy z 1964 roku

# nie jest to specjalnie użyteczne, chociaż listy przydają się ze względu na ich elastyczność
# przy pisaniu funkcji - wtedy uzupełniamy je i przetwarzamy automatycznie 
# (oczywiście po napisaniu odpowiedniego kodu)

# czasem wygodniejsze są ramki danych (data.frame)
# chociaż muszą mieć one strukturę która wyklucza taką elastyczność jaką mamy w liście
# przypominam, że mamy już 2 gotowe listy z danymi bibliograficznymi
# b1 i b2

# na nastepnych zajeciach bedziemy tworzyc data.frame bardziej wydajnie, teraz zrobmy to od zera

# w R dobrze zaprojektowana data.frame musi opierać się na dwóch zasadach:
# 1. każda zmienna posiada własną kolumne
# 2. każdy wiersz to jedna obserwacja
# czyli taki układ tabeli z kolumnami

# autor,tytul,miejsce_wydania,rok
# a,b,c,d
# a2,b2,c2,d2
# a3,b3,c3,d3

# stworzmy sobie kolumne 1 z lista nazwisk
k1 <- c("S. Skwarczyńska","Wł. Szturc")
# i dalej kolejne kolumny (zestawy zmiennych)
k2 <- c("Mickiewicza „Historia przyszłości” i jej realizacje literackie","Teoria dramatu romantycznego w Europie XIX wieku")
k3 <- c("Łódź","Kraków")
# a tutaj nie ciagi tekstowe, ale numeric
k4 <- c(1964,1999)

# teraz skorzystamy z funkcji as.data.frame()
# i od razu ustawiamy 
# stringsAsFactors = FALSE
# żeby nie pracować z faktorami tylko dowolnymi ciągami tekstowymi

tabelka <- as.data.frame(list(k1,k2,k3,k4), col.names = c("autor","tytul","miejsce_wydania","rok"), stringsAsFactors = FALSE)

# jeśli uruchomimy

View(tabelka)

# to zobaczmy podgląd
# popracujmy jednak na większej tabeli - żeby można było poćwiczyć sortowanie

# ściągnijmy do wektora tabelę z danymi bibliograficznymi
# wyciągniętymi z Polony 
# (proszę nie zwracać uwagi na jakość zestawu, to materiał do ćwiczeń)
# wykorzystujemy natywną funkcję read.csv

tabela2 <- read.csv("https://raw.githubusercontent.com/LaCH-UW/warsztatR/master/data/mickiewicz.csv", col.names = c("autor","tytul","miejsce_wydania","rok"), stringsAsFactors = FALSE)

# możemy podejrzeć tabelę

View(tabela2)

# operacje wyszukiwania na tabeli z wykorzystaniem pakietu dplyr i pipes
# https://www.r-bloggers.com/more-readable-code-with-pipes-in-r/

# pokaz mi książki, których autorem jest Adam Mickiewicz 
# (aby uzyskać %>% wciskamy CRTL + SHIFT + M)

w1 <- tabela2 %>% filter(autor == "Adam Mickiewicz")

View(w1)

# pokaz mi książki, których autorem jest Adam Mickiewicz i NIEzostały wydane we Lwowie

w2 <- tabela2 %>% filter(autor == "Adam Mickiewicz", miejsce_wydania != "Lwów")

View(w2)

# proszę zobaczyć, że funkcja wyświetliła także te pozycje, co do których nie mamy informacji
# o miejscu wydania (co wydaje się logiczne)
# kilka słów o składni z %>% 
# mamy funkcję zliczającą liczbę znaków w wektorze, np:

napis <- "Witaj świecie"

# i nchar()

nchar(napis)

# 13
# to samo możemy uzyskać w sposób taki:

napis %>% nchar()

# 13
# a więc polecenie
# w2 <- tabela2 %>% filter(autor == "Adam Mickiewicz", miejsce_wydania != "Lwów")
# składa się z:
# w2 - to nowy wektor, do którego wrzucimy wynik filtrowania (to będzie data.frame)
# tabela2 - nasze dane wejściowe
# %>% (pipe) - przekazuje je do funkcji filter()
# funkcja filter przyjmuje tu dwa argumenty 
# autor == "Adam Mickiewicz", miejsce_wydania != "Lwów"
# przy czym autor i miejsce_wydania to po prostu kolumny z tabeli tabela2
# posługujemy się tutaj operatorami logicznymi 
# https://www.statmethods.net/management/operators.html
# więcej pracy z tabelami na kolejnych zajęciach

# mając odpowiednie dane możemy zrobić prostą wizualizację
# zróbmy wykres pokazujący ile pozycji z naszej tabeli zostało wydanych w różnych miastach
# korzystamy z funkcji ggplot

wykres <- ggplot(tabela2, aes(x = miejsce_wydania, fill="#bf0a0a")) + geom_bar() + coord_flip()

wykres

# wygenerowaliśmy wykres, dane są poprawne, chociaż bez sensu pokazana jest pusta wartość i legenda
# o tym jak pracować z takimi wykresami, jak dodawać do nich różne elementy, przetwarzać na wykresy
# interaktywne i publikować online - o tym na następnych zajęciach

