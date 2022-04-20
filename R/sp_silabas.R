
#   ____________________________________________________________________________
#   library                                                                 ####
library(data.table)
library(readr)
#   ____________________________________________________________________________
#   inputs                                                                  ####

spec  <- c("gu", "qu", "gü")
initl <-  c("m", "s", "t", "l", "r", "p", "n", "c", "d", "v", "f", "b", "f", "ñ", "g", "h", "ch", "ll", "y", "z", "x", "tr", "gr", "pt", "dr", "fr", "cl", "fl", "gl", "pl", "br", "cr")

aeiou <-  c("a", "e", "i", "o", "u")
ei    <- c("e", "i")


#   ____________________________________________________________________________
#   output                                                                  ####


##  ............................................................................
##  Regular cases                                                           ####

dt <-  expand.grid(v = aeiou, group = initl,  stringsAsFactors = FALSE)
setDT(dt)
dt[, to_read := paste0(group,v)
   ][, v := NULL
     ]


##  ............................................................................
##  Special cases                                                           ####

ft <-  expand.grid(v = ei, group = spec,  stringsAsFactors = FALSE)
setDT(ft)
ft[, to_read := paste0(group,v)
   ][, v := NULL
     ]

dt <- rbindlist(list(dt, ft), use.names = TRUE)

fwrite(dt, "static/spanish/silabas.csv")


