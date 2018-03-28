
library(dplyr)

sc <- sc %>% select(V2,V6,V7,V8)


names(sc) <- c("artykul","miejscowosc","lat","lon")
save(sc, file="scihub/sc.RData")


View(as.data.frame(table(sc$miejscowosc)))
View(as.data.frame(table(sc$artykul)))

########

sc2 <- sc %>% group_by(miejscowosc,lat,lon) %>% summarise(liczba = n())

sum(sc2$liczba)

str(unique(sc$miejscowosc))

sc3 <- sc2 %>% group_by(miejscowosc) %>% summarise(pobrania = sum(liczba))

#### usuwanie

sc4 <- sc3 %>% filter(miejscowosc != "N/A")
