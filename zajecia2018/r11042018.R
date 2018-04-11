
# scraper & text mining

# 1. import listy adresow

adresy <- read.table("https://raw.githubusercontent.com/LaCH-UW/warsztatR/master/data/adresy.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

adresy <- adresy$V1

# 2. piszemy scraper

temp <- adresy[1]

library(xml2)
t <- read_html(temp, encoding = "UTF-8")
t <- xml_find_all(t, "//div[@class='td-post-content']")



