
# library(tm)
usunRegex <- content_transformer(function(x, pattern) {return (gsub(pattern, " ", x))})
