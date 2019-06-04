setwd("~/Projets_R/07_news_scraper")

source("news_scraper_le.R")
source("word_cloud.R")
source("replacer.R")

topics = c("defence", 
                 "healthcare")
urls = c("https://www.lesechos.fr/industrie-services/air-defense", 
               "https://www.lesechos.fr/industrie-services/pharmacie-sante")

for (i in 1:length(topics)){

  topic = topics[i]
  url_le = urls[i]
  
  scraped_data_le <- try(news_scraper_le(url = url_le), silent = 0)
  
  headings = ""
  for (i in 1:10){
    headings = paste(headings, scraped_data_le$heading[i], collapse = " ")
  }
  
  word_cloud(topic = topic, headings = headings)
  
  replacer(topic = topic, scraped_data = scraped_data_le)
}

source("sender.R")

file.copy("template_backup.html", "template.html", overwrite = TRUE)
