

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


