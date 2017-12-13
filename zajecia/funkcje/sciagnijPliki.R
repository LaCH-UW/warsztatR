
sciagnijPliki <- function(x,y,z) {
  # x - zrodlo urli
  # y - katalog
  # z - rozszerzenie
  a <- 1
  for(i in x) {
    cat(paste("Przetwarzam plik",a,".",z,"\n"))
    download.file(i,paste0(y,"/",a,".",z))
    a <- a + 1
  }  
}
