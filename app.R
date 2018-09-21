#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(ari)
library(animation)
library(tuneR)
library(shiny)

temp_dir <- tempdir()

n = 3
for (i in 1:n) {
    jpeg(file.path(temp_dir, paste0("plot", i, ".jpg")))
    plot(1:5 * i, 1:5, main = i)
    dev.off()
}

x <- seq(0, pi/2, length = 88200)
channel <- round(32000 * sin(440 * x))

sound <- replicate(
    n, 
    tuneR::Wave(channel,
                samp.rate = 44100, bit = 16))

graphs <- file.path(temp_dir, paste0("plot", 1:n, ".jpg"))
video <- file.path(temp_dir, "output.mp4")

res = ari_stitch(graphs, sound, output = video,
                 video_codec = "libx264")



# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Ari Test"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            downloadButton("downloadData", "Download")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            # Output: Tabset w/ plot, summary, and table ----
            textOutput("result")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$result = renderText({
        res
    })
    # Downloadable csv of selected dataset ----
    output$downloadData <- downloadHandler(
        filename = function() {
            "output.mp4"
        },
        content = function(file) {
            if (file.exists(video)) {
            file.copy(video, file, overwrite = TRUE)
            file
            } else {
                stop("no video")
            }
        },
        contentType = "video/mp4"
    )   
    
}

# Run the application 
shinyApp(ui = ui, server = server)
