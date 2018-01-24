# Swirl
# Statistical Inference
# Probability

# A deck of cards is a set of 52 cards, 4 suits of 13 cards each. There are two 
# red suits, diamonds and hearts, and two black suits, spades and clubs. Each of 
# the 13 cards in a suit has a value - an ace which is sometimes thought of as 1, 
# a number from 2 to 10, and 3 face cards, king, queen, and jack. 

values <- c("A", as.character(2:10), "J", "Q", "K")
suits <- c("spades", "hearts", "diamonds", "clubs")

# Create a deck as a 13x4 matrix which is easy to verify by eye.
deck <- sapply(suits, function(suit)paste(values, suit, sep=":"))
# Verify.
deck

outcomes <- 13 * 4

# What is the probability of drawing a jack?
P_J <- 4 / outcomes

# If you're dealt a hand of 5 cards, what is the probability of getting all 5 
# of the same value?
# 0, there are only 4 different suits in a deck

# What is the probability of drawing a face card?
# * Face cards are the cards which show a face rather than the number
# 3 for each suit, 4 suits
P_face = (3 * 4) / outcomes

# Suppose you draw a face card and don't replace it in the deck. What is the 
# probability that when you draw a second card it also will be a face card?
11 /51

# Suppose you draw a face card and don't replace it in the deck. What is the 
# probability that when you draw a second card it also will be a face card of the same suit?
P_faceSame = 2 / (outcomes - 1)

# A probability mass function (PMF) gives the probability that a discrete random 
# variable is exactly equal to some value.

# suppose we have a coin which may or may not be fair. Let x=0 represent a 
# 'heads' outcome and x=1 represent a 'tails' outcome of a coin toss. 
# If p is the probability of 'heads' which of the following represents the PMF 
# of the coin toss?  The variable x is either 0 (heads) or 1 (tails).
# Bernoulli distribution:
# x=1 : tails; x = 0 : heads
# (1/2)^x((1/2)^(1-x))

# Consider this figure - a rectangle with height 1 and width 2 with a diagonal 
# line drawn from the lower left corner (0,0) to the upper right (2,1). 
# The area of the entire rectangle is 2 and elementary geometry tells us that 
# the diagonal divides the rectangle into 2 equal areas.
x <- c(0,2,2,0,0)
y <- c(0,0,1,1,0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")
segments(0,0,2,1,lwd=3)
# Could the diagonal line represent a probability density function for a random 
# variable with a range of values between 0 and 2?
# Yes

# Now consider the shaded portion of the triangle - a smaller triangle with a 
# base of length 1.6 and height determined by the diagonal. We'll answer the 
# question, "What proportion of the big triangle is shaded?"
plot(x, y, lwd = 3, frame = FALSE, type = "l")
segments(0,0,2,1,lwd=3)
polygon(c(0,1.6,1.6,0),c(0,0,.8,0),lwd=3,col="lightblue")
mypdf <- function(x){x/2}
# This proportion represents the probability that throwing a piece of cat kibble 
# at the bigger triangle (below the diagonal) hits the blue portion.
# We have to compute the area of the blue triangle. (Since the area of the big 
# triangle is 1, the area of the blue triangle is the proportion of the big 
# triangle that is shaded.) 
area <- (1.6 * 0.8) / 2
# So, what is the probability that the kibble we throw at the bigger triangle 
# will hit the blue portion?
# 0.64
# This artificial example was meant to illustrate a simple probability density 
# function (PDF)

# The cumulative distribution function (CDF) of a random variable X, either 
# discrete or continuous, is the function F(x) equal to the probability that X 
# is less than or equal to x. In the example above, the area of the blue triangle 
# represents the probability that the random variable was less than or equal to 
# the value 1.6.

# In the triangle example from above, which of the following expressions 
# represents F(x), the CDF?
# base = x; height = x/2
# (x*x/2)/2 = x^2/4

# When the random variable is continuous, as in the example, the PDF is the 
# derivative of the CDF. So integrating the PDF (the line represented by the 
# diagonal) yields the CDF. When you evaluate the CDF at the limits of 
# integration the result is an area.
# To see this in the example, we've defined the function mypdf for you. This is 
# the equation of the line represented by the diagonal of the rectangle. 
# As the PDF, it is the derivative of F(x), the CDF. Look at mypdf now.
mypdf <- function(x){x/2}
# Now use the R function integrate to integrate mypdf with the parameters lower 
# equal to 0 and upper equal to 1.6. See if you get the same area (probability) 
# you got before.
integrate(mypdf, 0, 1.6)

# The survivor function S(x) of a random variable X is defined as the function 
# of x equal to the probability that the random variable X is greater than the 
# value x. This is the complement of the CDF F(x), in our example, the portion 
# of the lower triangle that is not shaded.

# In our example, which of the following expressions represents the survival 
# function?
# 1 - x^2/4

# What percentile is the median?
# 50th

# What is the 50th percentile of the CDF F(x)=(x^2)/4 from the example above?
# 0.5 = x^2 / 4
# 2 = x^2
x <- sqrt(2)

# What does this mean with respect to the kibble we're tossing at the triangle?
# Half of it falls to the left of 1.41


