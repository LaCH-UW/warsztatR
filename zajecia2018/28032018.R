

sc <- read.csv('scihub/poland_scihub.csv')
library(dplyr)

#V2, V6, V7, V8

sc <- sc[,-1]
#sc <- sc[,c(-1,-3)]

sc <- sc %>% select(V2,V6,V7,V8)

names(sc)

save(sc, file="scihub/sc.RData")

names(sc) <- c("artykul","miejscowosc","lat","lon")


View(as.data.frame(table(sc$miejscowosc)))
View(as.data.frame(table(sc$artykul)))

########

sc2 <- sc %>% group_by(miejscowosc,lat,lon) %>% summarise(liczba = n())

sum(sc2$liczba)

str(unique(sc$miejscowosc))

sc3 <- sc2 %>% group_by(miejscowosc) %>% summarise(pobrania = sum(liczba))


#### usuwanie

sc4 <- sc3 %>% filter(miejscowosc != "N/A")

# dane gograficzne

namiary <- sc2 %>%  group_by(miejscowosc) %>% summarise(lat1 = lat[1], lon1 = lon[1])

namiary <- namiary %>% filter(miejscowosc != "N/A")


#s <- 100:1000
#s[1]

dane <- inner_join(sc4,namiary)
dane.test <- merge(sc4,namiary)

t <- "Ala ma kota"

t %>% nchar()

t + nchar()

t <- 10
l <- 20

t + l


### generujemy mape

m <- leaflet(dane) %>%  addTiles() %>% addMarkers(as.double(dane$lon1),as.double(dane$lat1),popup=dane$miejscowosc)

options(digits=9)

as.double(dane$lat1[100])


### mapa #2

paste("Miejscowość:",dane$miejscowosc,"<br>Pobrania:",dane$pobrania)

m2 <- leaflet(dane) %>%  addTiles() %>% addMarkers(as.double(dane$lon1),as.double(dane$lat1),popup=paste("Miejscowość:",dane$miejscowosc,"<br>Pobrania:",dane$pobrania))

m2 %>% addProviderTiles(providers$CartoDB.Positron)

# https://rstudio.github.io/leaflet/basemaps.html


# labels

m3 <- leaflet(dane) %>%
        addTiles() %>%
          addMarkers(as.double(dane$lon1),as.double(dane$lat1),popup=paste("Miejscowość:",dane$miejscowosc,"<br>Pobrania:",dane$pobrania), label=paste("Liczba pobrań:",dane$pobrania)) %>%
            addProviderTiles(providers$CartoDB.Positron)

# ikona

m4 <- leaflet(dane) %>% addTiles()

m4 %>%  addMarkers(as.double(dane$lon1),as.double(dane$lat1),popup=paste("Miejscowość:",dane$miejscowosc,"<br>Pobrania:",dane$pobrania), label=paste("Liczba pobrań:",dane$pobrania), icon = )

icon = makeIcon(
  iconUrl = "happy.svg",
  iconWidth = ddm$pobrania/5000, iconHeight = ddm$pobrania/5000)





