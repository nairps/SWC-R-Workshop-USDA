# Functions
#
# - are the basic building block of most programming languages
# - are used to gather a sequence of operations into a whole, preserving it for ongoing use.
# - have names that we can remember and call
# - have a defined set of inputs and expected outputs
# - provide connections to the larger programming environment
#
#
# We can repeat several operations with a single function call.
#
# There are 2 types of functions:
#
#  1. built-in functions
#  2. user-defined functions
#
#
# Below are some of the built-in functions from **base R**.
########################################################################
log()
mean()
min()
sd()
########################################################################
# User-defined functions are created in **R** using the keyword "function".
# See below regarding how to get help for writing functions in **R**.
########################################################################
?"function"


########################################################################
# Components of a function
#
# Below given are the components of a function:
# a. name
# b. arguments/inputs - within parentheses -()
# c. body - within curly braces - {}
#     - statements that are executed when it runs
#
# The statements in the body are indented by two spaces as a good practice
# for writing `R` code.
#
# The function is called/used in `R` by providing a function name with the
# arguments in parenthesis, like shown below.
#
# defining a function
# function_name <- function(arguments){
#     body
# }
#
# this is how we call or use a function
# function_name(arguments)
#
# Let’s define a function `fahr_to_kelvin()` that converts
# temperatures from Fahrenheit to Kelvin:
#
########################################################################
fahr_to_kelvin <- function(temperature) {
    kelvin <- ((temperature - 32) * (5 / 9)) + 273.15
    return(kelvin)
}

# Using our newly defined function to convert the freezing point of water
# from Fahrenheit to kelvin.
#
# Freezing point of water is 0 °C or 32 °F.
fahr_to_kelvin(32)

# convert the boiling point of water from Fahrenheit to Kelvin
# boiling point of water is 100 °C (212 °F).
fahr_to_kelvin(212)

################################################################################
## Challenge 1
#
# Write a function called kelvin_to_celsius() that takes a temperature in
# Kelvin & converts that to temperature in Celsius.
#
# To convert from Kelvin to Celsius you subtract 273.15
#
# Reference: http://swcarpentry.github.io/r-novice-gapminder/10-functions/index.html
#
# kelvin_to_celsius <- function(temp) {
#     .....
#     return(celsius)
# }
################################################################################
# Solution
kelvin_to_celsius <- function(temp) {
    celsius <- temp - 273.15
    return(celsius)
}
########################################################################
## Combining functions

# We will define a third function to convert directly from
# Fahrenheit to Celsius, by reusing the two functions above.
#
# Let the name of third function be `fahr_to_celsius()`
#       - input: temperature in Fahrenheit
#       - expected output: temperature in Celsius
#
#  We are going to accomplish this in 3 steps:
#
#   1. Convert Fahrenheit to Kelvin : `fahr_to_kelvin()`
#   2. Convert Kelvin from Step1 to Celsius: `kelvin_to_celsius()`
#   3. Return the above result at the end of the function
########################################################################
fahr_to_celsius <- function(temp) {
    temp_k <- fahr_to_kelvin(temp)
    result <- kelvin_to_celsius(temp_k)
    return(result)
}

# or can nest functions like this
fahr_to_celsius_2 <- function(temp) {
    temp_c <- kelvin_to_celsius(fahr_to_kelvin(temp))
    return(temp_c)
}


# convert the boiling and freezing point of from Fahrenheit to Celsius.
# Call your combined function for the above mentioned conversions
fahr_to_celsius(212) # boiling point of water from F to C
fahr_to_celsius(32) # freezing point of water from F to C

################################################################################
#
## Defensive Programming
#
################################################################################
# - Checking function parameters
# - Writing functions provides an efficient way to make R code
# re-usable and modular
#
# -  it is important to ensure that functions only work in their
# intended use-cases.
#
# - frequently check function parameters using conditions
# and throw an error if something is wrong.
#
# - These checks are referred to as assertion statements because
# we want to assert some condition is TRUE before proceeding.
#
# -  make it easier to debug because they give us a better idea of
# where the errors originate.
#
# - How to use assertion in R ?
#     - we can tell R to stop executing the function using stop()
#


################################################################################
### Case 1: Functions with one argument
# We can create conditions with `stopifnot()`.
# Let’s start by re-examining `fahr_to_kelvin()`.
#
# - Here, we know that the argument `temp` must be a `numeric`
# - Otherwise, the mathematical operations used in the temperature conversions will not work.
# - Hence, we check this with an `if` statement and `stop()`
# if the condition is violated
################################################################################

is.numeric("TRUE")
is.numeric(TRUE)
is.numeric(2)

# defensive-fahr_to_kelvin
fahr_to_kelvin <- function(temp) {
    if (!is.numeric(temp)) {
        stop("temp must be a numeric vector.")
    }
    kelvin <- ((temp - 32) * (5 / 9)) + 273.15
    return(kelvin)
}

################################################################################
### Case 2: Multiple arguments or conditions
# - Use `stopifnot()` for type-assertion
# - works in the same way as `stop()`
# - shorter syntax
# - throws an error if it finds a condition that is `FALSE`.
#
# Here is the code for defensive programming with `stopifnot()`
################################################################################
fahr_to_kelvin_stopifnot <- function(temp) {
    stopifnot(is.numeric(temp))
    kelvin <- ((temp - 32) * (5 / 9)) + 273.15
    return(kelvin)
}

################################################################################
# **Note**
#     - We can list as many conditions that should evaluate to `TRUE`
#     - Secondary purpose: extra documentation for the function.
#
# Lets now try checking the impact of the newly added assertions
# on our function `fahr_to_kelvin()`.

# Freezing point of water
fahr_to_kelvin(temp = 32)
fahr_to_kelvin_stopifnot(temp = 32)

# Let's convert the number `32` to the type `factor` using the function `as.factor()`.
as.factor(32)


# Now, the metric is a factor instead of numeric
fahr_to_kelvin(temp = as.factor(32))
fahr_to_kelvin_stopifnot(temp = as.factor(32))

# Both functions still works when given proper input.
# But fails instantly if given improper input.


# Now, we’re going to define a function `calcGDP()` that calculates the
# Gross Domestic Product of a nation from the `gapminder` dataset that we
# used in the chapter `Vectorisation`.
#
# `calcGDP` takes a dataset and multiplies the population column
# `pop` with the GDP per capita column `gdpPercap` to get the GDP.

head(gapminder)
calcGDP <- function(dat) {
gdp <- dat$pop * dat$gdpPercap
return(gdp)
}
calcGDP(head(gapminder)) # Using the function with a portion of the gapminder data.


#############################################################################
# As we want our results to be more informative than the above,
# let's add some more arguments so we can extract per year and country GDP.
# We can also apply defensive programming & default values for the arguments
#############################################################################

calcGDP <- function(dat, year=NULL, country=NULL) {
    if(!is.null(year)) {
        dat <- dat[dat$year %in% year, ]
    }
    if (!is.null(country)) {
        dat <- dat[dat$country %in% country,]
    }
    gdp <- dat$pop * dat$gdpPercap

    new <- cbind(dat, gdp=gdp)
    # modified gapminder with a gdp column
    return(new)
}
#############################################################################
# Explanation of what the function `calcGDP` does now:
#
# i) subsets the provided data by year if the year argument isn’t empty
# ii) subsets the result by country if the country argument isn’t empty.
# iii) calculates the GDP for the resultant subset
# iv) adds the GDP as a new column to the subsetted data
# v) returns the subsetted data (if year or/and country was present in the
#   input dataframe) with a gdp column added as the final result.
#
#
# **Note**: Implementing defensive programming can make our functions more
# flexible for later use.
#
#
# By using %in% instead, we can also give multiple years or countries to those
# arguments.
# Please see help for `%in%` which we covered yesterday using the below functions:
#############################################################################

help("%in%")
head(calcGDP(gapminder, year = 2007)) # specify the year
calcGDP(gapminder, country="Australia") # for a specific country:






########################################################################
#
## Challenge 4
#
########################################################################
# Test out your GDP function by calculating the GDP for New Zealand in 1987.
# How does this differ from New Zealand’s GDP in 1952?
calcGDP(gapminder, year = ..., country = ..)



# Solution
calcGDP(gapminder, year = 1952, country = "New Zealand")




########################################################################
## Challenge 5
########################################################################

# Write a function called fence() that takes two vectors as arguments,
# called text and wrapper, and prints out the text wrapped with the wrapper:

# The paste() function, we learned yesterday, can be used to combine text
# together. See below.


best_practice <- c("Write", "programs", "for", "people", "not", "computers")
paste(best_practice, collapse=" ")

# Let the argument `text` be `best_practice` and `wrapper` be `****`.
# The frame for the function is given below. Please try completing this.

# fence <- function(text, wrapper){
#     ...
#     ....
#     return(result)
# }
# calling the function
#
# fence(text=.., wrapper=..)





################################################
# Solution
################################################
fence <- function(text, wrapper){
    text <- c(wrapper, text, wrapper)
    result <- paste(text, collapse = " ")
    return(result)
}
best_practice <- c("Write", "programs", "for", "people", "not", "computers")
fence(text=best_practice, wrapper="***")


########################################################################
## How to use functions for later analyses
#########################################################################
# 1. Save functions to a file: e.g.: "functions.R"
# 2. Use it in another R script by using the `source()` function
# - `source("~/functions/functions.R")`





