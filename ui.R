library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Linear model comparison on the mtcar dataset"),
  sidebarPanel(
      h3("Exploratory data analysis:"),
        checkboxInput("summary_data", h4("Show summary of dataset"), value = TRUE),
      
#       checkboxInput("deciles", "Show  for subset of variables:", value = FALSE),
#       conditionalPanel(
#         condition = "input.histogram == true",
        fluidRow(
          h4("Show histogram for one selected variable:"),
          selectInput("histo_var", 
                      label = "Chosen variable:", 
                      list("mpg" = "mpg", "cyl" = "cyl", "disp" = "disp", "hp"= "hp", "drat" = "drat", "wt" = "wt", 
                           "qsec" = "qsec", "vs" = "vs","am"= "am", 
                           "gear"= "gear", "carb"= "carb"),
                      selected = "cyl"
          ),
          numericInput("bin", 
                       label = "Maximal number of bins:", 
                       value = 10)
          ),
        
    
      h3("Parameters for the first model:"),
      checkboxGroupInput("Var_choice_1", 
                       label = h4("Regressors to include in first model:"), 
                       list("cyl" = "cyl", "disp" = "disp", "hp"= "hp", "drat" = "drat", "wt" = "wt", 
                            "qsec" = "qsec", "vs" = "vs","am"= "am", 
                            "gear"= "gear", "carb"= "carb"),
                       selected = "cyl"),
      h4("Other summary info for the first model:"),
      checkboxInput("showdiag1", "Show the diagnosis results for the first model", value = FALSE),
      checkboxInput("showdplot1", "Show the summary plots for the first model", value = TRUE),
      h3("Parameters for the second model:"),
      checkboxGroupInput("Var_choice_2", 
                         label = h4("Regressors to include in second model:"), 
                         list("cyl" = "cyl", "disp" = "disp", "hp"= "hp", "drat" = "drat", "wt" = "wt", 
                              "qsec" = "qsec", "vs" = "vs","am"= "am", 
                              "gear"= "gear", "carb"= "carb"),
                         selected = "cyl"),
        
      h4("Other summary info for the second model:"),
      checkboxInput("showdiag2", "Show the diagnosis results for the second model", value = FALSE),
      checkboxInput("showdplot2", "Show the summary plots for the second model", value = TRUE),
      
#     numericInput('id1', 'Share of observations in training data set: ', 0.5 , min = 0, max = 1, step = 0.1),
#       checkboxGroupInput("id2","Checkbox",
#                           c("Value 1" = "1", "Value 2" = "2", "Value 3" = "3")
#                          ),
      dateInput("date", "Date:")
    
    ),
  mainPanel(
    
#     h4('The chosen regressors in the are:'),
#     verbatimTextOutput("regressors")
    h2('Guidance'),
    p("This application addresses the determinants of the miles per callon (MPG) of passenger cars, 
    using the `mtcars' dataset. The user can run two different linear models to forecast MPG for a given combination 
    of car characteristics. "),
    p("For each model, the user can choose the regressors he wants to include in the linear model. Note
      that our application does not allow for the creation of interaction terms between different regressors."),
    
    p("As explained in the help file to this data set, it contains 32 observations on 11 variables:"),
    br(),
    em("mpg:   Miles/(US) gallon "),br(),
    em("	 cyl:	 Number of cylinders" ),br(),
      em("	 disp:	 Displacement (cu.in.)" ),br(),
    em("	 hp:	 Gross horsepower" ),br(),
        em("	 drat:	 Rear axle ratio" ),br(),
    em("	 wt:	 Weight (lb/1000)" ),br(),
    em("	 qsec:	 1/4 mile time" ),br(),
  em("	 vs:	 V/S" ),br(),
  em("	 am:	 Transmission (0 = automatic, 1 = manual)" ),br(),
em("	 gear:	 Number of forward gears" ),br(),
em("	 carb:	 Number of carburetors" ),br(),br(),
    
    br(),
  p("Per default, our model presents the summary statistics for the dataset. The user can also ask for the display
    of the histogram of one specific variable - he can also chose the maximum number of bins in this histogram. "),
    p("Our application returns the default summary tables for each model, including the model specification, the key
 quantiles of the residuals, the estimated coefficients and their
      significance levels, the R2 and the adjusted R2, the F statistics, etc."),
    
    p("Moreover, for each model, the user can require the display of the model diagnostics (per default, they
      are not shown) in order to identify influential observations."),
    p("Per default, the 4 key plots to identify outliers and influential observations are also displayed 
      for each model, but the user can choose to hide them."),
    p("Finally, the ANOVA table comparing the two models is represented. Note that this table can only
      be given a meaningfull interpretation if the first model is embedded in the second. "),
#      ,
  br(),
    h4('The summary statistics of the model are:'),
    tableOutput("summary_out"),
    h4('The histogram of the chosen variable is:'),
    plotOutput("plothisto"),
    h4('The first model results are:'),
     verbatimTextOutput("modres1"),
    h4('Diagnosis results for the first model:'),
    verbatimTextOutput("diagnos1"),
    h4('Summary plot for the first model:'),
    plotOutput("plot1", height = "900px"),
    h4('The second model results are:'),
    verbatimTextOutput("modres2"),
    h4('Diagnosis results for the second model:'),
    verbatimTextOutput("diagnos2"),
    h4('Summary plot for the second model:'),
    plotOutput("plot2", height = "900px"),
    h4('ANOVA tables comparing both models:'),
    div('Note that these results are only meaningfull if the first model is embedded in the second:', style = "color:red"),
    verbatimTextOutput("anova")
            
            )      
  
  )
        
)
