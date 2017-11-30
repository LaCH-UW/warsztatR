
####################################################################
#                                                                  #
#               ZAJĘCIA 29.11.2017 @LaCH UW                 #
#                                                                  #
####################################################################

library(dplyr)
# historydata to paczka z przykładowymi danymi historycznymi
library(historydata)

# jeszcze krótko o dyplr
# group_by

a <- us_state_populations

# ile obserwacji dla danego roku
a %>% group_by(year) %>% summarize(count = n()) -> c2
# populacje dla każdego roku
a %>% group_by(year) %>% summarize(suma = sum(population)) -> c3
# populacje dla każdego stanu
a %>% group_by(state) %>% summarize(suma = sum(population)) -> c4

# arrange

a %>% arrange(population) -> c5
a %>% arrange(desc(population)) -> c6

######################################################
#               PRACA Z TEKSTAMI                     #
######################################################

# niezbędne paczki
library(jsonlite)
library(stringi)
library(readr)
library(tm)
library(stringr)

# zaczniemy od prostego, krótkiego tekstu
# dane: kilka przemówień i listów Andrzeja Dudy
# źródło: prezydent.pl
# pliki: /prezydent
# dostępne: https://github.com/LaCH-UW/warsztatR/tree/master/data/prezydent

# proste operacje na katalogach

# dir() - sprawdzanie zawartości bieżącego katalogu

dir()
list.files()

# sprawdzanie zawartości wybranego katalogu i wrzucenie jej do wektora

katalog <- dir('prezydent')
katalog <- list.files('prezydent')

# sprawdzenie wszystkich plików w katalogu

# jak policzyć liczbę plików w katalogu?
# length() - po prostu liczymy liczbę elementów w wektorze

length(katalog)

# operacje na plikach
file.create("testowyplik.txt")
file.remove("testowyplik.txt")

write_file(a,b)
write("sdfsdfsdf",'testowyplik.txt')

# wczytanie jednego pliku do wektora

# readLines (@readr) - wczytanie tekstu z zachowaniem porządku paragrafów
p1 <- readLines('prezydent/prezydent1.txt', encoding = "UTF-8")

# read_file (@readr) - wczytanie do wektora jednoelementowego (zachowane znaczniki końca linii \n)
p1 <- read_file('prezydent/prezydent1.txt')

# working directory
# setwd("~/Warsztaty/lachR/3/prezydent")
# setwd("~/Warsztaty/lachR/3")

# ok, wczytajmy sobie do wektora wszystkie pliki z katalogu prezydent
# żeby to zrobić napiszmy taką pętlę

p <- character(10)
p <- c(1:10)

p <- NULL

dir('prezydent')

for(i in 1:10) {
#  p <- NULL
  p[i] <- read_file(paste0('prezydent/',dir('prezydent')[i]))  
}

dir('prezydent')[4]

##################### 
######### własne funkcje

halloWorld <- function(x){
  # missing()
  if(missing(x)) {
    x <- "Cześć!"
  }
  cat(x)
}

# dzięki missing() możemy sprawdzić
# czy x jest zdefiniowany czy nie
# i jeśli nie, zaproponować wartość defaultową

######################################################
# konkordancja
######################################################


# wróćmy do tekstów
# mamy 10 tekstów przemówień w jednym wektorze
# spróbujmy zrobić prostą konkordancję dla wybranych wyrazów
# przykład konkordancji: https://www.faustyna.pl/zmbm/konkordancja-do-dzienniczka-sw-siostry-faustyny/

# 1. najpierw musimy podzielić poszczególne teksty na wyrazy
# można to zrobić natywną funkcją strsplit

# w argumencie II podajemy znak, po którym będzie dzielony wektor 
strsplit(p[1], " ")

# ale też paczka stringr ma wygodną funkcję words
words(p[1])
words(p[2])
# @stringi (bez znaków interpunkcyjnych)
stri_extract_all_words(p[1])
# podzielmy nasze teksty za pomocą pętli

p2 <- ""

for(i in 1:10){
  #p2[i] <- words(p[i])
  p2[i] <- strsplit(p[i], " ")
  # p2[i] <- stri_extract_all_words(p[i])
  # dla words() i stri_extract_all_words() pętlę należałoby
  # zmodyfikować, bo pojawiają się błędy
}

# otrzymaliśmy listę

p2

# prosta konkordancja

# zróbmy sobie funkcję c
# funkcja będzie wymagać wektora wieloelementowego, a nie listy

p3 <- unlist(p2)

# 2. przejdźmy po kolei po poleceniach

cc <- function(s,t) {
  # s - string, po którym generujemy zestawienie
  # t - text/korpus źródłowy
  v <- grep(s,t)
  # v to 234,237,443,456 
  a <- 1
  b <- NULL
  for(i in v) {
    i <- as.numeric(i)
    b[a] <- paste(t[i-3],t[i-2],t[i-1], t[i],t[i+1],t[i+2],t[i+3])
    # pewnie dałoby się to jakoś ładniej zapisać :/
    a <- a + 1
  }
  return(as.list(b))
}

k <- cc("histor",p3)

# działa! cała nasza funkcja opiera się na funkcji 
# grep()

grep("histor",p3)
p3[grep("histor",p3)]

################################################## 

# zadanie: # z treści tweetów #wolnesady zrobić konkordancję słowa "demokracja" i "wolność" (z odmianami)

#################################################
