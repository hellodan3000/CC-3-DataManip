# TUTORIAL - BASIC DATA MANIPULATION
# Daniel Collier
# 10/10/2022
 

# Subset, extract and modify data with R operators ----

# Load the elongation data
elongation <- read.csv("EmpetrumElongation.csv", header = TRUE)   

# Check import and preview data
head(elongation)   # first few observations
str(elongation)    # types of variables

# Let's get some information out of this object!
elongation$Indiv   # prints out all the ID codes in the dataset
length(unique(elongation$Indiv))   # returns the number of distinct shrubs in the data

# Here's how we get the value in the second row and fifth column
elongation[2,5]

# Here's how we get all the info for row number 6
elongation[6, ]

# And of course you can mix it all together!
elongation[6, ]$Indiv   # returns the value in the column Indiv for the sixth observation
# (much easier calling columns by their names than figuring out where they are!)


# But with [ , ] if you add rows later on it might be referring to the wrong one!

# So use logical operations ----

# Let's access the values for Individual number 603
elongation[elongation$Indiv == 603, ]

# To access data that is of character or factor type, you would use quotation marks: 
# elongation$Indiv == "six-hundred-and-three"


# Operators for logical operations ----

# ==: equals exactly

# <, <=: is smaller than, is smaller than or equal to

# >, >=: is bigger than, is bigger than or equal to

# !=: not equal to

# %in%: belongs to one of the following (usually followed by a vector of possible values)

# &: AND operator, allows you to chain two conditions which must both be met

# |: OR operator, to chains two conditions when at least one should be met

# !: NOT operator, to specify things that should be omitted



# Subsetting with one condition

elongation[elongation$Zone < 4, ]    # returns only the data for zones 2-3
elongation[elongation$Zone <= 4, ]   # returns only the data for zones 2-3-4


# This is completely equivalent to the last statement
elongation[!elongation$Zone >= 5, ]   # the ! means exclude


# Subsetting with two conditions
elongation[elongation$Zone == 2 | elongation$Zone == 7, ]    # returns only data for zones 2 and 7
elongation[elongation$Zone == 2 & elongation$Indiv %in% c(300:400), ]    # returns data for shrubs in zone 2 whose ID numbers are between 300 and 400


# Vector sequence builders ----

# Did you notice that last bit of code: c(300:400) ? We saw in our intro tutorial 

# that we can use c() to concatenate elements in a vector. Using a colon between the two numbers means counting up from 300 to 400.

# Other useful vector sequence builders are:
  
# seq() to create a sequence, incrementing by any specified amount. E.g. try seq(300, 400, 10)

seq(300, 400, 10)

# rep() to create repetitions of elements. E.g. rep(c(1,2), 3) will give 1 2 1 2 1 2.

# You can mix and match! What would 

rep(seq(0, 30, 10), 4)   # give?


# Creating and overwriting objects ----


## CHANGING VARIABLE NAMES AND VALUES IN A DATA FRAME ----

# Let's create a working copy of our object
elong2 <- elongation

# Now suppose you want to change the name of a column: you can use the names() function
# Used on its own, it returns a vector of the names of the columns. Used on the left side of the assign arrow, it overwrites all or some of the names to value(s) of your choice.

names(elong2)                 # returns the names of the columns

names(elong2)[1] <- "zone"    # Changing Zone to zone: we call the 1st element of the names vector using brackets, and assign it a new value
names(elong2)[2] <- "ID"      # Changing Indiv to ID: we call the 2nd element and assign it the desired value

# Now suppose there's a mistake in the data, and the value 5.1 for individual 373 in year 2008 should really be 5.7

## - option 1: you can use row and column number
elong2[1,4] <- 5.7

## - option 2: you can use logical conditions for more control
elong2[elong2$ID == 373, ]$X2008 <- 5.7   # completely equivalent to option 1


# Option 2 code will run even if the observation moves in your dataset

## CREATING A FACTOR ----

# Let's check the classes
str(elong2)

# The zone column shows as integer data (whole numbers), but it's really a grouping factor (the zones could have been called A, B, C, etc.) Let's turn it into a factor:

elong2$zone <- as.factor(elong2$zone)        # converting and overwriting original class
str(elong2)                                  # now zone is a factor with 6 levels

## CHANGING A FACTOR'S LEVELS ----

levels(elong2$zone)  # shows the different factor levels

levels(elong2$zone) <- c("A", "B", "C", "D", "E", "F")   # you can overwrite the original levels with new names

# You must make sure that you have a vector the same length as the number of factors, and pay attention to the order in which they appear!





