makeGLM <- function(DGEListObject, refName = "DGEList"){

library(edgeR)

	wd		<- getwd()
	plotDirName	<- file.path(wd, "Plot")
	plotDir		<- dir.create(plotDirName, showWarnings = FALSE)
	
	Design		<- model.matrix(~relevel(DGEListObject$samples$group, "Original"))
	
	DGEObj		<- estimateGLMCommonDisp( DGEListObj, Design)
	DGEObj		<- estimateGLMTrendedDisp( DGEObj, Design)
	DGEObj		<- estimateGLMTagwiseDisp( DGEObj, Design)

	BCVPlotFile	<- file.path(plotDirName, paste0("BCVPLot_",refName, ".png"))
	
	png( file.path( BCVPlotFile))	
		plotBCV( DGEObj )
	dev.off()

	DGEfit    	<-  glmFit( DGEObj, Design)
	DGE_CellLines	<- glmLRT( DGEfit, coef = 2)
	DGE_TCGA	<- glmLRT( DGEfit, coef = 3) 

}
