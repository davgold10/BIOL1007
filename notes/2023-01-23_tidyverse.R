### Entering the Tidyverse (dplyr)

## Tidyverse: collection of packages that share philosophy, grammar (how code is structured), and data structures

## Operators: symbols that tell R to perform diff operations (between variables, functions, etc.)

# Arithmetic operators: + - * /
# Assignment operator: <-
# Logical operator: ! &
# Relational operators: == != > < >= <=
# Miscellaneous operators: %>% %in%

## Only need to install packages once
library(tidyverse) #library function to load in packages

# dplyr: new(er) packages provides a set of tools for manipulating data sets
# specifically written to be fast
# individual functions that correspond to common operations

#### The core verbs
### filter()
### arrange()
### select()
### group_by() and summarize()
### mutate()

## built in data set
data(starwars)
class(starwars)

## Tibble: modern take on data frames
### keeps great aspects of dfs and drops bad ones (change variables)
glimpse(starwars)

#### NAs
anyNA(starwars) #is.na #complete.cases
starwarsClean <- starwars[complete.cases(starwars[, 1:10]),]
anyNA(starwarsClean[, 1:10])

### filter(): picks/subsets observations (ROWS) by their values

filter(starwarsClean, gender == "masculine" & height < 180 ) # , and & mean "and"
filter(starwarsClean, gender == "masculine" & height < 180, height > 100 )
filter(starwarsClean, gender == "masculine"| gender == "feminine") # | is or

### 
#sequence of letters
a <- LETTERS[1:10]
length(a) # lenght of vector

b <- LETTERS[4:10]
length(b)

## output of %in% depends on first vector
a %in% b
b %in% a

# use 
eyes <- filter(starwars, eye_color %in% c("blue", "brown"))
View(eyes)

### arrange(): reorders rows
arrange(starwarsClean, by = height) #default is ascending order
# can use helper function desc()
arrange(starwarsClean, by = desc(height))

arrange(starwarsClean, height, desc(mass)) #second variable used to break ties

sw <- arrange(starwarsClean, by=height)
tail(sw) #missing values are at the end

### select(): chooses variables (COLUMNS) by their names
select(starwarsClean, 1:10)
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships))

### rearrange columns
select(starwarsClean, name, gender, species, everything()) # everything() is a helper function, useful if you have a couple variables you want to move to the beginning

# contains() helper function
select(starwarsClean, contains("color"))
## others include: ends_with() starts_with() num_range()

# select can also rename columns

select(starwarsClean, haircolor = hair_color)


### mutate(): creates new variables using functions of existing variables
# lets create a new column that is height divided by mass
mutate(starwarsClean, ratio = height/mass)

#### MISSED STUFF DURING BATHROOM BUT EV TEXTED YOU

### group_by() and summarize()
summarize(starwarsClean, meanHeight = mean(height)) #gets mean height of all characters

summarize(starwarsClean, meanHeight = mean(height), TotalNumber = n())

# use group_by for maximum usefulness
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)

summarize(starwarsGenders, meanHeight = mean(height, na.rm=TRUE), TotalNumber=n())

# Piping %>%
# used to emphasize a sequence of actions
# allows you to pass an intermediate results onto the next function (uses output of one function as input of the next function)
#avoid if you need to manipulate more than one object/variable at a time; or if variable is meaningful
# formatting: should have a space before the %>% followed by new line

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight=mean(height, na.rm=TRUE), TotalNumber=n()) #much cleaner! with piping

### case_when() is useful for multiple if/ifelse statements
starwarsClean %>%
  mutate(sp = case_when
         )
