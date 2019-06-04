# https://resoomer.com/developers/
# setwd("~/Projets_R/07_news_scraper")
library(rvest)
library(RCurl)
library(XML)
library(readxl)
library(stringr)
# cac40 <- read_excel("cac40.xlsx")

# url=paste0("https://www.lesechos.fr/industrie-services/air-defense")

news_scraper_le <- function(url) {
scraped_data = data.frame(matrix(vector(), 40, 6,
                                 dimnames=list(c(), c("name", "date_day", "date_month", "heading", "link", "summary"))),
                          stringsAsFactors=F)

key_heading = "ywfeno-6 jLTaYP sc-17z4c6f-0 ITOvF"
key_date = "Publi"
key_summary = "sc-1fzzxw0-0 cjNsaq"

webpage <- read_html(url)

# get heading and link of article
index <- gregexpr(pattern = key_heading, webpage)
for(i in 1:10){
  # heading
  start_rough <- index[[1]][i] + nchar(key_heading) + 14
  stop_rough <- start_rough + str_locate(substr(webpage, start_rough, start_rough+1000), '" href')[1,1] - 2
  scraped_data$heading[i] = substr(webpage, start_rough, stop_rough)
  
  
  # link
  start_rough <- stop_rough + length('" href') + 9
  stop_rough <- start_rough + str_locate(substr(webpage, start_rough, start_rough+1000), '</a>')[1,1]-5
  scraped_data$link[i]=paste0("https://www.lesechos.fr/", substr(webpage, start_rough, stop_rough))
}

# get date of article
index <- gregexpr(pattern = "Publi", webpage)
for(i in 1:10){
  start_rough <- index[[1]][i] + nchar("Publi") + 4
  stop_rough <- start_rough + str_locate(substr(webpage, start_rough, start_rough+100), 'h')[1,1] + 1
  date = substr(webpage, start_rough, stop_rough)

  if (substr(date, 3, 3) != "/")
  {date = paste0(substr(Sys.Date(), 9,10),
                                "/",
                                substr(Sys.Date(), 6,7),
                                " à ",
                                scraped_data$date[i])
  }
  
  scraped_data$date_day[i] = substr(date, 1, 2)
  scraped_data$date_month[i] = substr(date, 4, 5)
}

# get summary of article
index <- gregexpr(pattern = key_summary, webpage)
for(i in 1:10){
  start_rough <- index[[1]][i] + nchar(key_summary) + 2
  stop_rough <- start_rough + str_locate(substr(webpage, start_rough, start_rough + 1000), '</div>')[1,1] - 2
  scraped_data$summary[i] = substr(webpage, start_rough, stop_rough)
}
return(scraped_data)
}
