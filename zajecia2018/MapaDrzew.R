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

d <- leaflet(data = drzewa1) %>% addTiles() %>% addMarkers(drzewa1$x,drzewa1$y,popup = drzewa1$gatunek)

# wyswietlanie mapy

d

########################################


# przyklad #2

u <- "https://api.um.warszawa.pl/api/action/datastore_search?resource_id=ed6217dd-c8d0-4f7b-8bed-3b7eb81a95ba&limit=100"

drzewa <- fromJSON(u)

drzewa <- drzewa$result$records
drzewa1 <- drzewa[,c(3,16,19,2)]

names(drzewa1)[2] <- "x"
names(drzewa1)[1] <- "y"

options(digits=9)

drzewa1$y <- as.numeric(drzewa1$y)
drzewa1$x <- as.numeric(drzewa1$x)

d <- leaflet(data = drzewa1) %>% addTiles() %>% addMarkers(drzewa1$x,drzewa1$y,popup = paste('<strong>Gatunek</strong>:<em>',drzewa1$gatunek,"</em><br><strong>Stan zdrowia</strong>:",drzewa1$stan_zdrowia))

d

#######################################


mmap <- function(e) {
  require(jsonlite)
  require(leaflet)
  d <- fromJSON(URLencode(e))
  options(digits=9)
  d <- d$result$records
  d <- d[,c(3,16,19,2)]
  names(d)[2] <- "x"
  names(d)[1] <- "y"
  d$y <- as.numeric(d$y)
  d$x <- as.numeric(d$x)
  m <- leaflet(data = d) %>% addTiles() %>% addMarkers(d$x,d$y,popup = paste('<strong>Gatunek</strong>:<em>',d$gatunek,"</em><br><strong>Stan zdrowia</strong>:",d$stan_zdrowia))
  return(m)
}

##################

mmap2 <- function(k,w,l) {
  a <- "https://api.um.warszawa.pl/api/action/datastore_search?resource_id=ed6217dd-c8d0-4f7b-8bed-3b7eb81a95ba"
  f <- paste0('&filters={"',k,'":"',w,'"}')
  f2 <- paste0("&limit=",l)
  u <- paste0(a,URLencode(f),f2)
  cat(u)
#  return()
  require(jsonlite)
  require(leaflet)
  d <- fromJSON(u)
  options(digits=9)
  d <- d$result$records
  d <- d[,c(3,16,19,2)]
  names(d)[2] <- "x"
  names(d)[1] <- "y"
  d$y <- as.numeric(d$y)
  d$x <- as.numeric(d$x)
  m <- leaflet(data = d) %>% addTiles() %>% addMarkers(d$x,d$y,popup = paste('<strong>Gatunek</strong>:<em>',d$gatunek,"</em><br><strong>Stan zdrowia</strong>:",d$stan_zdrowia))
  return(m)
}

w <-  mmap2("dzielnica","Wola",100)
