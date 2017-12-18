# week 4 - Regular Expressions

# start of a line: ^
# end of the line: $
# any given: [Bb]
# any character: .
# either: |
# optional expression: ?
# repeat any number of time, including none: *
# at least one of the items: +
# minumim and maximum: {}
# at least m but not more than n: {m,n}
# exactly m matches: {m}
# at least m matches: {m,}
# remember matched expression: () \1 \2


# Examples:
# Begining of the line, literal "I am", capital or lower case i
# ^[Ii] am

# Ranges:
# Matching a to z lower case
# [a-z]

# Matching all a to z
# [a-zA-Z]

# Begining of the line, look for a number followed by a letter
# ^[0-9][a-zA-Z]

# Excluding charaters - look at the end of the line and match the one that does NOT end with ? or .
# [^?.]$

# Any place that has 9 followed by any posible character followed by 11
# 9.11

# lines that have either flood or fire
# flood|fire
# lines that have flood, hurricane, earthquake, fire
# flood|hurricane|earthquake|fire

# begining of the line, either a capital or lower case "good" or anywhere in the line a "bad"
# ^[Gg]ood|[Bb]ad

# begining of the line: either a capital or lower case "good" or capital or lower case "bad"
# ^([Gg]ood|[Bb]ad)

# Optional W or w
# [Gg]eorge( [Ww]\.)? [Bb]ush

# someting between parenthesis. Any character, repeated any number of times
# (.*)

# at least one number followed by any number of characters followed by at least one number again
# [0-9]+ (.*) [0-9]+

# bush or Bush and at the end "debate"
# in between at least one space, followed by something that is NOT a space
# followed by at least one space
# between 1 and 5 times (as in up to 5 times between Bbush and debate)
# [Bb]ush( +[^ ]+ +){1,5}debate

# space followed by at least one character, followed by at least one space
# followed by exact the same match in the parenthesis
#  +([a-zA-Z]+) +\1 +

# the * is gredy - it will match the longest string that satisfies the regex
# begining of the string, looking for an "s", followed by some possible large number of characters
# followed by another "s"
# ^s(.*)s

# to make it less greedy
# use "?" to turn off the greedy behavior
# start with "s", followed by a smaller number of characters, followed by a "s" at the end of the string
# ^s(.*?)s
