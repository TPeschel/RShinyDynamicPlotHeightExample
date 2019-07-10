analyse <- function( x ,level = .975 ) {
	n <- length( x )
	m <- mean( x )
	v <- var( x )
	q <- qt( level, n - 1 ) * sqrt( v / n )
	list(
		N    = n,
		MEAN = m,
		SD   = sqrt( v ),
		LOW  = m - q, 
		HIGH = m + q 
	)
}

min.plot.height <- 253
y.offset <- 160

server <- function( input, output, session ) {
	
	rv <- reactiveValues( )
	
	rv$plot.time <- Sys.time( )
	
	screen.height <- function( ) {
		
		shinyjs::runjs( "$('*').each(function(i,e){console.log(i+' '+e)});" )
				
		print( input$resolution )
		
		i <-
			ifelse(
				is.null( input$resolution ) || input$resolution$height < y.offset + min.plot.height,
				min.plot.height,
				as.integer( input$resolution$height )
			)
		
		print( i )
		
		i
	}
	
	observe( {
		
		#print( paste0( "Check Plotauftrag: ", Sys.time( ) - rv$plot.time ) )
		dt <- Sys.time( ) - rv$plot.time
		if( 5 < dt ) {
			
			#print( "plotte" )
			x <- isolate( qnorm( 1 : input$n / ( input$n + 1 ), input$mu, input$sigma ) )
			y <- isolate( rnorm( input$n, input$mu, input$sigma ) )
			s <- sort( y )
			z <- s - x
			a <- analyse( z )
			print( a )
			
			output$plot <- renderPlot( 
				{
					par( mfrow = c( 2, 2 ) )
					plot( y )
					hist( y )
					plot( x, s )
					abline( 0, 1 )
					plot( x, z ) 
					abline( 0, 0 )
					par( mfrow = c( 1, 1 ) )
				}
			)
			
			output$myPlotUI <- renderUI( {
				
				plotOutput( "plot", height = screen.height( ) - y.offset )	
			} )
			
			updateProgressBar( session, "progress", 5., 5., "plot finished", "info" )
		}
		else {
			
			invalidateLater( 100 )
			
			updateProgressBar( session, "progress", dt, 5., "... left to plot", "success" )
			
			return( )
		}
	} )
	
	observeEvent(
		eventExpr = {
			c( input$n, input$mu, input$sigma )# input$resolution$height )
		},
		handlerExpr = {
			
			rv$plot.time <- Sys.time( )
			
			updateProgressBar( session, "progress", 0., 5., "start to plot", "primary" )
		}
	)
}
