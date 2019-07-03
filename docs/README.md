# RShinyDynamicPlotHeightExample
example to demontrate how a dynamic plot height can be realized in shiny and R

```
###
# minimal example
###

###
# first: find by binary partition the right values for the height of the slider and text and min plot.height
###
                                                  # in my browser, maybe in all ;o)
slider.height   <- 64 + 32 + 4                    # 100
text.height     <- 16 + 4                         # 20
min.plot.height <- 128 + 64 + 32 + 16 + 8 + 4 + 1 # 253

###
# build an app with a slider on top, a plot in the middle and a text output at the window's bottom
# the plot's height should react on the browser window's height
###

shiny::shinyApp(
	ui = shiny::fluidPage(
		
		title = "RShinyDynamicPlotHeightExample",
		
		###
		# combining
		# https://ryanve.com/lab/dimensions/
		# and
		# https://stackoverflow.com/questions/36995142/get-the-size-of-the-window-in-shiny
		# gives something like that
		###
		shiny::tags$head(
			shiny::tags$script(
				"
				// define a function that returns a struct named resolution
				// containing width and height of the inner window
				// accessible in shiny as a list named input$resolution
				// which elements are
				// width:  input$resolution$width
				// height: input$resolution$height
				function
				resized( e ) {
            		Shiny.onInputChange( 
            			'resolution', 
            			{ 
            				width  : window.innerWidth,
            				height : window.innerHeight
            			}
            		);
				}
            	
            	// call the function resized when shiny connects
				$(document).on(
                	'shiny:connected',
                	resized
                );

            	// call the function resized when the window resizes
                $( window ).resize(
                	resized
                );
				"
			)
		),
		
		# add a sliderInput to have something above the plot
		shiny::sliderInput( "SLIDER_N", "n", 100, 1000, 10 ),
		
		# add a plot with dynamic height
		shiny::uiOutput( "myPlotUI" ),
		
		# add a textOutput to have something below the plot
		shiny::textOutput( "resolution_text" )
	),
	
	server = function( input, output, session ) {
		
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
)

```