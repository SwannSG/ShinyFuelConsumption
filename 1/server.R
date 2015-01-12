library(shiny)

data(mtcars)
d = mtcars
#--transmission type
d$am = factor(d$am,
              levels=c(0,1),
              labels=c('auto', 'manual'))
model = lm(mpg ~ wt + qsec + am, data=d)



shinyServer(
  function(input, output) {

    output$weight = renderText(paste('Weight            : ', input$weight, ' pounds', sep=''))
    output$qmtime = renderText(paste('Quarter mile time : ', input$qmtime, ' seconds', sep=''))
    output$manauto = renderText(paste('Transmission type: ', input$manauto, sep=''))
    
    output.result =  reactive({
                              req = data.frame('wt'=input$weight/1000,
                                               'qsec'=input$qmtime,
                                               'am'=input$manauto)
                              results = predict(model,
                                                req,
                                                interval='prediction',
                                                level=0.95)
                              })

    output$fit = renderText({ paste('Expected fuel consumption: ',
                                    signif(output.result()[1, c('fit')],3),
                                    ' +/- ',
                                    signif( output.result()[1, c('fit')] - output.result()[1, c('lwr')], 3),
                                    ' miles per gallon',
                                    sep='')
                           })

})