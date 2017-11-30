# Lexical scoping

make.power <- function(n) {
    pow <- function(x) {
        x^n
    }
    pow
}

cube <- make.power(3)
cube (2)

square <- make.power(2)
square(5)

# function environment:
ls(environment (cube))
get ("n", environment(cube))