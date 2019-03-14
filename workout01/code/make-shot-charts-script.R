##################################################
## title: make-shots-charts-script
## description: Read in the data and create a global chart that contains all the data.
##              Generate output pdf file and png file for each seperate charts and 
##              the global charts.
## input(s): shots-data.csv
## output(s): andre-iguodala-shot-chart.pdf, draymond-green-shot-chart.pdf
##            kevin-durant-shot-chart.pdf, klay-thompson-shot-chart.pdf, 
##            stephen-curry-shot-chart.pdf, gsw-shot-charts.pdf,
##            gsw-shot-charts.png
##################################################

install.packages("jpeg")
library(ggplot2)
library(jpeg)
library(grid)

getwd()
setwd("/Users/yubaozhang/Desktop/workout01/code")

court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))


pdf('../images/stephen-curry-shot-chart.pdf',width = 6.5,height = 5 )
ggplot(data = curry) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal()
dev.off()

pdf('../images/andre-iguodala_shot_chart.pdf',width = 6.5,height = 5 )
ggplot(data = iguodala) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') + theme_minimal()
dev.off()

pdf('../images/graymond-green_shot_chart.pdf',width = 6.5,height = 5 )
ggplot(data = green) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Graymond Green (2016 season)') + theme_minimal()
dev.off()

pdf(file = '../images/kevin-durant_shot_chart.pdf')
ggplot(data = durant) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') + theme_minimal()
dev.off()

pdf('../images/klay-thompson_shot_chart.pdf',width = 6.5,height = 5 )
ggplot(data = thompson) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()
dev.off()

pdf('../images/gsw-shot-charts.pdf',width = 8, height = 7)
ggplot(data = shots_data) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart(2016 season)') + theme_minimal() + facet_wrap(~name)
dev.off()

png('../images/gsw-shot-charts.png',width = 8, height = 7, units = "in",res = 1200)
ggplot(data = shots_data) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x = x, y = y, color = shot_made_flag)) + ylim(-50, 420) +
  ggtitle('Shot Chart(2016 season)') + theme_minimal() + facet_wrap(~name)
dev.off()

