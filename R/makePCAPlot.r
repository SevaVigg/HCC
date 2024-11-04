makePCAPlot <- function(cpmMatrix, plotName = "DGEList",  components = c(1:2), annotateVector){
	library(tidyverse)
	library(edgeR)


	wd		<- getwd()
	plotDirName	<- file.path(wd, "Plot")
	plotDir		<- dir.create(plotDirName, showWarnings = FALSE)
	PCAPlotFile	<- file.path(plotDirName, paste0("PCA_",plotName, ".png"))
	pcaData		<- prcomp( cpmMatrix)
	pcaPlotData 	<- data.frame( x = pcaData$rotation[ , components[1]], y = pcaData$rotation[ , components[2]], sample = annotateVector)	
	colnames(pcaPlotData) <- c( paste0("PC", components[1]), paste0( "PC", components[2]), "dataset")
	comp1		<- paste0("PC", components[1]) 
	comp2		<- paste0("PC", components[2]) 
	ggPCAPlot	<- ggplot( pcaPlotData, aes( x = get(comp1), y = get(comp2), color = dataset))+geom_point() + ggtitle( plotName)

	ggsave(filename = PCAPlotFile, device = 'png', dpi = 300)
}
