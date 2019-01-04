#Reading in the data ----
deck <- read.csv("deck.csv", stringsAsFactors=FALSE)

head(deck, 10)

#Ways of selecting values -----
deck[1, c(1, 2, 3)]
deck[1, ]
deck[1, c(TRUE, TRUE, FALSE)]
deck[1, c("face", "suit", "value")]


#Deal then shuffle deck -----
deal <- function(deck){
    deck[1, ]
}

deal(deck)

shuffle <- function(deck){
    random <- sample(1:52, size = 52)
    deck[random, ]
}

deck2 <- shuffle(deck)
deal(deck2)


##Game of war deck -----
deck2 <- deck

#Finding the Aces, every 13th card
deck2[c(13, 26, 39, 52), ]

# Setting the values of the aces from 1 to 14
deck2$value[c(13, 26, 39, 52)] <- 14


#But with a shuffled deck, how to find the aces?
deck3 <- shuffle(deck)
#Logical test
deck3$face == "ace"

sum(deck2$face == "ace")

#Value of found aces
deck3$value[deck3$face == "ace"] <- 14


#HEARTS -----
deck4 <- deck
deck4$value <- 0

deck4$value[deck4$suit =="hearts"] <- 1

queenOfSpades <- deck4$face == "queen" & deck$suit == "spades" 

deck4[queenOfSpades,]
deck4$value[queenOfSpades] <- 13


##Extra tests -----

#   Is w positive?
#   Is x greater than 10 and less than 20?
#   Is object y the word February?
#   Is every value in z a day of the week? 

w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")

w > 0
#FALSE FALSE  TRUE

x > 10 && x <20
#FALSE

y == "February"
#True

all(z %in% c("Monday", "Tuesday", "Wed", "Thurs", "Friday"))


#BlackJack -----
deck5 <- deck
#select a subset with kings, queens and jacks
facecard <- deck5$face %in% c("king", "queen", "jack")
deck5[facecard, ]

#Set their value to 10
deck5$value[facecard] <- 10
deck5[facecard, ]

# Each ace has a value of 11 or 1, depending on the final results of the game. Set the Aces to NA as we don't know the value of ace up front
deck5$value[deck5$face == "ace"] <- NA
head(deck5, 13)


#Using environments to remove the top card from the deck
DECK <- deck
#deck <- deck[-1,]

#Deal then shuffle deck -----
deal <- function(){
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
}
deal()

#Shuffle now adds the cards back into the deck using the clean DECK
shuffle <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
}
shuffle()
deal()
deal()

#Final code - Putting it all together ------
setup <- function(deck) {
    DECK <- deck
    
    DEAL <- function() {
        card <- deck[1, ]
        assign("deck", deck[-1, ], envir = parent.env(environment()))
        card
    }
    
    SHUFFLE <- function(){
        random <- sample(1:52, size = 52)
        assign("deck", DECK[random, ], envir = parent.env(environment()))
    }
    
    list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

#Can remove deck from global env now as deck is stored in the parent env
rm(deck)

shuffle()
deal()
