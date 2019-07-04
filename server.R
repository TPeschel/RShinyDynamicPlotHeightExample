server <- function( input, output, session ) {
	
	# min.plot.height <- 253 was found by observing height when the plot crashes
	screen.height <- function( ) {
		
		print( input$resolution )
		
		i <-
			ifelse(
				is.null( input$resolution ) || input$resolution$height < min.plot.height + slider.height + text.height,
				min.plot.height,
				as.integer( input$resolution$height )
			)
		
		print( i )
		
		i
	}
	
	# show a scatter plot some of gauss distribution
	output$myPlot <- shiny::renderPlot( {
		
		plot( 1 : input$SLIDER_N, rnorm( input$SLIDER_N ) )	
	} )
	
	# render the plot with dynamic height
	output$myPlotUI <- shiny::renderUI( {
		
		shiny::plotOutput(
			"myPlot",
			height = screen.height( ) - slider.height - text.height
		)	
	} )
	
	# just some text
	# prints the resolution
	output$resolution_text <- renderText( {
		
		paste0( "width: ", input$resolution$width, "   height: ", input$resolution$height )
	} )
}
