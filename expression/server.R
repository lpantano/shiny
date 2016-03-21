#https://gist.github.com/jcheng5/4050398
library(ggplot2)
options(shiny.maxRequestSize = -1)
shinyServer(function(input, output, session) {
  
    loadData <- function(path){
        load(path)
        updateSelectInput(session, "srcgen", choices = colnames(deg[[2]]), selected="time")
        updateSelectInput(session, "srccol", choices = colnames(deg[[2]]), selected="group")
        assign('deg',deg,envir=.GlobalEnv)
    }
    
   observe({
    if (is.null(input$files)) {
      # User has not uploaded a file yet
      return(NULL)
    }
     loadData(input$files$datapath)
  })
  
  datasetInput <- reactive({
    if (input$do==0) {
      return(NULL)
    }else{
    data<-deg[[1]]
    des<-deg[[2]]
    exp<-(unlist(data[input$gene,]))
    gen<-des[,input$srcgen]
    col<-des[,input$srccol]

    exp<-list(data.frame(exp=exp,gen=gen,col=col))
    return(exp)
    }
    
  })
  
  output$distPlot <- renderPlot({
    if (input$do>0) {
      
    d<-datasetInput()[[1]]
    p <- ggplot(d, aes(factor(gen), exp, color=col)) +
      geom_jitter(aes(group=col),size=1) +
      stat_smooth(aes(x=factor(gen), y=exp, group=col),size=0.3, fill="grey80") +
      geom_boxplot(aes(fill=col),alpha = 0.2) +
      theme_bw(base_size = 7) +
      scale_color_brewer(palette="Set1")+
      theme_bw(base_size = 16, base_family = "serif") +
      labs(list(title=input$gene,y="abundance",x=""))
    suppressWarnings(print(p))
    }
  })
})