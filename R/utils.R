library(httr)
library(glue)

#' get training type depending on the language selected
#'
#' @param lang character: language selected
#'
#' @return
#' @export
#'
#' @examples
training_type <- function(lang) {

  # on.exit ------------
  on.exit({

  })

  # Defenses -----------
  stopifnot( exprs = {

    }
  )

  # Early returns ------
  if (FALSE) {
    return()
  }

  # Computations -------
  url_tree <-
    "https://api.github.com/repos/randrescastaneda/reading-words/git/trees/main?recursive=true"
  req <- GET(url_tree)

  stop_for_status(req)

  filelist <-
    lapply(content(req)$tree, "[", "path")  |>
    unlist(use.names = F) |>
    fs::as_fs_path()

  lang_dir <- fs::path("static", lang)

  traning_type <-
    fs::path_filter(filelist, regexp = glue("{lang_dir}.*csv")) |>
    fs::path_file() |>
    fs::path_ext_remove()



  # Return -------------
  return(invisible(traning_type))

}

#' load training type file
#'
#' @param lang character: language selected
#' @param tt character: training type
#'
#' @return
#' @export
#'
#' @examples
training_type_file <- function(lang, tt) {

  # on.exit ------------
  on.exit({

  })

  # Defenses -----------
  stopifnot( exprs = {

    }
  )

  # Early returns ------
  if (FALSE) {
    return()
  }

  # Computations -------


  # Return -------------
  return(invisible(TRUE))

}



dd <- "https://github.com/randrescastaneda/reading-words/raw/main/statis/spanish/letras.csv"
fread(dd)