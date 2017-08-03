# dir <- "C:/Users/thaoltp/Dropbox/TBMpooled/Thao/" #desktop dropbox
# dir <- "/Users/thaole/Dropbox/TBMpooled/Thao/" #desktop dropbox
load(file =  "hivneg_long.Rdata")
load(file =  "hivpos_long.Rdata")
library(survival)
library(rms)
library(pec)


# data modification
data.imp.long$HistDay.log2 <- log2(data.imp.long$HistDay)
data.imp.long$CSF_WCC.log2  <- log2(data.imp.long$CSF_WCC)
data.imp.long$CSF_Pro.log2  <- log2(data.imp.long$CSF_Pro)
data.imp.long$CSF_Lymp_Count.log2 <- log2(data.imp.long$CSF_Lymp_Count)
data.imp.long$Ttdead.271 <- pmin(data.imp.long$Ttdead,271)
data.imp.long$Evdead.271 <- ifelse(data.imp.long$Ttdead<=271, data.imp.long$Evdead, 0)
data.imp.long$CSF_BGlu_Ratio.log2 <- log2(data.imp.long$CSF_BGlu_Ratio)

data.imp.long1$HistDay.log2 <- log2(data.imp.long1$HistDay)
data.imp.long1$CSF_WCC.log2  <- log2(data.imp.long1$CSF_WCC)
data.imp.long1$CSF_Pro.log2  <- log2(data.imp.long1$CSF_Pro)
data.imp.long1$CSF_Lymp_Count.log2 <- log2(data.imp.long1$CSF_Lymp_Count)
data.imp.long1$Ttdead.271 <- pmin(data.imp.long1$Ttdead,271)
data.imp.long1$Evdead.271 <- ifelse(data.imp.long1$Ttdead<=271, data.imp.long1$Evdead, 0)
data.imp.long1$CSF_BGlu_Ratio.log2 <- log2(data.imp.long1$CSF_BGlu_Ratio)
data.imp.long1$Cohort[data.imp.long1$Cohort == "PK"] <- "DEX"
data.imp.long1$CD4.log2 <- log2(data.imp.long1$CD4 + 1)



mymodel <- coxph(Surv(Ttdead.271, Evdead.271) ~ Age + Prev_TB + FocalSign + TBMGrade +  Dex + CSF_Lymp_Count.log2, 
                 data = data.imp.long)
mymodel1 <- coxph(Surv(Ttdead.271, Evdead.271) ~ Weight + rcs(Sodium,c(118,127,136)) + I(log2(CD4 + 1)) + TBMGrade +  CSF_Lymp_Count.log2 + Cohort, 
                  data = data.imp.long1)

server <- function(input, output, session){
  output$predict1 <- renderText(paste(round((1- predictSurvProb(mymodel, 
                                                                newdata = data.frame(Age = input$age, 
                                                                                     Prev_TB = input$preTB,
                                                                                     FocalSign = input$focal,
                                                                                     TBMGrade = input$tbmgrade,
                                                                                     Dex = input$dex,
                                                                                     CSF_Lymp_Count.log2 = log2(input$csflymp)),
                                                                times = 270))*100,2),"%"))
  output$predict2 <- renderText(paste(round((1- summary(survfit(mymodel1, 
                                                                newdata = data.frame(Weight = input$weight, 
                                                                                     TBMGrade = input$tbmgrade1,
                                                                                     CSF_Lymp_Count.log2 = log2(input$csflymp1),
                                                                                     CD4 = input$cd4,
                                                                                     Sodium = input$sodium,
                                                                                     Cohort = "05TB")),
                                                        times = 270)$surv)*100,2),"%"))
  
}
