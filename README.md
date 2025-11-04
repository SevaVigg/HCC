# HCC DDF project

This is branch with HCC DDF project notebooks and other code.

## Data used

- GSE156625 sc-RNAseq .bam files from patients and 1 heathy individual
- TCGA-LIHC bulk RNA-seq data
- Cell lines data from GEO (all sources described in cell_lines_meta.csv)
- addiional bulk RNA-seq data

## Workflow

Workflow consists of next parts:

- sc-RNAseq
- bulk RNAseq
- Decomposition & Clustering
- Clusters description

### sc-RNAseq workflow

Sc-RNAseq .bam files were transformed into raw read .fastq
files with 10x Genomics bamtofastq program. Raw read files 
were than aligned on Gencode v36 human genome and quantified 
with [nf-core/scrnaseq](https://nf-co.re/scrnaseq)
pipeline with cellranger 8.0.0.

Following workflow is descriped in HCC_scRNAseq.ipynb

### bulk RNAseq workflow

Bulk RNAseq data raw reads were preprocessed with [nf-core/rnaseq](https://nf-co.re/rnaseq)
pipeline. Reads were aligned with STAR aligner on Gencode v36 human
genome assembly and quantified with salmon. Resulting count matrices were
combined with TCGA cohort count matrices for further analysis.

Further analysis is descriped in Bulk_RNAseq_pre.ipynb

# HCC DDF project

This is repo with HCC DDF project notebooks and other code.

## Data used

- GSE156625 sc-RNAseq .bam files from patients and 1 heathy individual
- TCGA-LIHC bulk RNA-seq data
- Cell lines data from GEO (all sources described in cell_lines_meta.csv)
- addiional bulk RNA-seq data

## Workflow

Workflow consists of next parts:

- sc-RNAseq
- bulk RNAseq
- Decomposition & Clustering
- Clusters description

### sc-RNAseq workflow

Sc-RNAseq .bam files were transformed into raw read .fastq
files with 10x Genomics bamtofastq program. Raw read files 
were than aligned on Gencode v36 human genome and quantified 
with [nf-core/scrnaseq](https://nf-co.re/scrnaseq)
pipeline with cellranger 8.0.0.

Following workflow is descriped in [HCC_scRNAseq.ipynb](https://drive.google.com/drive/folders/1719g9BA9ZObuWx1tZkLibjNVSjR4fDo5?usp=sharing)

### Decomposition and clustering

Decomposition was performed with CIBERSORTx with files obtained on
previous steps with following hyperparameters:
```
{
--perm 500 --fraction 0.5 --rmbatchSmode FALSE --single_cell TRUE
}
```
Further analysis is descriped in RNAseq_clustering.ipynb

### Clusters description

To describe clusters we have found DE genes, performed enrichment both of gene list and RNAseq.
DE analysis was performed in DE_analysis.ipynb
Enrichment was performed in Enrichment.ipynb
