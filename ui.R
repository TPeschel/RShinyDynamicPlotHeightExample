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
	
	# add a sliderInput to have something above the plot
	shiny::sliderInput( "SLIDER_N", "n", 100, 1000, 10 ),
	
	# add a plot with dynamic height
	shiny::uiOutput( "myPlotUI" ),
	
	fluidRow(
	
		# add a textOutput to have something below the plot
		column( 11, shiny::textOutput( "resolution_text" ) ),
	
		column( 1, shiny::tags$a( "Code on GitHub", href = "https://github.com/TPeschel/RShinyDynamicPlotHeightExample" ) )
	)
)
