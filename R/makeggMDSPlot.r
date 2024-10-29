makeggMDSPlot <- function(DGEListObject, plotName = "DGEList"){
	library(tidyverse)
	library(edgeR)


	wd		<- getwd()
	plotDirName	<- file.path(wd, "Plot")
	plotDir		<- dir.create(plotDirName, showWarnings = FALSE)
	MDSPlotFile	<- file.path(plotDirName, paste0("MDSPLot_",plotName, ".png"))
	
	pMDS	 	<- plotMDS(cpm(DGEListObject))
	pMDSData 	<- data.frame( pMDS$x, pMDS$y, DGEListObject$samples$group)
	colnames(pMDSData) <- c("x", "y", "dataset")
	ggMDSPlot	<- ggplot( pMDSData, aes( x = x, y = y, color = dataset))+geom_point() + ggtitle( plotName)

	ggsave(filename = MDSPlotFile, device = 'png', dpi = 300)
}
