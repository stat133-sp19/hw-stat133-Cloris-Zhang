# Workout 1

### Introduction

![](https://fadeawayworld.net/wp-content/uploads/2019/01/warriors-hp-graphic.jpg)
Do you like sports such as basketball? Are you fascinated about analyzing the data on your favorite field? In this workout, I will show you the analytics on shooting-related statistics of five Golden State Warrriors basketball players: Andre Iguodala, Kevin Durant, Stephen Curry, Klay Thompson, and Draymond Green. More specifically, I will display “shot charts” for them to let you have a better visualization.

------------------------------------------------------------------------

### Background

Do you know the nearest professional basketball team to us? Right, it is the Golden State Warriors, located in Oakland, California. The Warriors compete in the National Basketball Association (NBA), as a member of the league's Western Conference Pacific Division.

According to Wikipedia, the Warriors began the 2015-2016 season by winning their first 24 games, eclipsing the previous best start in NBA history. The team set an NBA record with 54 consecutive regular-season home wins, which spanned from January 31, 2015 to March 29, 2016; the previous record of 44 was held by the 1995–96 Chicago Bulls team led by Michael Jordan.

On April 13, 2016, Golden State set the NBA record for most wins in a single season. The team finished the season with a record of 73–9.On May 10, 2016, Stephen Curry was named the NBA's Most Valuable Player for the second straight season. Curry is the 11th player to win back-to-back MVP honors and became the first player in NBA history to win the MVP award by unanimous vote, winning all 131 first-place votes. Stephen Curry, Draymond Green and Klay Thompson were all named to the 2016 All-Star Game. 

------------------------------------------------------------------------

### Data

The Warriors posted many notable achievements during the 2016–17 regular season. So we are analyzing the data from the best time of GSW in 2016. The data analyzed came from the data folder from the Stat 133 Homework Github repository. The original data came as CSV files. It consisted of detailed breakdowns of 5 players shooting throughout the 2015-16 season - Andre Iguodala, Kevin Durant, Stephen Curry, Klay Thompson, and Draymond Green. There were 13 variables which included: team name, date of the game, the season, the quarter of the game, minutes and seconds remaining, whether the shot was made or not, how the shot was scored, distance from which the shot was made, team opponent, and x and y coordinates in feet of where the shot was made. 

```{r}
shots_data <- read.csv("../data/shots-data.csv", stringsAsFactors = F)
```
------------------------------------------------------------------------

### Analysis

![](https://cdn.nba.net/nba-drupal-prod/styles/landscape_2090w/s3/2017-12/GettyImages-684463444.jpg?itok=CMilmuEa)

John Schuhmann from NBA.com said: 

> One Team, One Stat -- Golden State Warriors' shooting the best in NBA history ... again

So what are the reasons that make GSW historical shooting season?

Let's take a look at the effective shooting percentage of their players by investigating the effective shooting percentages of each player based on shot type, as well as in total. 

Below is a table showing the effective 2 point shooting percentages for the Warriors' best players: Iguodala, Durant, Curry, Thompson, and Green.

**2PT Shooting by Player**

```{r}
two_pt_shot_chart <- shots_chart %>% 
  group_by(name) %>% 
  summarise(
  total = sum(shot_type == "2PT Field Goal"),
  made  = sum(shot_type ==  "2PT Field Goal" & shot_made_flag == "shot_yes" ),
  perc_made = made/total) %
  >%arrange(desc(perc_made))
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Andre Iguodala |    210|   134|   0.6380952|
| Kevin Durant   |    643|   390|   0.6065319|
| Stephen Curry  |    563|   304|   0.5399645|
| Klay Thompson  |    640|   329|   0.5140625|
| Draymond Green |    346|   171|   0.4942197|

Iguodala has the highest percentage of 2 point field goals made at 63.9%, but with the least shoots 210 in total. Durant, Curry, and Thompson are also important behind the Warriors' offense. Kevin Durant is the Warriors' best 2 point field goal shooter: he takes the most shots at 643 but still makes 390 of them. 

**3PT Shooting by Player**
```{r}
three_pt_shot_chart <- shots_chart %>%
  group_by(name) %>%
  summarise(total = sum(shot_type == "3PT Field Goal"),
            made  = sum(shot_type ==  "3PT Field Goal" & shot_made_flag == "shot_yes" ),
            perc_made = made/total
            ) %>%
  arrange(desc(perc_made))
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Klay Thompson  |    580|   246|   0.4241379|
| Stephen Curry  |    687|   280|   0.4075691|
| Kevin Durant   |    272|   105|   0.3860294|
| Andre Iguodala |    161|    58|   0.3602484|
| Draymond Green |    232|    74|   0.3189655|

Although the Warriors are great 2 point shooters, their ability to shoot 3 pointers is what really sets them apart from the competition. Thomposon makes more than 42% of the 3's he takes. Curry isn't far behind: shooting a respectable 41%.

**Effective Shooting by Player**

Durant is a great 2 point shooter while Thompson and Curry are great 3 point shooters. How do they compare overall? 
```{r}
effective_shot_chart <- shots_chart %>%
  group_by(name) %>%
  summarise(total = length(shot_type),
            made  =  sum(shot_made_flag == "shot_yes") ,
            perc_made = made/total
            ) %>%
  arrange(desc(perc_made))
  
```

| name           |  total|  made|  perc\_made|
|:---------------|------:|-----:|-----------:|
| Kevin Durant   |    915|   495|   0.5409836|
| Andre Iguodala |    371|   192|   0.5175202|
| Klay Thompson  |   1220|   575|   0.4713115|
| Stephen Curry  |   1250|   584|   0.4672000|
| Draymond Green |    578|   245|   0.4238754|

Looking at the raw statistics, Durant appears to be the Warriors' best shooter. However, each Warriors player has their own strengths. Undoubtedly, Curry, Durant, and Thompson are 3 of the best shooters in the league but each specialize in a different kind of shot.


The image below displays shot charts for each player in the report. Each shot chart shows the court location of every shot attempted by the player (using a point on the chart) as well as whether or not they made the shot (indicated by the color of the point on the chart).

![](../images/gsw-shot-charts.png)

Iguodala and Green take considerably less shots than the other 3, Curry is much more likely to take long 3 pointers and Draymond Green likes to play inside the paint.

------------------------------------------------------------------------

#### Conclusion

In a nut shell, GSW is a wonderful team. The Warriors ushered in a new era of success led by Stephen Curry. After drafting perennial All-Stars Klay Thompson and Draymond Green, the team returned to championship glory in 2015, before winning another two in 2017 and 2018 with the help of former league MVP Kevin Durant. The players work well together. Curry and Thompson are good at shooting. Green's ability to defend the opposing team is an asset to the Warriors' success. Overall, its the Warriors' ability to shoot better than every other team in the league that ultimately contribute to their success and the establishment of a Warrior led dynasty.

------------------------------------------------------------------------

#### Reference
* “Golden State Warriors.” Wikipedia, Wikimedia Foundation, 10 Mar. 2019, en.wikipedia.org/wiki/Golden_State_Warriors.
* “Are the Warriors Making the Mid-Range Relevant Again?” Shottracker, shottracker.com/articles/are-the-warriors-making-the-mid-range-relevant-again.


