# library(Rfacebook)

getFbComments <- function(id,z){
  # id - id postów
  # z - ile komentarzy ma zwrócić funkcja
  p <- as.data.frame(NULL)
  for(i in id){
    u <- getPost(i,token,n=z)
    c <- rbind(u$comments,p)
  }
  return(c)  
}
