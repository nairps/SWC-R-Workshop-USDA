################################################
#
# Vectorization
#
################################################
# Most of R's functions are vectorized.
#
# - These functions will operate on all elements of a vector at once
#  - No need to loop through and act on each element one at a time
# 
# Advantages of vectorisation
#
# Code will be
#  - concise 
#  - easy to read and
#  - less error prone.
################################################

#vectorisation-multiplication
x <- 1:4
x
x * 2  # each element of the vector was multiplied by 2 


# vectorisation-add-two-vectors
y <- 6:9
y
x + y # each element of x was added to its corresponding element of y

################################################
#
# Vectorisation in addition by using `for` loop.
#
################################################

## Structure of a `for()` loop
#for (iterator in set_of_values) {
#         do a thing
# } 
# - indentation not important in R compared to Shell and Python
# 
# - its a good practice to use indentation
#
#**Uses of for() loop:  repeating operations
# 
# 
#**Example of a for loop** 
for (i in 1:10) {
     print(i)
}


# `for()` loop is good for iterating over a set of values, 
# when the order of iteration is important. 
# Here's an example of a for loop that does vector addition of two vectors.
#
x
y
#vectorisation using for loop
output_vector <- c()
for (i in 1:4) {
    output_vector[i] <- x[i] + y[i]
}
output_vector



#Compare this to the output using vectorised operations.
x
y
sum_xy <- x + y
sum_xy

#Let's try Vectorisation in gapminder data.
#Let's load the gapminder data that we used yesterday in the first part of our R lesson. 



# loading data using a link
gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv", 
    stringsAsFactors=FALSE)

# if the gapminder is already in your data folder
# you can load it using the below code:
gapminder <- read.csv("data/gapminder_data.csv", 
    stringsAsFactors=FALSE)



#Examine the gapminder dataset.
head(gapminder)  # shows the first few rows of the dataset
tail(gapminder)  # shows the last few rows of the dataset

#################################################################
# Vectorisation on the `pop` column of the `gapminder` dataset.

# 1. Make a new column in the `gapminder` data frame that
# contains population in units of millions of people.
#
# 2. Check the head or tail of the data frame to make sure
# it worked.
#################################################################

gapminder$pop_millions <- gapminder["pop"] / 1e6
#or
gapminder$pop_millions_2 <- gapminder$pop / 1e6
# or
gapminder["pop_millions_3"] <- gapminder$pop / 1e6
head(gapminder) # Check the first few rows to make sure it worked.


# Vectorisation while using Comparison operators
x <- 0:6
x
x > 2 


#Logical operators
a <- x > 3  # or, for clarity, a <- (x > 3)
a


# Vectorisation - R Functions
x
x <- 1:4
x
log(x)


######################################################
# Vectorisation in matrices 
# Vectorized operations work element-wise on matrices
#  - the operator `*` = > element-wise multiplication
#  - for matrix multiplication, use the `%*%` operator
######################################################
m <- matrix(1:12, nrow=3, ncol=4)
m
m * -1 # element wise operation

m
m ^ -1 # element wise operation


matrix(1, nrow=4, ncol=1)
m %*% matrix(1, nrow=4, ncol=1)  # matrix multiplication

matrix(1:4, nrow=1) #row matrix
matrix(1:4, nrow=1) %*% matrix(1:4, ncol=1) # matrix multiplication

