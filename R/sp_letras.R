m <- data.table(group = "minúsculas",
                 to_read = c(letters, "ñ", "ch", "ll"))
M <- data.table(group = "mayúsculas",
                 to_read = c(LETTERS, "Ñ", "CH", "LL"))

dt <- rbindlist(list(m,M), use.names = TRUE)

fwrite(dt, "static/spanish/letras.csv")

