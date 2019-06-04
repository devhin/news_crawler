
# Charger
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("png")

# Lire le fichier texte
# filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
# text <- readLines(filePath)
word_cloud <- function(topic, headings){
text = headings
# Charger les données comme un corpus
docs <- Corpus(VectorSource(text))

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
# Convertir le texte en minuscule
docs <- tm_map(docs, content_transformer(tolower))
# Supprimer les nombres
# docs <- tm_map(docs, removeNumbers)
# Supprimer les mots vides anglais
docs <- tm_map(docs, removeWords, stopwords("french"))
# Supprimer votre propre liste de mots non désirés
docs <- tm_map(docs, removeWords, c("avant", "après", "ses", "pas", "comment", "quoi"))
# Supprimer les ponctuations
docs <- tm_map(docs, removePunctuation)
# Supprimer les espaces vides supplémentaires
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1234)
colors_iac <- c(rgb(255, 168, 92, max=255), 
                rgb(201, 201, 201, max=255), 
                rgb(111, 111, 111, max=255),
                rgb(92, 179, 255, max=255),
                rgb(174, 217, 255, max=255),
                rgb(11, 141, 255, max=255), 
                rgb(0, 55, 103, max=255))
# image <- wordcloud(words = d$word, freq = d$freq, min.freq = 1,
#           max.words=7, random.order=FALSE, rot.per=0, 
#           colors=colors_iac)
png(file=paste0("images/", topic, ".png"), width = 250, height = 250)
par(bg=NA)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=7, random.order=FALSE, rot.per=0, 
          colors=colors_iac)
dev.off()
}