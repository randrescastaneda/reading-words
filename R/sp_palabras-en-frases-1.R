
#   ____________________________________________________________________________
#   load libraries                                                          ####

library(here)
library(rvest)
library(polite)
library(tidyverse)
library(tidytext)



main_url <- "https://www.guiainfantil.com/"
blog_url <- "articulos/educacion/autoestima/49-frases-para-motivar-a-los-ninos/"

url  <- paste0(main_url, blog_url)

html <- read_html(url)

session <- bow(main_url, force = TRUE)



text <-
  nod(session, blog_url) %>%
  scrape() %>%
  # The '.' indicates the class
  html_elements('#post-content > div.post-body') %>%
  # Extract the raw text as a list
  html_text2() %>%
  unlist() %>%
  paste0(collapse = "\n")


dt <- tibble(text = text) |>
  unnest_tokens(to_read, text, token = "lines") |>
  filter(grepl("^[0-9]", to_read)) |>
  mutate(to_read = gsub("(^[0-9]+\\.\\s*)(.*)", "\\2", to_read)) |>
  mutate(group = as.character(row_number())) |>
  as.data.table()


dt[, c("group", "to_read") :=
     lapply(.SD, parse_character, locale = locale(encoding = "latin1")),
   .SDcols = c("group", "to_read")]

fwrite(dt, "static/spanish/frases.csv")


df <- dt |>
  unnest_tokens(to_read, to_read)

fwrite(df, "static/spanish/palabras-en-frases.csv")

