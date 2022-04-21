m <- data.table(group = "minúsculas",
                 to_read = c(letters, "ñ", "ch", "ll"))
M <- data.table(group = "mayúsculas",
                 to_read = c(LETTERS, "Ñ", "CH", "LL"))

dt <- rbindlist(list(m,M), use.names = TRUE)

dt[, c("group", "to_read") :=
     lapply(.SD, parse_character, locale = locale(encoding = "latin1")),
   .SDcols = c("group", "to_read")]

fwrite(dt, "static/spanish/letras.csv")

