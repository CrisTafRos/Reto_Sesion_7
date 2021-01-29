install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")

library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

class(DataDB)
head(DataDB)
str(DataDB)

hispano <- DataDB %>%
  filter(Language == "Spanish")

hispano.df <- as.data.frame(hispano)

class(hispano.df)

ggplot(hispano.df, aes(x = CountryCode, y = Percentage)) +
  geom_bin2d()
