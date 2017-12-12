# week 2

# API
library(httr)

myapp = oauth_app("twitter", key="ConsumerKey",secret="ConsumerSecret")
sig = sign_oauth1.0(myapp, token="tokenHere",
                    token_secret = "tokenSecret")
homeTL= GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)