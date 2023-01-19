##### Programming in R.
##### 12 January 2023
##### DG

# Advantages
## interactive use
## graphics and stats
## active community of users and contributors
## works on multiple platforms

# Disadvantages
## lazy evaluation
## some packages are poorly documented
## some functions are hard to learn
### steep learning curve
## unreliable packages
## problems with big data (multiple GB size)

# Basics

## Assignment Operator - used to assign a new value to a variable

x <- 5
print(5)
x

y = 4 #legal but used except in function arguments

## Variables - used to store info
### a container

z <- 3 #single letter variables
plantHeight <- 10 #camel case format
plant_height <- 3.3 #snake case format, preferred method
plant.height <- 4.2 #works, but gets confused with other functions sometimes
. <- 5.5 #reserve for temporary variable

## Functions: blocks of code that perform a task; use a short command over again instead of writing out a block of code multiple times

# You can create ur own function

square <- function(x = NULL){
  
  x <- x^2
  print(x)
  
}

square(x=3)

### there are some built in functions
sum(109, 3, 10) #look at package info using ?sum to going to Help panel

### Atomic Vectors
# one dimensional (a single row)
# data structures in R programming

### Types
# character strings (usually within quotes)
# integers (whole numbers)
# double (real numbers, decimals)
# both integers and doubles are numberic
# logic (TRUE or FALSE)
# factor (categorizes, groups variable)

# c function (comebine)

z <- c(3.2, 5, 5, 6)
print(z)
class(z) # returns class
typeof(z) #returns type of variable
is.numeric(z) #returns T/F

## c() always "flattens" to a vector

z <- c(3, 4, 5, 6))

# character vectors

z <- c("perch", "bass", "trout")
print(z)

z <- c("This is only 'one' character string", "a second", 'a third')
print(z)
typeof(z)
is.character(z) #is. functions tests whether it is certain data type

z <- c(TRUE, FALSE, T, F) # as. functions coerces data type
print(z)
z <- as.character(z)
is.logical(z)

#length
length(z)  #says how many variables
dim(z) #says how many dimensions

## Names
z <- runif(5) #gives 5 random numbers
names(z) # no names

### add names
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita")
print(z)
names(z)

#### NA values
### missing data
z <- c(3.2, 3.5, 4)
typeof(z)
sum(z)

#### so check for NAs
anyNA(z)
is.na(z)
which(is.na(z)) #explores data and determnines where NAs are

## Subsetting vectors - sorting out for certain criteria
# vectors are indexed
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[4] #use square brackets to subset by index
z[c(4, 5)] #need to use c for multiple indices
z[-c(2, 3)] #minus signs to exclude elements 
z[-1]
z[z==7.5] # use double equals for exact match
z[z<7.5] # use logical statements within square brackets to subset by conditions
z[which(z <7.5)]

# creating logical vector
z < 7.5

## subsetting characters (named elements)
names(z) <- c("a", "b", "c")
z[c("a", "b", "c")]

#subset
subset(x=z, subset = z>1.5)

#randomly sample
#sample function
story_vec <- c("A", "Frog", "jumped", "here")
sample(story_vec)

#randomly select 3 elements from vector
sample(story_vec, size =3)

story_vec <- c(story_vec[1], "Green", story_vec[2:4])
story_vec[2] <- "Blue"
story_vec
# vector function
vec <- vector(mode = "numeric", length=5)

### rep and seq function
z <- rep(x=0, times =100)
z <- rep(x= 1:4, each = 3)

z <- seq(from = 2, to = 4)

