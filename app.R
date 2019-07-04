###
# minimal example
###

source( "ui.R" )
source( "server.R" )

shiny::shinyApp(
	ui = ui,
	server = server
)

###
# some shinydashboard use example
###
# shiny::shinyApp(
# 
# 	ui = shinydashboard::dashboardPage(
# 
# 		shiny::tags$head(
# 			shiny::tags$script(
# 				'
# 				var res = [ 0, 0 ];
#                 $(document).on("shiny:connected", function(e) {
#                     res[0] = window.innerWidth;
#                     res[1] = window.innerHeight;
#                     Shiny.onInputChange("dims",res);
#                 });
#                 $(window).resize(function(e) {
#                     res[0] = window.innerWidth;
#                     res[1] = window.innerHeight;
#                     Shiny.onInputChange("dims",res);
#                 });
# 				'
# 			)
# 		),
# 
# 		header = shinydashboard::dashboardHeader(
# 
# 			title = "Dynamic UI Height Example"
# 		),
# 
# 		sidebar = shinydashboard::dashboardSidebar(
# 
# 			shinydashboard::sidebarMenu(
# 
# 				shinydashboard::menuItem(
# 
# 					text    = "PLOT",
# 					tabName = "TAB_PLOT"
# 				)
# 			)
# 		),
# 
# 		body = shinydashboard::dashboardBody(
# 
# 			shinydashboard::tabItems(
# 
# 				shinydashboard::tabItem(
# 
# 					"TAB_PLOT",
# 					shinydashboard::box(
# 
# 						title  = "dynamic height",
# 						width  = 12,
# 						height = '100%',
# 						collapsible = T,
# 
# 						shiny::uiOutput( "ui" )
# 					)
# 				)
# 			)
# 		)
# 	),
# 
# 	server = function( input, output, session ) {
# 
# 		plot_height <- function( ) {
# 
# 			ifelse(
# 				is.null( input$dims ) || input$dims[ 2 ] < 134 * 2 + 150,
# 				134,
# 				as.integer( ( as.integer( input$dims[ 2 ] ) - 150 ) / 2 )
# 			)
# 		}
# 
# 		output$plot1 <- shiny::renderPlot( { plot( rep_len( 50, 100 ), 1 : 100 ) } )
# 
# 		output$plot2 <- shiny::renderPlot( { plot( 1 : 100, rep_len( 50, 100 ) ) } )
# 
# 		output$plot3 <- shiny::renderPlot( { plot( 1 : 100, 1 : 100 ) } )
# 
# 		output$plot4 <- shiny::renderPlot( { plot( 1 : 100, 100 : 1 ) } )
# 
# 		output$ui    <- shiny::renderUI( {
# 
# 			shiny::fluidRow(
# 				shiny::column(
# 					width = 6,
# 					shiny::plotOutput( "plot1", height = plot_height( ) ) ),
# 
# 				shiny::column(
# 					width = 6,
# 					shiny::plotOutput( "plot2", height = plot_height( ) ) ),
# 
# 				shiny::column(
# 					width = 6,
# 					shiny::plotOutput( "plot3", height = plot_height( ) ) ),
# 
# 				shiny::column(
# 					width = 6,
# 					shiny::plotOutput( "plot4", height = plot_height( ) ) )
# 			)
# 		} )
# 	}
# )
