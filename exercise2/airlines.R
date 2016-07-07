# TODO: Add comment
# 
# Author: evberghe
###############################################################################

setwd("/home/evberghe/workspace/analedge/week_6/homework_airlines")
airlines <- read.csv("AirlinesCluster.csv")


summary(airlines)

library("caret")
preproc = preProcess(airlines)
airlinesNorm = predict(preproc, airlines)

summary(airlinesNorm)

dst <- dist(airlinesNorm)
cls <- hclust(dst, method="ward.D")
plot(cls)

clsGroups <- cutree(cls, k=5)
table(clsGroups)

tapply(airlines$Balance, clsGroups, mean)
tapply(airlines$QualMiles, clsGroups, mean)
tapply(airlines$BonusMiles, clsGroups, mean)
tapply(airlines$BonusTrans, clsGroups, mean)
tapply(airlines$FlightMiles, clsGroups, mean)
tapply(airlines$FlightTrans, clsGroups, mean)
tapply(airlines$DaysSinceEnrol, clsGroups, mean)

set.seed <- 88
kls <- kmeans(airlinesNorm, centers=5, iter.max=1000)

table(kls$cluster)