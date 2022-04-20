languages <- fs::dir_ls("static/", type = "directory")
languages <- fs::path_file(languages)
readr::write_lines(languages, "static/languages")
