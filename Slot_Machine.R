#Skeleton Function ----

#if ( # Case 1: all the same <1>) {
#    prize <- # look up the prize <3>
#    } else if ( # Case 2: all bars <2> ) {
#        prize <- # assign $5 <4>
#        } else {
            # count cherries <5>
#            prize <- # calculate a prize <7>
#        }

# count diamonds <6>
# double the prize if necessary <8>

# <1> - Test whether the symbols are three of a kind.
# <2> - Test whether the symbols are all bars.
# <3> - Look up the prize for three of a kind based on the common symbol.
# <4> - Assign a prize of $5.
# <5> - Count the number of cherries.
# <6> - Count the number of diamonds.
# <7> - Calculate a prize based on the number of cherries.
# <8> - Adjust the prize for diamonds.

#Base function ------
score <- function(symbols) {
    
    # calculate a prize
    
    prize
}

#Making the subtasks to go inside the function ------

## 1: A vector named symbols will contain three of the same symbol if the first element of symbols is equal to the second element of symbols and the second element of symbols is equal to the third element of symbols.


symbols <- c("B", "BB", "BBB")
symbols <- c("C", "DD", "0")
symbols <- c("0", "0", "0")

#Testing if the 3 symbols are the same
all(symbols[1:3] == symbols[3:1])

all(symbols[1] == symbols[2] && symbols[2] == symbols[3] && symbols[3] == symbols[1])

all(symbols == symbols[1])


#Added to function

# same <- all(symbols == symbols[1])
# if (same) {
#     prize <- # look up the prize
# } else if ( # Case 2: all bars ) {
#     prize <- # assign $5
#     } else {
#         # count cherries
#         prize <- # calculate a prize
#     }
# 
# # count diamonds
# # double the prize if necessary

#Test for all Bars ------

symbols <- c("B", "BBB", "BB")

all(symbols %in% c("B", "BB", "BBB"))

#Added to function

# same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
# bars <- symbols %in% c("B", "BB", "BBB")
# 
# if (same) {
#     prize <- # look up the prize
# } else if (all(bars)) {
#     prize <- # assign $5
# } else {
#     # count cherries
#     prize <- # calculate a prize
# }
# 
# # count diamonds
# # double the prize if necessary

#Subsetting ----

payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
             "B" = 10, "C" = 10, "0" = 0)

(payouts["DD"])
unname(payouts["DD"])

# This doesn't work so ..
symbols <- c("7", "7", "7")
symbols[1]

#need to subset
payouts[symbols[1]]

#Cherries ----
symbols <- c("C", "C", "7")
any(symbols %in% c("C"))

symbols == "C"

#This helps by counting
sum(symbols == "C")

same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")

#Added to function

if (same) {
    payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[symbols[1]])
} else if (all(bars)) {
    prize <- 5
} else {
    cherries <- sum(symbols == "C")
    prize <- c(0, 2, 5)[cherries + 1]
}

diamonds <- sum(symbols == "DD")
prize * 2 ^ diamonds

# Final code ------------------------

#Getting symbols
get_symbols <- function() {
    wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
    sample(wheel, size = 3, replace = TRUE, 
           prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

# identify case
score <- function(symbols) {
  same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
  bars <- symbols %in% c("B", "BB", "BBB")
  
  # get prize
  if (same) {
      payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
                   "B" = 10, "C" = 10, "0" = 0)
      prize <- unname(payouts[symbols[1]])
  } else if (all(bars)) {
      prize <- 5
  } else {
      cherries <- sum(symbols == "C")
      prize <- c(0, 2, 5)[cherries + 1]
  }
  
  # adjust for diamonds
  diamonds <- sum(symbols == "DD")
  prize * 2 ^ diamonds
}

# use this
play <- function() {
    symbols <- get_symbols()
    print(symbols)
    score(symbols)
}

play()

# developing this
play <- function() {
    symbols <- get_symbols()
    prize <- score(symbols)
    attr(prize, "symbols") <- symbols
    prize
}

play()
