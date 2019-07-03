wolne_lektury <- function(u) {
  x <- scan(u, what = as.character(), encoding = "UTF-8")
  y <- grep("^-----$", x)
  z <- y:length(x)
  x <- x[-z]
  x <- tolower(x)
  d <- as.data.frame(unlist(table(x)), stringsAsFactors = FALSE)
  names(d) <- c('slowo','frekwencja')
  return(d)
}
