batchGLM <- function(DGEObj, plotName = "DGEObj"){

library(edgeR)

	wd		<- getwd()
	plotDirName	<- file.path(wd, "Plot")
	plotDir		<- dir.create(plotDirName, showWarnings = FALSE)

	DGEObj		<- calcNormFactors( DGEObj, method = "TMM")
	
	Design		<- model.matrix(~DGEObj$samples$group)
	
	DGEObj		<- estimateGLMCommonDisp( DGEObj, Design)
	DGEObj		<- estimateGLMTrendedDisp( DGEObj, Design)
	DGEObj		<- estimateGLMTagwiseDisp( DGEObj, Design)

	BCVPlotFile	<- file.path(plotDirName, paste0("BCVPLot_",plotName, ".png"))
	
	png( file.path( BCVPlotFile))	
		plotBCV( DGEObj )
	dev.off()

	return(DGEObj)	
}
