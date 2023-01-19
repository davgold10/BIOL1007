#### Vectors (cont)
#### Properties

## Coercion

### All atomic vectors are of the same data type
### If you use c() to assemble diff types, R coerces them
### logical -> integer -> double -> character

a <- c(2, 2.2)
a #coerces to double

b <- c("purple", "green")
typeof(b)

d <- c(a, b)
typeof(d)
print(d)

### comparison operators yield a logical result
a <- runif(10)
print(a)

a > 0.5 #conditional statement

### How many elements in vector are greater than 0.5
sum(a > 0.5)
mean(a > 0.5) # what proportion of vector are greater than 0.5


### Vectorization
## add a constant to a vector

z <- c(10,20,30)
z
z + 1

## what happens when vectors are added together?

y <- c(1,2,3)
y
z + y #results in an element by element operation on the vector

z^2

## Recycling
# What if vector lengths are not equal?

z
x <- c(1,2)
z+x #gives a warning message that theyre diff lenghts
#shorter vector is always recycled
#so you'd need a zero to avoid it

#### Simulating data: runif and rnorm()

runif(5) #saying how many random uniform numbers we want (here, 5)
runif(n=5, min=5, max=10)

set.seed(123) #reproducible, same random numbers

## rnorm: random normal values with mean 0 and sd 1
randomNormalVariables <- rnorm(100)
mean(randomNormalVariables)
hist(randomNormalVariables)


#### Matrix data structure
### 2 dimensional (rows and columns)
### homogenous data type

# matrix is an atomic vector organized into rows and columns
my_vec <- 1:12
#make it matrix via
m <- matrix(data= my_vec, ncol = 4)
print(m)

dim(my_vec)
dim(m)


#### Lists
# atomic vectors BUT eaxch element can hold diff data types (and diff sizes)

myList <- list(1:10, matrix(1:8, nrow=4, byrow=TRUE), letters[1:3], pi)
class(myList)
str(myList)

### subsetting lists
## using [] gives you a single item BUT not the elements
myList[4]
myList[4] - 3 #single brackets always give you only elements in slot which is type list

#to grab object, use [[]]
myList[[4]] - 3
myList[[2]][4,1] #gets myList, compartment 2, 4th row, 1st column
## 2 dim subsetting in form [row, column]

### Name list items when they are created
myList2 <- list(Tester = FALSE, littleM = matrix(1:9, nrow=3))
myList2
myList2$littleM[2,3] #dollar sign accesses named elements

myList2$littleM[2,]

### unlist to string everything back to vector
unRolled <- unlist(myList2)
unRolled

data(iris)
head(iris)
plot(Sepal.Length ~ Petal.Length, data= iris) #y~x
model <- lm(Sepal.Length ~ Petal.Length, data= iris)
results <- summary(model)
# intercept tests if relationship is zero, so comparing petal and sepal length we care about Petal.Length Pr(>|t|) (p value)
# yes, statistically significant
typeof(results)

str(results)
results$coefficients
#with square bracks and unlist func
brack <- results$coefficients['Petal.Length', 'Pr(>|t|)']
# OR
brack2 <- results$coefficients[2, 4]

#unlist
unlistP <- unlist(results)$coefficients8

### Data frames
## (list of) equal lengthed vectors, each of which is a column

varA <- 1:1
varB <- rep(c("Con", "LowN", "HighN"), each=4)
varC <- runif(12)

dFrame <- data.frame(varA, varB, varC, stringsAsFactors = FALSE)
print(dFrame)
str(dFrame)

# add another row
newData <- list(varA=13, varB = "HighN", varC = 0.668)
str(newData)

#use rbind()
dFrame <- rbind(dFrame, newData)

### why not use c()
newData2 <- c(14, "HighN", 0.668)
dFrame <- rbind(dFrame, newData2)
str(dFrame)
#diff data types, wont combine them

### add a column
newVar <- runif(13)

#use cbind() func to add a column
dFrame <- cbind(dFrame, newVar)
dim(dFrame) #used to check that they were the same lenght, first wouldnt run because diff sizes

### Data frames vs matrices
zMat <- matrix(data=1:30, ncol=3, byrow=TRUE)
zDframe <- as.data.frame(zMat)

zMat[3,3]
zDframe[3,3]

zMat[,3]
zDframe[,3]
zDframe$V3

##### Eliminating NAs
# complete.cases() function
zD <- c(NA, rnorm(10), NA, rnorm(3))
complete.cases(zD) #tells us whats NA, gives logical output

# clean out NAs
zD[complete.cases(zD)]
which(!complete.cases(zD))
which(is.na(zD))

# use with matrix
m <- matrix(1:20, nrow=5)
m[1:1] <- NA
m[5:4] <- NA
complete.cases(m) #gives T/F as to whether whole row is 'complete' (no NAs)
m[complete.cases(m),]

## get complete cases for only certain rows
m[complete.cases(m[,c(1:2)])]
