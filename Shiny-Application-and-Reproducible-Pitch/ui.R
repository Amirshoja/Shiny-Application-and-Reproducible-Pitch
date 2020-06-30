library(shiny)
source('Code.R')

shinyUI(fluidPage(

    titlePanel(h3("What's the MPG"), windowTitle = "What's the MPG"),
    titlePanel(h4("Build Any Car Specs and Predict its Gas Mileage")),

    tabsetPanel(
        tabPanel("The App",
    
    sidebarLayout(
        sidebarPanel(
            htmlOutput("html_sidebartitle"),
            selectInput("sel_cylno", label = "Number of cylinders", choices = c(4,6,8), multiple = FALSE),
            numericInput("num_disp", label = "Displacement (cu.in.)", value = 100),
            numericInput("num_hp", label = "Gross horsepower", value = 110),
            numericInput("num_drat", label = "Rear axle ratio", value = 3.00, step = 0.1),
            numericInput("num_wt", label = "Weight (1000 lbs)", value = 2.00, step = 0.1),
            numericInput("num_qsec", label = "1/4 mile time", value = 15.00, step = 0.1),
            selectInput("sel_vs", label = "Engine", choices = c("V-Shaped" = 0, "Straight" = 1) , multiple = FALSE),
            selectInput("sel_am", label = "Transmission", choices = c("Automatic" = 0, "Manual" = 1) , multiple = FALSE),
            selectInput("sel_gear", label = "Number of forward gears", choices = c(3,4,5) , multiple = FALSE),
            selectInput("sel_carb", label = "Number of carburetors", choices = c(2,3,4,5,6,8) , multiple = FALSE),
            actionButton("btn_predmpg", label = "Predict the Mileage",
                         style = "color: #fff; background-color: #337ab7; border-color: #2e6da4")
        ),

        mainPanel(
            htmlOutput("user_car_specs", style = "font-size: 11px"),
            htmlOutput("car_mileage_prediction", style = "text-align: center; margin-top: 100px;
                       display: inline-block; justify-content: center; display: flex")
        )
    )
        ),
    tabPanel("Documentation",
             includeHTML("Documentation.html")
             ))
))
