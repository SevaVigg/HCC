makeCpmMDSPlot <- function(cpmMatrix, plotName = "DGEList",  sampleTable){
	library(tidyverse)
	library(edgeR)


	wd		<- getwd()
	plotDirName	<- file.path(wd, "Plot")
	plotDir		<- dir.create(plotDirName, showWarnings = FALSE)
	MDSPlotFile	<- file.path(plotDirName, paste0("MDSPLot_",plotName, ".png"))
	
	pMDS	 	<- plotMDS( cpmMatrix)
	pMDSData 	<- data.frame( pMDS$x, pMDS$y, sampleTable$group, sampleTable$type)
	colnames(pMDSData) <- c("x", "y", "group", "type")
	ggMDSPlot	<- ggplot( pMDSData, aes( x = x, y = y, color = type, shape = group))+geom_point(size = 0.2) + ggtitle( plotName)

	ggsave(filename = MDSPlotFile, device = 'png', dpi = 300)
}
