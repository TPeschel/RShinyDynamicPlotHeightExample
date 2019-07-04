###
# build an app with a slider on top, a plot in the middle and a text output at the window's bottom
# the plot's height should react on the browser window's height
###

ui <- shiny::fluidPage(
	
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
	
	fluidRow(
		# add a sliderInput to have something above the plot
		column( 6, shiny::sliderInput( "SLIDER_N", "count of random numbers", 100, 1000, 10 ) ),
		column( 6, shiny::tags$a( "Code on GitHub", href = "https://github.com/TPeschel/RShinyDynamicPlotHeightExample" ) )
	),
	
	# add a plot with dynamic height
	shiny::uiOutput( "myPlotUI" ),
		
	# add a textOutput to have something below the plot
	shiny::textOutput( "resolution_text" )
)
