findZeroGenes <- function( DGEListObject, group, threshold = 0.5){
	
	groupSamples 	<- DGEListObject[ , DGEListObject$samples$group == group]
	zeroGenes	<- names( which( rowSums( groupSamples$counts) <= threshold))

}
