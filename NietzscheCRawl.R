
library(webdriver)
#install_phantomjs()

#install.packages('xml2')
library('xml2')

library(webdriver)
require("rvest")



crawlBook <- function(shorty) {

  pjs_instance <- run_phantomjs()
  pjs_session <- Session$new(port = pjs_instance$port)
  url <- c(paste("http://www.nietzschesource.org/#eKGWB/",shorty, sep="")) 
  
  pjs_session$go(url)
  rendered_source <- pjs_session$getSource()
  html_document <- read_html(rendered_source)
  
  title_xpath <- paste("//div[contains(@id, 'eKGWB/",shorty,"-[Titel]')]/h1", sep="")
  
  title_text <- html_document %>%
    html_node(xpath = title_xpath) %>%
    html_text(trim = T)
  
  cat(title_text)
  
  body_xpath <- "//div[contains(@class, 'txt_block')]//p"
  body_text <- html_document %>%
    html_nodes(xpath = body_xpath) %>%
    html_text(trim = T) %>%
    paste0(collapse = "\n")
  
  #cat(body_text)
  
  
  text <- paste(title_text,body_text)
  write(c(gsub("[\r\n]", " ", text)), file="data/output.csv", append=T)

}
crawlBook("GT")
crawlBook("DS")
crawlBook("SE")
crawlBook("WB")
crawlBook("NJ")
crawlBook("MA-I")
crawlBook("MA-II")
crawlBook("M")
crawlBook("IM")
crawlBook("FW")
crawlBook("Za-I")
crawlBook("Za-II")
crawlBook("Za-III")
crawlBook("JGB")
crawlBook("GM")
crawlBook("WA")
crawlBook("GD")