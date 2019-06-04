

replacer <- function(topic, scraped_data){
template <- readLines("template.html", warn=FALSE)

code = ""

options(encoding = "latin1")
for (i in 1:6) {
heading_left = '<li style="font-size: 14px; line-height: 16px;"><span style="font-size: 12px; line-height: 14px; color: #000000;">'
heading = scraped_data$heading[i]
heading_right = ' - </span><span style="font-size: 12px; line-height: 14px;"><a href="'
link = scraped_data$link[i]
link_right = '" rel="noopener" style="color: #0068A5;" target="_blank" title="'
summary = scraped_data$summary[i]
summary_right = '">more</a></span></li>'

row = paste0(heading_left, heading, heading_right, link, link_right, summary, summary_right)

code = paste0(code, "\n", row)
}

y <- gsub(paste0("key_", topic), code, template)
cat(y, file="template.html", sep="\n")
}