shinyUI(pageWithSidebar(
  headerPanel("Plot Expression using DEGReport package output"),
  sidebarPanel(
    fileInput("files", "File data", multiple=TRUE),
    selectInput("srcgen","Select genotype:", "Loading..."),
    selectInput("srccol","Select colours:", "Loading..."),
    textInput("gene", "Gene ID:", "ENSMUSG00000039904"),
    actionButton("do","Update View")   
  ),
  mainPanel(
    plotOutput("distPlot")
  )
))