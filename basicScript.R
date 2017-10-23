# A simple command
4*5

# An incomplete command
4*
5

# Search Path
search()
searchpaths()

# List objects from graphics
objects(4)
ls.str(4)


# Assignment
x <- 3*4
x

# Reading in data
library(readr)
setwd("./USB/Data/")
london <- read_csv("london.csv")
View(london)
london

head(london, n = 3)
nrow(london)
ncol(london)
dim(london)
names(london)


# Reading from excel
library(readxl)
excel_sheets("iris.xlsx")
irisXL <- read_excel("iris.xlsx", sheet = "iris")



# Extracting column vectors
airquality$Wind

# Making vectors
c(4, 3, 6, 5)
c("A", "B", "C")
c(FALSE, TRUE, FALSE)

# Sequences
1:10
seq(from = 0, to = 5, by = 0.5)
rep("Analytics", 3)    

#Subscripting
LETTERS[1:5]
LETTERS[c(1,3,5)]


# DATA MANIPULATION -------------------------------------------------------
library(dplyr)

# Filter
filter(mtcars, cyl == 4)
filter(mtcars, mpg < 15)
filter(mtcars, carb %in% c(3, 6, 8))
filter(mtcars, cyl == 4, carb == 2)
filter(mtcars, cyl == 4 | cyl == 2)

# Select

select(mtcars, mpg, cyl, wt)
select(mtcars, 1:3, 5)
select(mtcars, -5)
select(mtcars, -mpg, wt)
select(mtcars, mpg:wt)

select(mtcars, starts_with("d"))
select(mtcars, one_of("mpg", "drat"))
select(mtcars, contains("A", ignore.case = TRUE))


# Arrange

arrange(mtcars, mpg)
arrange(mtcars, mpg, hp)
arrange(mtcars, desc(mpg))

# Mutate

mutate(mtcars, pwr2wt = hp/wt)
mutate(mtcars, pwr2wt = hp/wt,
               pw2wt.Sq = pwr2wt^2)

# Rename
rename(mtcars, Cylinders = cyl)

# Slice
slice(mtcars, 5)
slice(mtcars, -1)

# Summarise

summarise(mtcars, mean(mpg), n_distinct(cyl))
summarise(mtcars, MPG = mean(mpg), nClys = n_distinct(cyl))

# Grouping
group_by(mtcars, cyl)
group_by(mtcars, cyl, am)


summarise(group_by(mtcars, cyl), MPG = mean(mpg), nCyls = n_distinct(cyl))
summarise(group_by(mtcars, cyl, am), MPG = mean(mpg))

filter(group_by(mtcars, cyl), mpg == max(mpg))
mutate(group_by(mtcars, cyl), mean.mpg = mean(mpg))


# The pipe (FINNNNNNALY)

summarise(group_by(mtcars, cyl, am), MPG = mean(mpg))
mtcars %>% group_by(cyl, am) %>% summarise(MPG = mean(mpg))

mtcars %>%
  select(mpg, wt, cyl, am, gear) %>%
  filter(am == 0) %>%
  group_by(cyl) %>%
  summarise(mean.mpg = mean(mpg))


# Using functions

args(runif)
args(qqnorm)

runif(n = 5, min = 0, max = 1)
runif(n = 5)
runif(min = 10, max = 20, n = 5)
runif(mi = 10, ma = 20, n = 5)
runif(5, -10, 10)
runif(n = 5, min = 10, max = 20)
runif(5, min = 10, max = 20)



# Tidy Data ---------------------------------------------------------------
library(tidyr)
data("messyData")

# Gather data
gatherData <- gather(messyData,
                     key = Treatment.Time,
                     value = Obersvation,
                     -Subject)

gatherData <- gather(messyData,
                     key = Treatment.Time,
                     value = Observation,
                     Placebo.1,
                     Placebo.2,
                     Drug1.1,
                     Drug1.2,
                     Drug2.1,
                     Drug2.2)

gatherData <- gather(messyData,
                     key = Treatment.Time,
                     value = Observation,
                     Placebo.1:Drug2.2)

# Separate data

sepData <- separate(gatherData,
                    col = Treatment.Time,
                    into = c("Treatment", "Time"),
                    sep = "\\.")


# Spread data

spreadData <- spread(sepData, key = Time, value = Observation)


# Exercise

data("airquality")

gatherAirquality <- gather(airquality,
                           key = Measurement,
                           value = Reading,
                           -Day,
                           -Month)

spreadAirQuality <- spread(gatherAirquality,
                           key = Month,
                           value = Reading)
data("pkData")

gatherPkData <- gather(pkData,
                       key = Measurement,
                       value = Reading,
                       -Subject,
                       -Time)
spreadPkData <- spread(gatherPkData,
                       key = Time,
                       value = Reading)
