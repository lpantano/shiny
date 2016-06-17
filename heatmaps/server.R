#https://gist.github.com/jcheng5/4050398
library(ggplot2)
library(pheatmap)
library(RColorBrewer)

options(shiny.maxRequestSize = -1)
shinyServer(function(input, output, session) {
    deg <- list()
    loadData <- function(path){
        deg <<-read.csv(path, row.names=1)
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
        g <- unlist(strsplit(input$gene, split = " "))
        stopifnot(length(g)>0)
        g <- intersect(g, rownames(deg))
        stopifnot(length(g)>0)
        d<-as.matrix(deg[g,])
        d <- d[rowSums(d)>0,]
        if (!input$doroworder)
            return(d)
        hr = hclust(as.dist(1-cor(t(d))), method = "ward.D2")
        return(d[hr$labels[hr$order], ])
    
    }
    NULL
  })
  
  output$distPlot <- renderPlot({
    if (input$do>0) {
        d<-datasetInput()
        if (!is.null(d)){
            
            my_palette <- rev(brewer.pal(11,input$palette))
            col_order <- as.numeric(unlist(strsplit(split = ",", input$colorder)))
            cluscol <- input$docolorder
            clusrow <- input$doroworder
            print(clusrow)
            if (input$colorder==""){
                col_order <- 1:ncol(d)
            }
            
            scale = "none"
            if (input$scale)
                scale = "row"
            pheatmap(d[,col_order], color=my_palette,
                     show_rownames=F, cluster_cols = cluscol,
                     scale="row",
                     cluster_rows = F, clustering_method = "ward.D2",
                     clustering_distance_cols = "correlation"
                     )
        }
    }
  })
  
  output$showOrder <- renderTable({
      d<-datasetInput()
      d
  })
})