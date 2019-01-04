library("ggplot2")

#Making the code outside a function
die <- 1:6
dice <- sample(die, 2, replace = TRUE)
sum(dice)


#making a basic function
roll <- function(){
    die <- 1:6
    dice <- sample(die, 2, replace = TRUE)
    sum(dice)  
}

roll()


#Adding parameters to the function
roll2 <- function(bones = 1:6) {
    dice <- sample(bones, size = 2, replace = TRUE)
    sum(dice)
}

roll2()
roll2(bones = 1:3)
roll2(bones = 1:6)
roll2(1:20)


#Qplot
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x

y <- x^3
y

qplot(x, y)


x <- c(1, 2, 2, 2, 3, 3)
qplot(x, binwidth = 1)

x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2, binwidth = 1)

x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
qplot(x3, binwidth = 1)


#Replicate to simulate 
replicate(10, roll())

#Seeing the probability of the dice function above over 1000 rolls
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)


#Weighting the probablity, skewing the odds
roll <- function(){
    die <- 1:6
    dice <- sample(die, 2, replace = TRUE, prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
    sum(dice)  
}

roll()

rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

