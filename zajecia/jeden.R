####################################################################
#                                                                  #
#               ZAJĘCIA I  8.11.2017 @LaCH UW                 #
#                                                                  #
####################################################################


# 
# url do danych
# https://github.com/LaCH-UW/warsztatR/blob/master/data/pisarze_dane.csv?raw=true
# uruchamianie polecen CRTL-ENTER
# jesli chcesz cały kod wysłać do konsoli, zaznacz wszystko i wciśnij enter

library(dplyr)
library(tidyr)

# proste operacje na data_frame

osoby <- as.data.frame(list(imie=c("Ala","Olek","Ania"),wiek=c("23","32","55")), stringsAsFactors = FALSE)

# lub data.frame

osoby2 <- data.frame(imie=c("Ala","Olek","Ania"),wiek=c("23","32","55"), stringsAsFactors = FALSE)

ramka <- data.frame(imie=c("Ala","Olek","Kuba","Maciej"),wiek=c(32,34,52,21), stringsAsFactors = FALSE)

tmp <- sum(ramka[1:2,2])

# CRTL + SHIFT + M

ramka %>% select(wiek) %>% sum() -> tmp
tmp <- ramka %>% select(wiek) %>% sum()
tmp = ramka %>% select(wiek) %>% sum()

rm(c(tmp,a))

imie <- ramka[3,1]

ramka <- rbind(ramka, c("Anna",53))

ramka[nrow(ramka) + 1,] <- c("Adam",62)

nrow(ramka)

ramka[2,2] <- ""

ramka <- cbind(ramka, miasto=c("Gdańsk","Warszawa","Warszawa","Sopot"), stringsAsFactors = FALSE)

ramka <- ramka[,-4]

table(ramka$miasto)


# dodawanie wiersza

osoby <- rbind(osoby, c("Marek", "22"))

# dodawanie kolumny

osoby <- cbind(osoby, miasto=c("Gdańsk", "Warszawa", "Warszawa", "Poznań"), stringsAsFactors=FALSE)

# liczba wierszy

nrow(osoby)

# usuwanie wiersza

str(osoby)

osoby <- osoby[-4,]

# usuwanie kolumny
# usuwamy wiek

osoby <- osoby[,-2]

x <- as.data.frame(table(ramka$miasto))

###########################
# dane

link <- "https://github.com/LaCH-UW/warsztatR/blob/master/data/pisarze_dane.csv?raw=true"

pisarze <- read.csv("https://github.com/LaCH-UW/warsztatR/blob/master/data/pisarze_dane.csv?raw=true", stringsAsFactors = FALSE)

# pisarze <- read.csv("dane/plik.csv",stringsAsFactors = FALSE)

# podstawowe filtrowanie

library(dplyr)

# umberto eco

pisarze %>% filter(imie_nazwisko == "Umberto Eco") -> p1

# pod czyim wpływem?

p1$pod_wplywem

# kto jeszcze pod wpływem Joyce'a?

pisarze %>% filter(pod_wplywem == "James Joyce") -> p2

# a teraz spróbujmy z Arystotelesem

pisarze %>% filter(pod_wplywem == "Arystoteles") -> p3

# jak widac powtarzaja sie nazwiska

# kto jest najwieksza inspiracja dla pisarzy i pisarek?
# uwaga - tu moze czaic sie blad? nie mozemy po prostu wyliczyc wystapien wartosci
# w polu pod_wplywem
# bo one sa powielane jesli postac ma kilka pseudonimow
# dlatego trzeba zrobic osobna tabelke dla tego badania

pisarze %>% select(imie_nazwisko,pod_wplywem) -> p4

# i wywalic z niej wszystkie elementy, gdzie nie istnieje inspiracja

p4 %>% filter (pod_wplywem != "") -> p4

# nadal mamy jednak wartosci zaburzajace interpretacje (zob. Józef Stalin)

p4[p4$imie_nazwisko == "Józef Stalin",]

# jak sobie z tym poradzić?
# korzystamy z funkcji unique()

p4 <- p4 %>% unique()

# sprawdzamy czy ok

p4[p4$imie_nazwisko == "Józef Stalin",]

# jest ok
# pozostaje zrobic statystyke - zliczyc wystapienia

inspiracje <- as.data.frame(table(p4$pod_wplywem))

View(inspiracje)

# jest tam duzo pojedynczych inspiracji - to nie ma wielkiej wartosci dla wykresu
# zliczmy wszystkie wystapienia o wartosci 1

inspiracje %>% filter(Freq == 1) %>% str()

# 516 - duzo niepotrzebnych danych - zróbmy od 5

inspiracje %>% filter(Freq > 5) -> inspiracje2 

# no to zróbmy wykres

library(ggplot2)
library(ggthemes)

# robimy wykres

ggplot(inspiracje2, aes(x=Var1,y=Freq)) + geom_bar(stat="Identity") + coord_flip()

# uporzadkujmy kolejnosc wyswietlania

ggplot(inspiracje2, aes(x=reorder(Var1, Freq),y=Freq)) + geom_bar(stat="Identity") + coord_flip()
ggplot(inspiracje2, aes(x=reorder(Var1, -Freq),y=Freq)) + geom_bar(stat="Identity") + coord_flip()

# zapiszmy sobie to wektora jako wykres

wykres <- ggplot(inspiracje2, aes(x=reorder(Var1, -Freq),y=Freq)) + geom_bar(stat="Identity") + coord_flip()

# i dalej dodawajmy

wykres + ggtitle("Testowy wykres") + ylab("liczba zainspirowanych pisarzy") + xlab("twórcy")

# theme

wykres + ggtitle("Testowy wykres") + ylab("liczba zainspirowanych pisarzy") + xlab("twórcy") + theme_minimal()

# ggthemes
# https://github.com/jrnold/ggthemes

wykres + ggtitle("Testowy wykres") + ylab("liczba zainspirowanych pisarzy") + xlab("twórcy") + theme_economist()
wykres + ggtitle("Testowy wykres") + ylab("liczba zainspirowanych pisarzy") + xlab("twórcy") + theme_wsj()
wykres + ggtitle("Testowy wykres") + ylab("liczba zainspirowanych pisarzy") + xlab("twórcy") + theme_solarized() +
  scale_colour_solarized("blue")

# a teraz zrobmy wykres punktowy
# wróćmy do pisarzy
# zróbmy sobie tabelke z imieniem_nazwiskiem,plcia,data_urodzenia
# i wrzucmy do wektora a (jak autorzy)

pisarze %>% select(imie_nazwisko,data_urodzenia,plec,data_urodzenia) -> a

# jak widac powielaja sie wiersze, zrobmy unique

a <- unique(a)

# uwaga na Pitagorasa (bledne dane)

a[a$imie_nazwisko == "Pitagoras",]

# wyczyscmy te bledy? jak? moze policzmy znaki w polu data

nchar(a[a$imie_nazwisko == "Pitagoras",2])
nchar(a[a$imie_nazwisko == "Umberto Eco",2])

# mozna uzupelnic recznie ewentualnie, jak ktos chce miec dobre dane
# i wywalmy te, gdzie jest ich za malo

a2 <- a %>% filter(nchar(data_urodzenia) == 20) 

# to sa dane z wikipedii, mozna szacowac np. to, o kim sie pisze a o kim nie
# generacyjnie, genderowo itp.
# bedziemy poslugiwac sie data urodzenia - ale na razie mamy cos takiego

a2$data_urodzenia[1]

# sa funkcje as.Date, strptime
# ale mozemy sie posluzyc gsub i uwtorzyc kolumne z samym rokiem

a2 %>% mutate(rok = gsub("-.*","",data_urodzenia)) -> a3

# uwaga! ale tam sa lata przed nasza era! wiec musimy skorzystac z funckji
#substr

a2 %>% mutate(rok = substr(data_urodzenia, start=1, stop=4)) -> a3

# rok zmienmy na rok_urodzenia

##a3 <- a3 %>% select(-data_urodzenia)

names(a3)

names(a3)[4] <- "rok_urodzenia"

# teraz zbudujmy wykres liniowy, ktory pokaze, jak zmienia sie liczba biogramow
# i plec opisywanych osob w zaleznosci od roku
# mamy dane lacznie dla 1085 roznych lat

# zbudujmy sobie wektor a4
# do tego musimy zmienic status kolumny rok urodzenia - zeby zawierala liczby
# wrzucmy do niego dane z a3, ale uporzadkujmy wg roku_urodzenia (za pomocą arrange())

a4 <- a3

a4$rok_urodzenia <- a4$rok_urodzenia %>% as.numeric()

a4 <- a4 %>% arrange(rok_urodzenia)

# generujemy dane do wykresu 

# 1. ile biogramow na rok?

biogramy <- a4 %>% group_by(rok_urodzenia) %>% summarize(biogramy=n())

#funkcja n() https://www.rdocumentation.org/packages/dplyr/versions/0.7.3/topics/n
# done 

# 2. ile plci dla kazdego roku?

# wyliczenie
# https://www.r-bloggers.com/dplyr-example-1/
# korzystamy z group_by
# The group_by() function first sets up how you want to group your data.

plcie <- a4 %>% group_by(rok_urodzenia,plec) %>% summarize(rozklad_plci=n())

# wrzucenie do kolumny kobiety mezczyzni itd
# korzystamy z uzytecznej paczki tidyr

library(tidyr)

plcie2 <- plcie %>% spread(plec,rozklad_plci)

# skladamy wykresssss

y <- biogramy$biogramy

plcie3 <- ungroup(plcie2)

dane <- plcie3 %>% mutate(biogramy=y)

# wykres liczby biogramow

w1 <- ggplot(dane, aes(x=rok_urodzenia,y=biogramy)) + geom_line()

#https://stackoverflow.com/questions/26195231/ggplot2-manually-specifying-colour-with-geom-line

# dodajemy dane o kobietach

w1 + geom_line(aes(x=rok_urodzenia,y=kobieta, colour="#000099")) 

# dodajemy dane o mezczyznach

w1 + geom_line(aes(x=rok_urodzenia,y=kobieta, colour="#000099")) + geom_line(aes(x=rok_urodzenia,y=mężczyzna, colour="#64FE2E"))

# z theme

w1 + geom_line(aes(x=rok_urodzenia,y=kobieta, colour="#000099")) + geom_line(aes(x=rok_urodzenia,y=mężczyzna, colour="#64FE2E")) + theme_wsj()

# plotly

library(plotly)

ggplotly(w1 + geom_line(aes(x=rok_urodzenia,y=kobieta, colour="#000099")) + geom_line(aes(x=rok_urodzenia,y=mężczyzna, colour="#64FE2E")) + theme_wsj())

# pie chart
# http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization

# liczba kobiet
lk <- dane %>% filter(!is.na(kobieta)) %>% nrow()
# liczba mężczyzn
lm <- dane %>% filter(!is.na(mężczyzna)) %>% nrow()
# obojnactwo
lo <- dane %>% filter(!is.na(obojnactwo)) %>% nrow()
#genderqueer
lg <- dane %>% filter(!is.na(genderqueer)) %>% nrow()
#transkobieta
ltk <- dane %>% filter(!is.na(transkobieta)) %>% nrow()
#transmezczyzna
ltm <- dane %>% filter(!is.na(transmężczyzna)) %>% nrow()

pl <- data.frame(plec=c("kobieta","mężczyzna","obojnactwo","genderqueer","transkobieta","transmężczyzna"),liczba=c(lk,lm,lo,lg,ltk,ltm), stringsAsFactors = FALSE)

names(pl)[1] <- "plec"

# wykres

plw <- ggplot(pl,aes(x="",y=liczba,fill=plec)) + geom_bar(width = 1, stat = "identity")

plw

plw + coord_polar("y", start=0)

#################

# wykres liniowy

wl22 <- ggplot(dane,aes(x=rok_urodzenia,y=biogramy)) + geom_line() + theme_solarized()

wl22

