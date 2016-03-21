library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Expression of Genes in gEUvadis"),
  
  sidebarPanel(
    textInput("gene", "Gene ID:", "ENSMUSG00000059751"),
    submitButton("Update View")
  ),
  
  mainPanel(
    
    #h4("Summary"),
    
    plotOutput("distPlot")

  )
))
