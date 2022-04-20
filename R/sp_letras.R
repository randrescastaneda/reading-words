m <- data.table(group = "minúsculas",
                 to_read = letters)
M <- data.table(group = "mayúsculas",
                 to_read = LETTERS)

dt <- rbindlist(list(m,M), use.names = TRUE)

fwrite(dt, "static/spanish/letras.csv")

