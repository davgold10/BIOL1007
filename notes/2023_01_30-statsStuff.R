### Lecture 9: Simple data analysis and more complex control structures
### 30 January 2023
### DG

dryadData <- read.table(file="Data/veysey-babbitt_data_amphibians.csv", header = TRUE, sep = ",")

## Set up libraries
library(tidyverse)
library(ggthemes)
library(ggplot2)

### Analyses
### Experimental designs
### independent/explanatory (x-axis) variable vs dependent/response variable (y-axis)
### Continuous (range of numbers: height, weight, temp, etc) vs discrete/categorical (categories:species, treatments, site)

#### Types of stats tests and when to perform them

###                  y-axis (response)
###                       cont              cat
### x-      cont    linear regression       logistic regression
### axis    cat     t-test (2 group)        chi-squared (count)
###                 or ANOVA (2+)
### (explanatory)

glimpse(dryadData)

### Basic linear regression analysis (2 continuous variables)
## is there a relationship between the mean pool hydroperiod and the numebr of breeding frogs caught?
## y ~ x
regModel <- lm(count.total.adults ~ mean.hydro, data = dryadData)
#print(regModel)
summary(regModel)
hist(regModel$residuals)
summary(regModel)$"r.squared"
summary(regModel)[["r.squared"]]

regPlot <- ggplot(data = dryadData, aes(x=mean.hydro, y=count.total.adults+1)) + 
  geom_point() +
  stat_smooth(method="lm", se = 0.99)
regPlot + theme_few()

### Basic ANOVA
### Was there a statistically significant difference in the number of adults among wetlands?
# y~x
ANOmodel <- aov(count.total.adults ~ factor(wetland), data = dryadData) #factor makes categorical data categorical instead of number
summary(ANOmodel)

dryadData %>%
  group_by(wetland) %>%
  summarize(avgHydro = mean(count.total.adults, na.rm=T), N=n())

### Boxplot
dryadData$wetland <- factor(dryadData$wetland)
class(dryadData$wetland)

ANOplot <- ggplot(data=dryadData, mapping=aes(x=wetland, y=count.total.adults)) + geom_boxplot()
ANOplot

ANOplot2 <- ggplot(data=dryadData, mapping=aes(x=wetland, y=count.total.adults, fill=species))+
  geom_boxplot() +
  scale_fill_grey()
ANOplot2
ggsave(file = "SpeciesBoxPlots.pdf", plot=ANOplot2, device="pdf")

### Logistic regression
## Data frame
# gamma probabilities - continuous variables that are always positive and have a skewed distribution
xVar <- sort(rgamma(n = 200, shape = 5, scale = 5))
yVar <- sample(rep(c(1, 0), each = 100), prob = seq_len(200))
logRegData <- data.frame(xVar, yVar)

### Logistical regression analysis
logRegModel <- glm(yVar ~ xVar, 
                   data = logRegData,
                   family = binomial(link = logit))
summary(logRegModel)

logRegPlot <- ggplot(data = logRegData,
                     aes(x=xVar, y=yVar))+
    geom_point() +
    stat_smooth(method = "glm", method.args = list(family=binomial))

logRegPlot

### Contingency table (chi-squared) Analysis

countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males = sum(No.males, na.rm=T), Females = sum(No.females, na.rm=T)) %>%
  select(-species) %>%
  as.matrix() #takes output and converts to matrix
countData

row.names(countData) = c("SS", "WF")
countData

## chi-squared
chisq.test(countData)$residuals

#### mosaic plot (base R)
mosaicplot(x=countData, col=c("goldenrod", "grey"), shade=F)

### bar plot
countDataLong <- countData %>%
  as_tibble() %>%
  mutate(Species = c(rownames(countData))) %>%
  pivot_longer(cols = Males:Females, 
               names_to = "Sex", 
               values_to = "Count")

ggplot(data = countDataLong, 
       mapping = aes(x=Species, y=Count, fill = Sex)) +
  geom_bar(stat="identity", position="dodge") + #plots bars next to each other
  scale_fill_manual(values=c("darkslategrey", "darkblue"))

###########################################################
#### Control Structures

# if statements
## if(condition) {expression 1}
## if this then do this

## if (condition) {expression 1} else {expression 2}

## if (condition 1) {expression 1} else
## if (condition 2) {expression 2} else {expression 3}
### if any final unspecified else captures the rest of unspecified conditions
# else must appear on the same line as the expression

# use it for single values

z <-signif(runif(1), digits=2)
z > 0.5

### use {} or not
if (z > 0.8) {cat(z, "is a large number", "\n")} else 
  if (z < 0.2) {cat(z, "is a small number", "\n")} else {cat(z, "is a number of typical size", "\n")
    cat("z^2 =", z^2, "\n")
    y <- TRUE}

## ifelse to fill vectors
### ifelse(condition, yes, no)

### insect population where females lay 10.2 eggs on average, follows Poisson distribution (discrete probability distribution showign the likely number of times an event will occur). 35% parasitism where no eggs are laid. lets make a distribution for 1000 individuals
tester <- runif(1000)
eggs <- ifelse(tester > 0.35, rpois(n=1000, lambda = 10.2), 0)
hist(eggs)

### vec of p values from a simulation and we want to create a vector to highlight the significant ones for plotting
pVals <- runif(1000)
z <- ifelse(pVals <= 0.025, "lowerTail", "nonSig")
z
z[pVals >= 0.975] <- "upperTail"
table(z)

### for loops
#### workhorse func for doing repetitive tasks
#### universal in all computer languages

### ANATOMy of for loop
## for(variable in sequence) {#starts loop
#body of the for loop}

for(i in 1:5){
  cat("stuck in a loop", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "/n")
}

print(i)

### use a counter variable that maps to the position of each element
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for(i in 1:length(my_dogs)) {
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}

### use double for loops
m <- matrix(round(runif(20), digits=2), nrow=5)

for(i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}
m

## loop over columns
m <- matrix(round(runif(20), digits=2), nrow=5)
for(j in 1:ncol(m)){
  m[,j] <- m[,j] +j
}
m

### loop over rows and columns
m <- matrix(round(runif(20), digits=2), nrow=5)

for(i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}
print(m)
