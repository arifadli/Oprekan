library(textclean)
library(tokenizers)
library(wordcloud)
library(dplyr)

#setwd("D:/Taks/Kuliah/TA/Data")
#tweets = read.csv("D:/Taks/Kuliah/TA/Data/data_test.csv", sep=';')
tweets = read.csv("D:/Taks/Kuliah/Pak Muhajir/Data Hasil Sortir.csv", sep=';')
#tweets=read.csv(file.choose(), header=TRUE)
tweets <- tweets$text
head(tweets)
View(tweets)

#tweets <- tweets %>% 
#  as.character()
#head(tweets)

tweets <- gsub( "\n"," ",tweets)
tweets[5]


tweets <- tweets %>% 
  replace_html() %>% # replace html with blank 
  replace_url()   # replace URLs with blank
tweets[1]


tweets <- tweets %>% 
  replace_emoji(.) %>% 
  replace_html(.)

tweets <- tweets %>% 
  replace_tag(tweets, pattern = "@([A-Za-z0-9_]+)",replacement="") %>%  # remove mentions
  replace_hash(tweets, pattern = "#([A-Za-z0-9_]+)",replacement="")      # remove hashtags

# print replaced text data on index [4:5]
tweets[4:5]

head(tweets)


tweets<- gsub("RT :", "", tweets)
tweets[3]



# spell.lex <-read.csv(file.choose(), header=TRUE)

#spell.lex="https://raw.githubusercontent.com/nasalsabila/kamus-alay/master/colloquial-indonesian-lexicon.csv"

#spell.lex<-read.csv("D:/Taks/Kuliah/TA/colloquial-indonesian-lexicon.csv", sep=',')
#head(spell.lex)

# replace internet slang
#tweets <- replace_internet_slang(tweets, slang = paste0("\\b",
                                                        spell.lex$slang, "\\b"),
                                 replacement = spell.lex$formal, ignore.case = TRUE)
#View(tweets)
#head(tweets)


#Often it is useful to remove all non relevant symbols and case from a text 
tweets <- strip(tweets)
tweets[3]

#delete uniq
tweets <- tweets %>% 
  as.data.frame() %>% 
  distinct()
View(tweets)
nrow(tweets)






write.csv(tweets,file = "D:/Taks/Kuliah/Pak Muhajir/Data Siap Prepro.csv", row.names = FALSE)

library(rJava)
library(xlsxjars)
writexl::write_xlsx(tweets, path = tempfile(file = "D:/Taks/Kuliah/Pak Muhajir/Data Siap Prepro.xlsx"), col_names = TRUE, format_headers = TRUE, use_zip64 = FALSE)
