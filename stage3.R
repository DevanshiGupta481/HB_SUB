#Install DeSeq2 via bioconductor on your RStudio
install.packages("BiocManager")
BiocManager::install("DESeq2")
install.packages("forcats")
install.packages("stringr")
install.packages("ggrepel")
install.packages("readr")
install.packages("tidyr")
install.packages("survminer")
BiocManager::install("GEOquery")
BiocManager::install("limma")

# import data in Rstudio(after Download the dataset from gene expression omnibus using bash terminal)
library(GEOquery)
my_id <- "GSE50499"
gse <- getGEO(my_id)

#perform differential expression analysis
## exprs get the expression levels as a data frame and get the distribution
summary(exprs(gse))
exprs(gse) <- log2(exprs(gse))
pData(gse) ## print the sample information
fData(gse) ## print the gene annotation
exprs(gse) ## print the expression data
library(dplyr)
sampleInfo <- pData(gse)
sampleInfo
## source_name_ch1 and characteristics_ch1.1 seem to contain factors we might need for the analysis. Let's pick just those columns

sampleInfo <- select(sampleInfo, source_name_ch1,characteristics_ch1.1)

## Optionally, rename to more convenient column names
sampleInfo <- rename(sampleInfo,group = source_name_ch1, patient=characteristics_ch1.1)
## Print the rownames of the sample information and check it matches the correlation matrix
rownames(sampleInfo)
colnames(corMatrix)
## force the rownames to match the columns

rownames(sampleInfo) <- colnames(corMatrix)
pheatmap(corMatrix,
         annotation_col=sampleInfo) 
features <- fData(gse)
View(features)
### Look at the features data frame and decide the names of the columns you want to keep
features <- select(features,Symbol,Entrez_Gene_ID,Chromosome,Cytoband)
full_output <- cbind(features,exprs(gse))
write_csv(full_output, path="gse_full_output.csv")
#differential expression
library(limma)
design <- model.matrix(~0+sampleInfo$group)
design
summary(exprs(gse))

## calculate median expression level
cutoff <- median(exprs(gse))

## TRUE or FALSE for whether each gene is "expressed" in each sample
is_expressed <- exprs(gse) > cutoff

## Identify genes expressed in more than 2 samples

keep <- rowSums(is_expressed) > 2

## check how many genes are removed / retained.
table(keep)

## subset to just those expressed genes
gse <- gse[keep,]
fit <- lmFit(exprs(gse), design)
head(fit$coefficients)
contrasts <- makeContrasts(Tumour - Normal, levels=design)

## can define multiple contrasts
## e.g. makeContrasts(Group1 - Group2, Group2 - Group3,....levels=design)

fit2 <- contrasts.fit(fit, contrasts)
fit2 <- eBayes(fit2)
topTable(fit2)
topTable(fit2, coef=1)
### to see the results of the second contrast (if it exists)
## topTable(fit2, coef=2)
decideTests(fit2)
table(decideTests(fit2))
full_results <- topTable(fit2, number=Inf)
full_results <- tibble::rownames_to_column(full_results,"ID")

#plotting volcano plot
library(ggplot2)
ggplot(full_results,aes(x = logFC, y=B)) + geom_point()
## change according to your needs
p_cutoff <- 0.05
fc_cutoff <- 1

full_results %>% 
  mutate(Significant = adj.P.Val < p_cutoff, abs(logFC) > fc_cutoff ) %>% 
  ggplot(aes(x = logFC, y = B, col=Significant)) + geom_point()

