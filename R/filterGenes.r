filterGenes <- function( DGEObj){

#This scripts filters non-informative and corrupted genes from a DGEObject
	
#1. Remove mitochondrial genes

	mitoGen		<- grep("^MT-", rownames(DGEObj), value = TRUE )
	DGEObj 		<- DGEObj[ setdiff(rownames( DGEObj), mitoGen) , ]

#2. Remove genes with zero counts in TCGA (due to pecularities in 3' capture

	zeroGenesI 	<- which( rowSums( DGEObj[ , DGEObj$samples$group == 'TCGA']$counts) == 0)
	DGEObj		<- DGEObj[ setdiff( 1:dim( DGEObj)[1] , zeroGenesI) , ]

#3. Remove genes with small log2(meanCPM) < 1

	smallCpmGenesI	<- which( apply(cpm(DGEObj, log = T), 1, mean) <= 0)
	DGEObj		<- DGEObj[ setdiff( 1:dim( DGEObj)[1], smallCpmGenesI) , ]

#4. Reset library sizes

	DGEObj$samples$lib.size <- colSums(DGEObj$counts)

#5 Remove small libraries

	DGEObj		<- DGEObj[  , DGEObj$samples$"lib.size" >= 5000000 ] 

return(DGEObj)

}
