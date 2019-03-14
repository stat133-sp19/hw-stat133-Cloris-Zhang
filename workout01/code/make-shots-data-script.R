##################################################
## title: make-shots-data-script
## description: shots data of the five players
## input(s): it requires the five shots data in csv format
## output(s): it outputs the summary of each player's shots data and the summary of binded table
##################################################

getwd()
setwd("/Users/yubaozhang/Desktop/workout01/code")
library(dplyr)

curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
curry$name <- "Stephen Curry" 
curry <- curry %>% mutate(shot_made_flag = replace(shot_made_flag, shot_made_flag == 'n','shot_no'))
curry <- curry %>% mutate(shot_made_flag = replace(shot_made_flag, shot_made_flag == 'y','shot_yes'))
curry <- mutate(curry,minute = period *12 - minutes_remaining )
sink('../output/stephen-curry-summary.txt') 
print(summary(curry))
sink()

iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
iguodala$name <- "Andre Iguodala"
iguodala$shot_made_flag[iguodala$shot_made_flag  == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag  == "y"] <- "shot_yes"
iguodala$minute <- iguodala$period * 12 - iguodala$minutes_remaining
sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
green$name <- "Draymond Green"
green$shot_made_flag[green$shot_made_flag  == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag  == "y"] <- "shot_yes"
green$minute <- green$period * 12 - green$minutes_remaining
sink(file = '../output/graymond-green-summary.txt')
summary(green)
sink()

durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
durant$name <- "Kevin Durant"
durant$shot_made_flag[durant$shot_made_flag  == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag  == "y"] <- "shot_yes"
durant$minute <- durant$period * 12 - durant$minutes_remaining
sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
thompson$name <- "Klay Thompson"
thompson$shot_made_flag[thompson$shot_made_flag  == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag  == "y"] <- "shot_yes"
thompson$minute <- thompson$period * 12 - thompson$minutes_remaining
sink(file = '../output/klay-thompson-summary.txt')
summary(thompson)
sink()

shots_data <- rbind(curry, iguodala, green, durant,thompson)

write.csv(shots_data, "../data/shots-data.csv")

sink('../output/shots-data-summary.txt') 
print(summary(shots_data)) 
sink()

