library(lubridate)
library(shiny)

#Sources
# https://www.orientacionandujar.es/wp-content/uploads/2019/05/Listado-de-s%C3%ADlabas-palabras-y-oraciones-de-todas-las-letras.pdf

words <- c(letters, LETTERS)
words <- c("Dios", "Jesús", "carro", "perro", "mamá", "hola", "chao", "usted", "tú", "él", "ella", "amor", "caro", "sí", "no", "ahora", "después", "cuando", "está", "esta", "soy", "es", "ya", "papá", "español")

ui <- fluidPage(
  hr(),
  actionButton('start','Start'),
  actionButton('stop','Stop'),
  actionButton('reset','Reset'),
  numericInput('seconds','Seconds:',value=5,min=0,max=99999,step=1),
  textOutput('timeleft'),
  textOutput('word'),
  tags$head(tags$style("#word{color: red;
                                 font-size: 120px;
                                 font-style: italic;
                                 text-align: center;
                                 }"
  )
  )

)

server <- function(input, output, session) {

  # Initialize the timer, 5 seconds, not active.
  timer <- reactiveVal(5)
  active <- reactiveVal(FALSE)

  # Output the time left.
  output$timeleft <- renderText({
    paste("Time left: ", seconds_to_period(timer()))
  })
  output$word <- renderText({
    invalidateLater(input$seconds*1000)
    if(active()) {
      sample(words, 1)
    }
  })

  # observer that invalidates every second. If timer is active, decrease by one.
  observe({
    invalidateLater(1000, session)
    isolate({
      if(active()) {

        timer(timer()-1)
        if(timer()<1)
        {
          # active(FALSE)
          # showModal(modalDialog(
          #   title = "Important message",
          #   "Countdown completed!"
          # ))

          timer(input$seconds)

        }
      }
    })
  })

  # observers for actionbuttons
  observeEvent(input$start, {
    timer(input$seconds)
    active(TRUE)
    })
  observeEvent(input$stop, {active(FALSE)})
  observeEvent(input$reset, {timer(input$seconds)})

}

shinyApp(ui, server)

