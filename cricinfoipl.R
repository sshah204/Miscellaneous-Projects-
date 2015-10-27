library(XML)
url="http://stats.espncricinfo.com/ci/engine/stats/index.html?class=11;template=results;type=batting"
tables=readHTMLTable(url,stringsAsFactors = F)
#Note we wrote stringsAsFactors=F in this to avoid getting factor variables, 
#since we will need to convert these variables to numeric variables
table2=tables$"Overall figures"
rm(tables)
#Creating new variables from Span
table2$Debut=as.numeric(substr(table2$Span,1,4))
table2$LastYr=as.numeric(substr(table2$Span,6,10))
table2$YrsPlayed=table2$LastYr-table2$Debut
#Creating New Variables. In cricket a not out score is denoted by * which can cause data quality error. 
#This is treated by grepl for finding and gsub for removing the *. 
#Note the double \ to escape regex charachter
table2$HSNotOut=grepl("\\*",table2$HS)
table2$HS2=gsub("\\*","",table2$HS)
#Creating a FOR Loop (!) to convert variables to numeric variables
for (i in 3:17) {
      table2[, i] <- as.numeric(table2[, i])
  }
