library(shiny)

shinyServer(function(input, output) {
    
    output$html_sidebartitle <- renderUI(h5("Enter the Car Specs"))
    
    observeEvent(input$btn_predmpg, {
        output$user_car_specs <- renderUI(tagList(h4("Chosen Car Specifications"), 
            div(id = "div_cyl", strong("Number of Cylinders: "), strong(input$sel_cylno),
                style = "color: #ffffff; background-color: #f62459; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_disp", strong("Displacement: "), strong(input$num_disp),
                style = "color: #000000; background-color: #f7ca18; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_hp", strong("Gross horsepower: "), strong(input$num_hp),
                style = "color: #ffffff; background-color: #f9690e; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_drat", strong("Rear axle ratio: "), strong(input$num_drat),
                style = "color: #ffffff; background-color: #963694; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_wt", strong("Weight: "), strong(input$num_wt),
                style = "color: #000000; background-color: #89c4f4; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_qsec", strong("1/4 mile time: "), strong(input$num_qsec),
                style = "color: #ffffff; background-color: #013243; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_vs", strong("Engine: "), strong(names(engine_types[engine_types == input$sel_vs])),
                style = "color: #000000; background-color: #23cba7; display: inline-block; padding: 5px; margin: 1px"),                      
            div(id = "div_am", strong("Transmission: "), strong(names(transmission_types[transmission_types == input$sel_am])),
                style = "color: #ffffff; background-color: #f1828d; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_gear", strong("Number of forward gears: "), strong(input$sel_gear),
                style = "color: #000000; background-color: #81cfe0; display: inline-block; padding: 5px; margin: 1px"),
            div(id = "div_carb", strong("Number of carburetors: "), strong(input$sel_carb),
                style = "color: #ffffff; background-color: #2c3e50; display: inline-block; padding: 5px; margin: 1px"),
                                 ))
        user_car_input <- data.frame("cyl" = input$sel_cylno, "disp" = input$num_disp, "hp" = input$num_hp, 
                                     "drat" = input$num_drat, "wt" = input$num_wt, "qsec" = input$num_qsec,
                                     "vs" = input$sel_vs, "am" = input$sel_am, "gear" = input$sel_gear,
                                     "carb" = input$sel_carb)
        mpg_pred <- pred_mpg(user_car_input)
        output$car_mileage_prediction <- renderUI(tagList(div(h3("Car Mileage Prediction"), h1(mpg_pred), 
                                            p("+/- 2.7"), p("Miles/(US) gallon"), 
                                            style = "border-style: dotted; border-color: #cf000f; padding: 5px")))
    })

})




