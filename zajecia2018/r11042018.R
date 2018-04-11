
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

