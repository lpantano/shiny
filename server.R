library(shiny)
library(ggplot2)
load("rld")

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {

  datasetInput <- reactive({
    
    exp<-(unlist(assay(rld)[input$gene,]))
    gen<-c(rep("OMP",4),rep("RT",4))
    exp<-data.frame(exp=exp,gen=gen)
    
    
  })
  
  
  
  output$distPlot <- renderPlot({
    d<-datasetInput()
    
    p <- ggplot(d, aes(factor(gen), exp)) +
      geom_boxplot(outlier.size = 0) + geom_jitter(position=position_jitter(width=0.2),aes(factor(gen), exp,colour=gen)) +
      scale_colour_manual(values=c("green3","blue2"))+
      theme_bw(base_size = 16, base_family = "serif") +
      theme(axis.text.x=element_text(angle = 90, hjust = 1))+
      labs(list(title=input$gene,y="log2(norm_counts)",x=""))
    
    print(p)
  })
  

  
})

