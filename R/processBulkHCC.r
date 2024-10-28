require("useful")
require("edgeR")

wd <- getwd()
PlotDir <- dir.create(file.path(wd, "Plot") , showWarnings = FALSE)
DataDir <- dir.create(file.path(wd, "Data") , showWarnings = FALSE)

load("Data/Dec_data.RData")

hccPCA <- princomp(Total.counts)


