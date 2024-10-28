makeggMDSPlot <- function(DGEListObject){
	library(tidyverse)
	library(edgeR)


	wd		<- getwd()
	plotDirName	<- file.path(wd, "Plot")
	plotDir		<- dir.create(plotDirName, showWarnings = FALSE)
	MDSPlotFile	<- file.path(plotDirName, paste0("MDSPLot",".png"))
	
	pMDS	 	<- plotMDS(cpm(DGEListObject))
	pMDSData 	<- data.frame( pMDS$x, pMDS$y, DGEListObject$samples$group)
	colnames(pMDSData) <- c("x", "y", "dataset")
	ggMDSPlot	<- ggplot( mdsCpmPlotData, aes( x = x, y = y, color = dataset))+geom_point()

	ggsave(filename = MDSPlotFile, device = 'png', dpi = 300)
}
