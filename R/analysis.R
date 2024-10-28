#comparison with ncbi results
#X1 <- read.table(file='Downloads/GSE104766_counts_mapped2GR38.txt', sep='\t', header=TRUE)
#X1 <- data.frame(gene=X1[,1],Hep=X1$HepG2)
#ind <- sapply(1:length(X1[,1]),function(x) X1[x,1] %in% counts[,1])
#X1 <- X1[ind,]
#X1 <- X1[order(X1[,1]),]
#plot(1:19847,X1[,2]-counts[,2])
##
#
#
#C1 <- read.delim(file='SRR6154700.1.counts',head=FALSE)
#C2 <- read.delim(file='SRR6154700.2.counts',head=FALSE)
#D1 <- read.delim(file='SRR4421958.1.counts',head=FALSE)
#D2 <- read.delim(file='SRR4421958.2.counts',head=FALSE)
#S1 <- read.delim(file='SRR4421959.1.counts',head=FALSE)
#S2 <- read.delim(file='SRR4421959.2.counts',head=FALSE)
#M1 <- read.delim(file='SRR3033309.1.counts',head=FALSE)
#M2 <- read.delim(file='SRR3033309.2.counts',head=FALSE)
#N1 <- read.delim(file='SRR3033310.1.counts',head=FALSE)
#N2 <- read.delim(file='SRR3033310.2.counts',head=FALSE)
#O1 <- read.delim(file='SRR6461139.1.counts',head=FALSE)
#O2 <- read.delim(file='SRR6461139.2.counts',head=FALSE)
#P1 <- read.delim(file='SRR6461140.1.counts',head=FALSE)
#P2 <- read.delim(file='SRR6461140.2.counts',head=FALSE)
#R1 <- read.delim(file='SRR6461141.1.counts',head=FALSE)
#R2 <- read.delim(file='SRR6461141.2.counts',head=FALSE)
#F1 <- read.delim(file='SRR6501993.1.counts',head=FALSE)
#F2 <- read.delim(file='SRR6501993.2.counts',head=FALSE)
#T1 <- read.delim(file='SRR6501994.1.counts',head=FALSE)
#T2 <- read.delim(file='SRR6501994.2.counts',head=FALSE)
#U1 <- read.delim(file='SRR6501995.1.counts',head=FALSE)
#U2 <- read.delim(file='SRR6501995.2.counts',head=FALSE)
#Q <- read.delim(file='Desktop/Counts/SRR575526.htseq.counts',head=FALSE)
#A <- read.delim(file='Desktop/Counts/SRR1049392.htseq.counts',head=FALSE)
#Z <- read.delim(file='Desktop/Counts/SRR1107930.htseq.counts',head=FALSE)
#
#
#hepg2 <- data.frame(Gene_ID=C1[1:58395,1],'SRR6154700' = C1[1:58395,2]+C2[1:58395,2], 'SRR4421958'=D1[1:58395,2]+D2[1:58395,2],'SRR4421959'=S1[1:58395,2]+S2[1:58395,2],'SRR3033309'=M1[1:58395,2]+M2[1:58395,2],'SRR3033310'=N1[1:58395,2]+N2[1:58395,2],'SRR6461139'=O1[1:58395,2]+O2[1:58395,2], 'SRR6461140'= P1[1:58395,2]+P2[1:58395,2], 'SRR6461141' = R1[1:58395,2]+R2[1:58395,2], 'SRR6501993'=F1[1:58395,2]+F2[1:58395,2], 'SRR6501994' = T1[1:58395,2]+T2[1:58395,2],'SRR6501995' = U1[1:58395,2]+U2[1:58395,2], 'SRR575526'= Q[,2],'SRR1049392'=A[,2],'SRR1107930'=Z[,2])
#rm(A,Z,Q,N1,N2,M1,M2,S1,S2,D1,D2,C2,C1,O1,O2,P1,P2,R1,R2,F1,F2,T1,T2,U1,U2)
#image(cor(hepg2[,2:15]))
#
#
#data <- read.table(file='Downloads/Cancer_ONCO2_Final_Data.txt', sep='\t', header=TRUE)
#
#
#pech_samples <- grep('*pech*',colnames(data))
#
#liver <- data[,c(1,pech_samples)]
#colnames(liver) <- gsub(colnames(liver), pattern="_rep_[0-9]", replacement="")
#colnames(liver) <- gsub(colnames(liver), pattern="_em", replacement="")
#liver <- liver[, !duplicated(colnames(liver))]
#
#dist_data <- dist(t(data[,3:190]), method = "euclidean")
#clust1 <- hclust(dist_data)
#plot(clust1)
#
#
#op_samples <- grep('*op*',colnames(data))
#
#cancer <- data[,c(1,op_samples)]
#colnames(cancer) <- gsub(colnames(cancer), pattern="_rep_[0-9]", replacement="")
#colnames(cancer) <- gsub(colnames(cancer), pattern="opb", replacement="op")
#cancer <- cancer[, !duplicated(colnames(cancer))]
#
#
#
#index <- sapply(1:length(hepg2[,1]),function(x) hepg2[x,1] %in% liver[,1])
#hepg2 <- hepg2[index,]
#index_rev <- sapply(1:length(liver[,1]),function(x) liver[x,1] %in% hepg2[,1])
#
#liver <- liver[index_rev,]
#cancer <- cancer[index_rev,]
#
#table <- cbind(hepg2[,2:15],liver[,2:48],cancer[,2:48])
table <- read.table(file='expr_table.tsv', sep='\t', header=TRUE)


rownames(table) <- table[,1]
table <- table[,-1]

pca <-prcomp(t(table[,]))
pc <- round(pca$sdev^2/sum(pca$sdev^2)*100,1)
barplot(pc, xlab='PC number', ylab='% of variation PC accounts for')

pca.data <- data.frame(Type=c(rep('HepG2',14),rep('Liver',47),rep('Hepatocarcinoma',47)), 
                       PC1=pca$x[,1], PC2=pca$x[,2], PC3=pca$x[,3])
library("ggplot2")
ggplot(pca.data, aes(x=PC1, y=PC2)) +  
  geom_point(aes(col=Type))+
  labs(x='PC1(73.6%)', y='PC2(13.1%)', col='Type') + 
  theme(legend.position = 'bottom')

#heatmap( as.matrix(table[,2:102]))

#export of table
write.table(table, file='expr_table_New.tsv', quote=FALSE, sep='\t')

#DGEList data class
library(edgeR)
group_1 <- c(rep('Liver',47),rep('Hepatocarcinoma',47))
DGE_1 <- DGEList(counts=table[,15:108], group=group_1)
DGE_1$samples$group <- relevel(DGE_1$samples$group, ref='Liver')

summary(DGE_1)

#gene annotations
gene_id <- rownames(DGE_1)

library("biomaRt", lib.loc="/usr/lib/R/site-library")
library(biomaRt)
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
bm <- getBM(attributes = c('ensembl_gene_id',"entrezgene_id", 'hgnc_symbol', 'description'),
            filter='ensembl_gene_id',
            value=gsub(gene_id, pattern="\\.[0-9]+$", replacement=""),
            mart = mart)



#duplicated genes in annotation
dupl_entr <- unique(bm$ensembl_gene_id[which(duplicated(bm$ensembl_gene_id))])
dupl_number <- c(which(is.element(bm$ensembl_gene_id,dupl_entr)))
bm$description[dupl_number] <- paste('(check version)',bm$description[dupl_number],sep='')
ann <- match(gsub(gene_id, pattern="\\.[0-9]+$", replacement=""),bm[,1])
bm <- bm[ann,]

DGE_1$genes <- cbind(bm$entrezgene,bm$hgnc_symbol, bm$description)
colnames(DGE_1$genes) <- c("entrezgene",'hgnc_symbol','description')            

            


#filtering
table(rowSums(DGE_1$counts==0)==94)

keep <- rowSums(cpm(DGE_1)>1)>=10 
DGE_1 <- DGE_1[keep, , keep.lib.sizes=FALSE]
#filtered_edgeR <- rownames(DGE)

#normalization
DGE_1 <- calcNormFactors(DGE_1, method='TMM')
DGE_1$samples

#dispersion estimation and test foe DE genes
design <- model.matrix(~group_1)
DGE_1 <- estimateDisp(DGE_1,design)

DE_1_res <- exactTest(DGE_1)
topTags(DE_1_res, n=10)


plotSmear(DGE_1, de.tags = rownames(topTags(DE_1_res, n=3000)))

write.table(topTags(DE_1_res,n=nrow(DGE_1)), file='liver_Hepatocarcinoma.tsv', sep='\t')

D_1 <- topTags(DE_1_res,n=nrow(DE_1_res))$table


group_2 <- c(rep('Liver',47),rep('HepG2',14))
DGE_2 <- DGEList(counts=table[,c(15:61,1:14)], group=group_2)
summary(DGE_2)
DGE_2$samples$group <- relevel(DGE_2$samples$group, ref='Liver')
DGE_2$genes <- cbind(bm$entrezgene,bm$hgnc_symbol, bm$description)
colnames(DGE_2$genes) <- c("entrezgene",'hgnc_symbol','description')            

#filtering
table(rowSums(DGE_2$counts==0)==61)
keep <- rowSums(cpm(DGE_2)>1) >= 10
DGE_2 <- DGE_2[keep, , keep.lib.sizes=FALSE]
#filtered_edgeR <- rownames(DGE)

#normalization
DGE_2 <- calcNormFactors(DGE_2, method='TMM')

DGE_2$samples

#dispersion estimation and test foe DE genes
design_2 <- model.matrix(~group_2)
DGE_2 <- estimateDisp(DGE_2,design_2)
DE_2_res <- exactTest(DGE_2)
DGE_2$samples$group

DE_2_ex_ann <- goana.DGEExact(DE_2_res,geneid = DE_2_res$genes[,1],FDR=0.01)
write.table(DE_2_ex_ann, file='goaanot_liver_HepG2.tsv', sep='\t')
topGO(DE_2_ex_ann, sort="down",n=40)

keg <- kegga.DGEExact(DE_2_res,geneid = DE_2_res$genes[,1], FDR=0.01, species="Hs")
topKEGG(keg, sort="up",50)
topKEGG(keg, sort="down",50)
write.table(topKEGG(keg, sort="up",50), file='KEGG_UP_liver_HepG2.tsv', sep='\t')
write.table(topKEGG(keg, sort="down",50), file='KEGG_DOWN_liver_HepG2.tsv', sep='\t')

topTags(DE_2_res, n=10)

plotSmear(DGE_2, de.tags = rownames(topTags(DE_2_res, n=7800)))


D_2 <- topTags(DE_2_res,n=nrow(DE_2_res))$table
top_up <- D_2[order(D_2[,3]),][1:500,]

max(top_up$FDR)
goan_2_up <- goana(as.vector(top_up$hgnc_symbol),species='Hs')


top_down <- D_2[order(D_2[,3],decreasing = TRUE),][1:500,]

max(top_down$FDR)
goan_2_down <- goana(as.vector(top_down$hgnc_symbol),species='Hs')

goan_2_down_sorted <- goan_2_down[order(goan_2_down[,3],decreasing = TRUE),]


write.table(topTags(DE_2_res,n=nrow(DGE_2)), file='liver_HepG2.tsv', sep='\t')

DE_2 <- topTags(DE_2_res,n=nrow(DGE_2))

group_3 <- c(rep('Hepatocarcinoma',47),rep('HepG2',14))
DGE_3 <- DGEList(counts=table[,c(62:108,1:14)], group=group_3)
summary(DGE_3)
DGE_3$samples$group <- relevel(DGE_3$samples$group, ref='Hepatocarcinoma')
DGE_3$genes <- cbind(bm$entrezgene, bm$hgnc_symbol, bm$description)
colnames(DGE_3$genes) <- c('entrezgene','hgnc_symbol','description')            

#filtering
table(rowSums(DGE_3$counts==0)==61)
keep <- rowSums(cpm(DGE_3)>1) >= 10
DGE_3 <- DGE_3[keep, , keep.lib.sizes=FALSE]
#filtered_edgeR <- rownames(DGE)

#normalization
DGE_3 <- calcNormFactors(DGE_3, method='TMM')
DGE_3$samples

#dispersion estimation and test foe DE genes
design_3 <- model.matrix(~group_3)
DGE_3 <- estimateDisp(DGE_3,design_3)
DE_3_res <- exactTest(DGE_3)
topTags(DE_3_res, n=10)

keg_3 <- kegga.DGEExact(DE_3_res,geneid = DE_3_res$genes[,1], FDR=0.01, species="Hs")
topKEGG(keg_3, sort="up",50)
topKEGG(keg_3, sort="down",50)
write.table(topKEGG(keg_3, sort="up",50), file='KEGG_UP_hepatocarc_HepG2.tsv', sep='\t')
write.table(topKEGG(keg_3, sort="down",50), file='KEGG_DOWN_hepatocarc_HepG2.tsv', sep='\t')




write.table(topTags(DE_3_res,n=nrow(DGE_3)), file='Hepatocarcinoma_HepG2.tsv', sep='\t')

plotSmear(DGE_3, de.tags = rownames(topTags(DE_3_res, n=6100)$table))

D_3 <- topTags(DE_3_res,n=nrow(DE_3_res))$table
