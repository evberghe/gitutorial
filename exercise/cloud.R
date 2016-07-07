# Project: analedge
# Repuposed here to serve as trainign material for playing with github
# 
# Author: evberghe
###############################################################################


setwd("/home/evberghe/.architect/workspace/analedge/week_7/homework_cloud")
tweets <- read.csv("tweets.csv", stringsAsFactors=FALSE)

library(tm)
library(SnowballC)

corpus <- Corpus(VectorSource(tweets$Tweet))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, c("apple", stopwords("english")))
frequencies <- DocumentTermMatrix(corpus)
allTweets <- as.data.frame(as.matrix(frequencies))

library("wordcloud")
wordcloud(colnames(allTweets), colSums(allTweets))
colnames(allTweets)[which.max(colSums(allTweets))]


corpus <- Corpus(VectorSource(tweets$Tweet))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, c("apple", stopwords("english")))
frequencies <- DocumentTermMatrix(corpus)
allTweets <- as.data.frame(as.matrix(frequencies))
wordcloud(colnames(allTweets), colSums(allTweets), random.order=FALSE)

display.brewer.all()