library( shiny )
library( shinyjs )
library( shinyWidgets )

ui <- fluidPage(
	
	shinyjs::useShinyjs( ),
	
	shiny::tags$head(
		shiny::tags$script(
			"
			// define a function that returns a struct named resolution
			// containing width and height of the inner window
			// accessible in shiny as a list named input$resolution
			// which elements are
			// width:  input$resolution$width
			// height: input$resolution$height
			function resized( e ) {
				Shiny.onInputChange( 
					'resolution', 
					{ 
						width  : window.innerWidth,
						height : window.innerHeight
					}
				);
			}
			
			function printDom( ) {
				$('*').each(function(i,e){console.log(i+' '+e)});
			}
			
			// call the function resized when shiny connects
			$( document ).on(
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
	fluidRow(
		column( width = 4, offset = 0, sliderInput( "n",     "#obs",  1000, 100000, 1000, 1000 ) ),
		column( width = 4, offset = 0, sliderInput( "mu",    "mu",    1, 10, 1 ) ),
		column( width = 4, offset = 0, sliderInput( "sigma", "sigma", 1, 10, 1 ) )
	),
	
	shiny::uiOutput( "myPlotUI" ),
	
	progressBar( "progress", 0, 5, T, size = 'sm', "primary", T, unit_mark = "s" )
)
