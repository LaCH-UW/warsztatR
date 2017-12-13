
# library(Rfacebook)

getFbComments <- function(id,z,token){
  # id - number of posts
  # z - number of comments per single post
  # token: https://developers.facebook.com/tools/explorer/
  c <- as.data.frame(NULL)
  for(i in id){
    u <- getPost(i,token,n=z)
    # u = a list with 3 dataframes
    c <- rbind(u$comments,c)
  }
  # return: df
  return(c)  
}


# minimal

getFbComments <- function(id,z,token){
  c <- as.data.frame(NULL)
  for(i in id){
    c <- rbind(getPost(i,token,n=z)$comments,c)
  }
  return(c)  
}
