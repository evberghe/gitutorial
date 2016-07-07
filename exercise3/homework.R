# TODO: Add comment
# 
# Author: evberghe
###############################################################################


trial <- read.csv("clinical_trial.csv", stringsAsFactors=FALSE)
max(nchar(trial$abstract))
sum(nchar(trial$abstract)==0)
trial$title[which.min(nchar(trial$title))]

library("tm")
library("SnowballC")

corpusTitle <- Corpus(VectorSource(trial$title))
corpusAbstract <- Corpus(VectorSource(trial$abstract))

corpusTitle <- tm_map(corpusTitle, tolower)
corpusTitle <- tm_map(corpusTitle, PlainTextDocument)
corpusTitle <- tm_map(corpusTitle, removePunctuation)
corpusTitle <- tm_map(corpusTitle, removeWords, stopwords("english"))
corpusTitle <- tm_map(corpusTitle, stemDocument)
dtmTitle <- DocumentTermMatrix(corpusTitle)
dtmTitle
sparseTitle <- removeSparseTerms(dtmTitle, 0.95)
wordsTitle = as.data.frame(as.matrix(sparseTitle))
rownames(wordsTitle) <- 1:nrow(trial)
wordsTitle


corpusAbstract <- tm_map(corpusAbstract, tolower)
corpusAbstract <- tm_map(corpusAbstract, PlainTextDocument)
corpusAbstract <- tm_map(corpusAbstract, removePunctuation)
corpusAbstract <- tm_map(corpusAbstract, removeWords, stopwords("english"))
corpusAbstract <- tm_map(corpusAbstract, stemDocument)
dtmAbstract <- DocumentTermMatrix(corpusAbstract)
dtmAbstract
sparseAbstract <- removeSparseTerms(dtmAbstract, 0.95)
sparseAbstract
wordsAbstract = as.data.frame(as.matrix(sparseAbstract))
rownames(wordsAbstract) <- 1:nrow(trial)
wordsAbstract


which.max(colSums(wordsAbstract))
colnames(wordsTitle) <- paste0("T", colnames(wordsTitle))
colnames(wordsAbstract) <- paste0("A", colnames(wordsAbstract))

dtm <- cbind(wordsTitle, wordsAbstract)
dtm$trial <- trial$trial

library("caTools")
set.seed(144)
split = sample.split(dtm$trial, SplitRatio = 0.7)
trainTrial = subset(dtm, split==TRUE)
testTrial = subset(dtm, split==FALSE)

table(trainTrial$trial)
730/(730+572) #0.5607


library(rpart)
library(rpart.plot)

mdl_tree <- rpart(trial~., data=trainTrial, method="class")
prp(mdl_tree)
prd_tree_train <- predict(mdl_tree)[, 2]
max(prd_tree_train)
confusion_train <- as.matrix(table(trainTrial$trial, prd_tree_train>0.5))
accuracy_train <- sum(confusion_train*diag(2))/nrow(trainTrial)
accuracy_train
tp <- sum((prd_tree_train>0.5) & trainTrial$trial)
fp <- sum((prd_tree_train>0.5) & !trainTrial$trial)
fn <- sum(trainTrial$trial)-tp
tn <- sum(!trainTrial$trial)-fp
sensitivity <- tp/(tp+fn); sensitivity
specificity <- tn/(tn+fp); specificity
accuracy <- (tp+tn)/nrow(trainTrial); accuracy

prd_tree <- predict(mdl_tree, newdata=testTrial, type="class")
confusion <- as.matrix(table(testTrial$trial, prd_tree))
accuracy <- sum(confusion*diag(2))/nrow(testTrial); accuracy
library(ROCR)
prd_tree_probs <- predict(mdl_tree, newdata=testTrial)[, 2]
pred_roc <- prediction(prd_tree_probs, testTrial$trial)
auc <- performance(pred_roc, measure = "auc")
auc@y.values
plot(performance(pred_roc, "tpr", "fpr"), colorize=TRUE)