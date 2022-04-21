url <- "https://corpus.rae.es/frec/5000_formas.TXT"

df <- read_tsv(url,
               col_names = c("orden", "to_read", "freqa", "freqr"),
               skip = 1,
               col_select = "to_read",
               locale = locale(encoding = "latin1"))

group    <- vector(mode = "character", length = nrow(df))
n_groups <- c(100, 400, 1000, 1500, 2000)
j <- 1
for (i in seq_along(n_groups)) {
  if (i == 1)  {
    lim <- n_groups[i]
  } else {
    lim <- n_groups[i] +  lim
  }
  group[j:lim] <- glue("Nivel {i}")
  j <- lim + 1
}

df$group <- group
setDT(df)

# remove one-letter words
df <- df[nchar(to_read) != 1]

fwrite(df, "static/spanish/palabras.csv")


