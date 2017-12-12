# week 2

## webscraping
library(XML)
library(httr)

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode # not easy to read

# parsing with xml
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlParse(rawToChar(GET(url)$content))
# or
html <- htmlTreeParse(rawToChar(GET(url)$content), useInternalNodes = TRUE)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html,"//td[@class='gsc_a_c']",xmlValue) # extract number of citations
xpathSApply(html, "//td [@class='gsc_a_t']", xmlValue) # extract page title and number of citations
xpathSApply(html, "//td [@class='gsc_a_y']", xmlValue) # extract year of citations


# GET from the httr package
html2 = GET(url)
content2 = content(html2,as="text") # extract the content
parsedHtml=htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1 # it will be empty

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2
names(pg2)

# using handles
google=handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2=GET(handle=google,path="search")
pg1
