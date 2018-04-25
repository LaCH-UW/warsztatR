
#warto przetestowac
# https://cran.r-project.org/web/packages/SocialMediaLab/SocialMediaLab.pdf


########################## twitteR
# zakładamy aplikacje
#https://apps.twitter.com/

#dane aplikacji

consumer_key <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
consumer_secret <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
access_token <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
access_secret <- "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

library(twitteR)

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

t <- searchTwitteR("#poniedzialek",n=5000)

# konwersja do data frame

t1 <- twListToDF(t)

# usuwanie rt

library(dplyr)

t1 %>% filter(isRetweet == "FALSE") -> t2

# prosty sposob na sprawdzenie aktywnosci poszczegolnych userow

u <- as.data.frame(table(t1$screenName), stringsAsFactors = FALSE)

# inny sposób na to samo

library(dplyr)

# zbieranie danych o uzytkownikach
# lista uzytkownikow wypowiadajacyhc sie w temacie #

u1 <- t1$screenName
u2 <- unique(u1)

# sprawdzamy ich dane

users <- lookupUsers(u2)

# konwersja listy do df

users2 <- twListToDF(users)


t1 %>% group_by(screenName) %>% summarize(razem = n()) -> u1
