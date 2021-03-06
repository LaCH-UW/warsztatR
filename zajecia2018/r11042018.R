
# 1. import listy adresow

adresy <- read.table("https://raw.githubusercontent.com/LaCH-UW/warsztatR/master/data/adresy.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

adresy <- adresy$V1

# 2. projektujemy scraper

temp <- adresy[1]

library(xml2)
t <- read_html(temp, encoding = "UTF-8")
t <- xml_find_all(t, "//div[@class='td-post-content']")
t <- gsub("<.*?>"," ", t)
t <- gsub("\n"," ",t,fixed = TRUE)
t <- gsub("\r"," ",t,fixed = TRUE)
t <- gsub("\t"," ",t,fixed = TRUE)
t <- gsub("„"," ",t, fixed = TRUE)
t <- gsub("”"," ",t, fixed = TRUE)
Encoding(t) <- 'UTF-8'
write(t, file = "listy/test.txt")

# 3. scraper do petli/funkcji

getkep <- function(a) {
  # a = lista adresów
  i <- 1
  library(xml2)
  for(e in a) {
    # e = element zestawu adresów (a)
    t <- read_html(e, encoding = "UTF-8")
    t <- xml_find_all(t, "//div[@class='td-post-content']")
    t <- gsub("<.*?>"," ", t)
    t <- gsub("\n"," ",t,fixed = TRUE)
    t <- gsub("\r"," ",t,fixed = TRUE)
    t <- gsub("\t"," ",t,fixed = TRUE)
    t <- gsub("„"," ",t, fixed = TRUE)
    t <- gsub("”"," ",t, fixed = TRUE)
    Encoding(t) <- 'UTF-8'
    write(t, file = paste0("listy/",i,".txt"))
    i <- i + 1
  }
}

# uruchamianie funkcji i sciaganie tresci
getkep(adresy)

# 4. budowa korpusu 

library(tm)

korpus <- VCorpus(DirSource('listy'))

content(korpus)

meta(korpus[[1]])

kopia_korpus <- korpus

# wielkie litery na małe

korpus <- tm_map(korpus,content_transformer(tolower))
korpus <- tm_map(korpus,stripWhitespace)
korpus <- tm_map(korpus,removeNumbers)
korpus <- tm_map(korpus,removePunctuation)
korpus <- tm_map(korpus,content_transformer(gsub),pattern = "–", replacement = " ", fixed = TRUE)

getLemma <- function(t,u) {
  library(httr)
  library(xml2)
  p <- list(lpmn="any2txt|wcrft2",text=t,user=u)
  s <- POST("http://ws.clarin-pl.eu/nlprest2/base/process", body = p, encode = "json", verbose())
  r <- content(s, "text")
  r <- gsub('[[:punct:] ]+','',unlist(as_list(xml_find_all(read_xml(r),"//base"))))
  return(r[r != ""])
}

korpus <- tm_map(korpus,content_transformer(getLemma),"i@i.pl")

# usuwamy stopwords
# need https://github.com/LaCH-UW/warsztatR/raw/master/data/pl_words.RData

korpus <- tm_map(korpus, removeWords, c(pl_words))

# 5. tworzymy document term matrix
# https://en.wikipedia.org/wiki/Document-term_matrix

dtm <- DocumentTermMatrix(korpus)

# popularnosc slow

p <- colSums(as.matrix(dtm))

# data frame ze satystyka wyrazow

p1 <- as.data.frame(list(slowo=names(p),liczba=p))

# usuwanie nielicznych wyrazow

dtm <- removeSparseTerms(dtm,0.1)

findAssocs(dtm,"gender",0.5)

as.matrix(dtm[, c("wiara","ojczyzna")])

