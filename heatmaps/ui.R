shinyUI(pageWithSidebar(
  headerPanel("Create custom heatmaps"),
  sidebarPanel(
    fileInput("files", "Count matrix", multiple=TRUE),
    selectInput("palette","Select colour:", c("RdBu","Blues","BuGn","BuPu","GnBu","Greens","Greys","Oranges","OrRd","PuBu","PuBuGn","PuRd","Purples","RdPu","Reds","YlGn","YlGnBu","YlOrBr","YlOrRd")),
    textInput("colorder", "Column order:", ""),
    checkboxInput("doroworder", "Cluster row", 0),
    checkboxInput("docolorder", "Cluster col", 0),
    checkboxInput("scale", "Scale row", 1),
    textInput("gene", "Gene ID:", ""),
    actionButton("do","Update View"),
    fluidPage(h3("Help"),
              br(),
              p("table should be a CSV file with header. First column will be used to look for gene names."),
              p("Gene names should be separared by spaces, and be in the same ID than the table."),
              p("Column order should be numbers indicating the index in the table.")
              )
  ),
  mainPanel(
    plotOutput("distPlot"),
    tableOutput("showOrder")
  )
))
