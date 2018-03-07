# sciaganie danych

u <- "https://api.um.warszawa.pl/api/action/datastore_search?resource_id=ed6217dd-c8d0-4f7b-8bed-3b7eb81a95ba&limit=100"

drzewa <- fromJSON(u)

# przygotowywanie danych

drzewa <- drzewa$result$records

# wybor kolumn

drzewa1 <- drzewa[,c(3,16,19)]

# zmiana nazw kolumn

names(drzewa1)[2] <- "x"
names(drzewa1)[1] <- "y"



# chr do num

# zmiana ustawien ucinania liczb po przecinku
options(digits=9)

# chr do num

drzewa1$y <- as.numeric(drzewa1$y)
drzewa1$x <- as.numeric(drzewa1$x)

# skladanie mapy

d <- leaflet(data = drzewa1) %>% addTiles() %>% addMarkers(drzewa1$x,drzewa1$y,popup = drzewa$gatunek)

# wyswietlanie mapy

d
