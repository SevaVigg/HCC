require("useful")
require("tidyverse")
require("edgeR")

wd <- getwd()
PlotDir <- dir.create(file.path(wd, "Plot") , showWarnings = FALSE)
DataDir <- dir.create(file.path(wd, "Data") , showWarnings = FALSE)

load("Data/Dec_data.RData")

Total.counts 	%>% rownames_to_column(var = "gene") %>% 
			pivot_longer( cols = -gene, names_to = "original_column_name", values_to = "expression") -> 
			longTotalCounts

longTotalCounts %>% filter(str_detect(original_column_name, "TCGA")) %>%
			separate_wider_delim(cols = original_column_name, delim = ".", 
			names = c(	"Database", 
					"Tissue sourse", 
					"Patient", 
					"Sample type and vial", 
					"Portion and analyte", 
					"Plate", 
					"Center"), too_few = "align_start", too_many = "merge") -> longTotalCount_TCGA


longTotalCounts %>% filter(str_detect(original_column_name, "Sample")) %>%
			separate_wider_delim(cols = original_column_name, delim = "_", 
			names = c(	"Database", 
					"Patient_TissueSource_Replicate"),
						   too_few = "align_start", too_many = "merge") -> longTotalCount_Sample



longTotalCount_Sample %>% filter( str_detect( cols = Patient_TissueSource_Replicate, "pech")) %>%
				

#hccPCA <- princomp(Total.counts)


