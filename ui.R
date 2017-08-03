ui <- fluidPage(
  
  titlePanel("Mortality risk calculator for patients with tuberculous meningitis"),
  h4("Calculating 9-month mortality risk for tuberculous meningitis patients with and without HIV-coinfection"),
  # Increase font size and change color of the output
  tags$head(tags$style("#predict1{color: red;
                       font-size: 20px;
                       font-style: italic;
                       }
                       #predict2{color: red;
                       font-size: 20px;
                       font-style: italic;
                       }"
  )
  ),
  
  navbarPage("HIV",
             tabPanel("Negative",
                      sidebarLayout(
                        sidebarPanel(
                          helpText("Calculate the risk of mortality at 9 months for patient with tuberculous meningitis"),
                          sliderInput(inputId = "age",
                                      label = "Age (years)",
                                      value = 25, min = 15, max = 100),
                          selectInput(inputId = "tbmgrade",
                                      label = "MRC Grade",choices = c("1","2","3")
                          ),
                          helpText("MRC Grade 1: Glasgow coma score (GCS) 15 and no focal neurological signs.",
                                   "MRC Grade 2: GCS 11- 14, or 15 with focal neurological signs.", 
                                   "MRC Grade 3: GCS <= 10"),
                          selectInput(inputId = "preTB",
                                      label = "Previous TB",choices = c("Yes","No")
                          ),
                          selectInput(inputId = "focal",
                                      label = "Focal Signs",choices = c("Yes","No")
                          ),
                          selectInput(inputId = "dex",
                                      label = "Dexamethasone",choices = c("Yes","No")
                          ),
                          sliderInput(inputId = "csflymp",
                                      label = "CSF Lymphocyte count (cells/mm3)",
                                      value = 25, min = 0, max = 500),
                          # actionButton(inputId = "click",
                          #              label = "Calculate")
                          submitButton("Calculate")
                        ),
                        mainPanel(
                          h4("Result:"),
                          h4("The probability of 9-month motarlity is "),
                          textOutput("predict1"))
                      )),
             tabPanel("Positive",
                      sidebarLayout(
                        sidebarPanel(
                          helpText("Calculate the risk of motarlity at 9 months for patient with tuberculous meningitis"),
                          sliderInput(inputId = "weight",
                                      label = "Weight(kg)",
                                      value = 25, min = 25, max = 100),
                          selectInput(inputId = "tbmgrade1",
                                      label = "MRC Grade",choices = c("1","2","3")
                          ),
                          helpText("MRC Grade 1: Glasgow coma score (GCS) 15 and no focal neurological signs.",
                                   "MRC Grade 2: GCS 11- 14, or 15 with focal neurological signs.", 
                                   "MRC Grade 3: GCS <= 10"),
                          sliderInput(inputId = "csflymp1",
                                      label = "CSF Lymphocyte count (cells/mm3)",
                                      value = 25, min = 0, max = 500),
                          sliderInput(inputId = "sodium",
                                      label = "Sodium (mmol/l)",
                                      value = 150, min = 100, max = 200),
                          sliderInput(inputId = "cd4",
                                      label = "CD4 (cells/mm3)",
                                      value = 25, min = 0, max = 500),
                          # actionButton(inputId = "click",
                          #              label = "Calculate")
                          submitButton("Calculate")
                        ),
                        mainPanel(
                          h4("Probability of 9-month motarlity"),
                          textOutput("predict2"))
                      ))
  )
  )
