#### Finishing up Matrices and Data frames
#### 19 January 2023
#### LVA

m <- matrix(data = 1:12, nrow=3)

## subsetting based on elements
m[1:2, ] #gets us just first two rows
m[, 2:4] 

## subset with logical (conditional) statements
## select all columns for which totals are > 15

colSums(m) > 15
m[, colSums(m) > 15]

## row sums now
## select rows that sum up to 22

m[rowSums(m) == 22,] #has to be double equals sign
  ## says only one row (the first) that adds up to 22

m[rowSums(m) != 22,] #does not equals is written as "!="

### logical operators: '=='   '!='   '>'   '<'

## subsetting to a vector changes the data type
z <- m[1,]
print(z)
str(z)

z2 <- m[1, , drop = FALSE] # drop part keeps it as a matrix

# simulate new matrix
m2 <- matrix(data = runif(9), nrow=3)
m2

## use assignment operator to substitute values
m2[m2] > 0.6 <- NA
m2

data <- iris
head(data)

data[3,2] # numbered indices still work

dataSub <- data[,c("Species", "Petal.Length")]
str(dataSub)

#### sort a data frame by values

orderedIris <- iris[order(iris$Petal.Length), ]
head(orderedIris)
