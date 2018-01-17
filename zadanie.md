
Zadanie A:

==================================================

1. Na stronie https://api.um.warszawa.pl/ znaleźć 'Ewidencję Budynków i Lokali' i pobrać przez API dane dotyczące wyłącznie budynków mieszkalnych.

Podpowiedź: dane udostępniane są w formacie JSON; korzystamy z pakietu jsonlite; pozyskane dane odpowiednio formatujemy do data.frame

2. Stworzyć ramkę danych zawierającą informację o tym, ile miejsc postojowych jest dostępnych przy lokalach w danej dzielnicy.

Podpowiedź: 

* sprawdź, czy dane są dobrej jakości (jakie wartości należałoby usunąć)?
* filtrując dane korzystaj z %>% filter() w pakiecie dplyr
* należy użyć funkcji group_by() i summarise()

group_by(dzielnica) %>% summarise(lacznaLiczba = sum(liczbaMiejscPostojowych))

group_by zgrupuje nam dane po wartosciach kolumny 'dzielnica', a summarise stworzy nowa data.frame, zawierajaca kolumne 'dzielnica' oraz sume miejsc postojowych dla dzielnicy

3. Wygenerować pakietem ggplot2 wykres słupkowy pokazujący liczbę miejsc postojowych w zaleźności od dzielnicy. 

Podpowiedź: 

* użyj geom_bar(stat="identity")

4. Dopracować wykres dodając wybrany szablon z ggthemes oraz podpisy nazw osi i tytuł wykresu. Pokolorować każdy ze słupków.

Podpowiedź: 

* użyj https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

5. Za pomocą pakietu knitr wygenerować raport z tabelką zawierającą dane o dzielnicach i miejscach postojowych, wykresem oraz przykładowym tekstem i grafiką dostępną pod adresem 

https://cdn.pixabay.com/photo/2016/11/29/08/57/buildings-1868555_640.jpg

podpowiedź

* użyj https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf

=================================

Zadanie B

1. Napisz funkcję, która:
- zczyta dowolny tekst (plik txt) z sieci lub dysku;
- wyliczy liczę występowań wybranych fraz (nie tylko jednej frazy) w tym tekście i zapisze ją do data.frame
- na życzenie wygeneruje wykres porównujący liczbę wystąpień wybranych fraz


Podpowiedź:
* zastanów się, jakie argumenty powinna przyjmować ta funkcja
* generując data.frame używaj rbind()
* pamiętaj o kodowaniu fontów (UTF-8) i usuwaniu faktorów
* jeden z argumentów funkcji powinien być binarny
* używaj takich funkcji jak scan(), strsplit(), table(), names()


