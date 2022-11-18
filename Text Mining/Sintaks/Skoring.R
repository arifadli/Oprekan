#Pelabelan
library(plyr)
library(tm)
setwd("D:/TUGAS AKHIR/Fix ya Allah")
kalimat2<-read.csv(file.choose(),sep = ";",header=TRUE)
#skoring
positif<- scan("D:/Taks/Kuliah/Pak Muhajir/s-pos.txt",what="character",comment.char=";")
negatif<- scan("D:/Taks/Kuliah/Pak Muhajir/s-neg.txt",what="character",comment.char=";")
kata.positif = c(positif, "senang")
kata.negatif = c(negatif, "kecewa")
score.sentiment = function(kalimat2, kata.positif, kata.negatif,
                           .progress='none')
{
  require(plyr)
  require(stringr)
  scores = laply(kalimat2, function(kalimat, kata.positif,
                                    kata.negatif)
  {
    kalimat = gsub('[[:punct:]]', '', kalimat)
    kalimat = gsub('[[:cntrl:]]', '', kalimat)
    kalimat = gsub('\\d+', '', kalimat)
    kalimat = tolower(kalimat)
    list.kata = str_split(kalimat, '\\s+')
    kata2 = unlist(list.kata)
    positif.matches = match(kata2, kata.positif)
    negatif.matches = match(kata2, kata.negatif)
    positif.matches = !is.na(positif.matches)
    negatif.matches = !is.na(negatif.matches)
    score = sum(positif.matches) - (sum(negatif.matches))
    return(score)
  }, kata.positif, kata.negatif, .progress=.progress )
  scores.df = data.frame(score=scores, text=kalimat2)
  return(scores.df)
}
hasil = score.sentiment(kalimat2$text, kata.positif, kata.negatif)
View(hasil)


write.csv(hasil,file = "D:/Taks/Kuliah/Pak Muhajir/Data Prepro Ver1 Labelling.csv", row.names = FALSE)
