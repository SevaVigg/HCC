findGenesGLM <- function(DGEObj, Design, contrastVector = contrastVector <- c( 1, 1, 1, -1, 0, -1, -1, 0)){

#contrast corresponds to comparison of tumor with :cell lines

	fit 	<- glmFit( DGEObj, Design)
	lrt	<- glmLRT( fit, contrast = contrastVector)
	tops	<- topTags( lrt, nrow( lrt) )
	
	tops %>% filter( logFC < -2 & FDR < 0.1 )
	
}
