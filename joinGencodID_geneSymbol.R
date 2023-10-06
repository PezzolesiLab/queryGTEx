library(qqman)
library(biomaRt)
library(tidyverse)

#args <- commandArgs(trailingOnly=TRUE)
#
#if(length(args) != 3) {
#    stop("Needs three arguments: the filtered SNPTEST file, the outlier snps, and the trait name", call.=FALSE)
#}
#
#print("args")
#snptestResultsFile <- args[1]
#snpsFromOutliersFile <- args[2]
#trait <- args[3]

print("read file")
ceramideGene_GencodeID <- read_tsv("./geneSymbolId_keyDkd.txt", col_names = c("gencode_id", "gene_symbol"))
#snpsGene <- read_tsv("./ceramideGenes_allSNPs.txt")
snpsGene <- read_tsv("./sortedBigDKDGenes_GTEX.txt")

print(head(ceramideGene_GencodeID))
print(head(snpsGene))

snps_gencode <- inner_join(ceramideGene_GencodeID, snpsGene, by = c("gencode_id"))
print(head(snps_gencode))

#write_tsv(snps_gencode, "./ceramidesGenes_allSNPs_gencodeID.txt") 
write_tsv(snps_gencode, "./bigDKDGenes_GTEx.txt") 

# All below is something I was trying to get working that didn't pan out, so just ignore

#print("rename cols")
##names(snptestResults)[[24]] <- "SNP"
#names(snptestResults)[[3]] <- "CHR"
#snptestResults$CHR[snptestResults$CHR == "0X"] <- 23
#snptestResults$CHR[snptestResults$CHR == "01"] <- 1
#snptestResults$CHR[snptestResults$CHR == "02"] <- 2
#snptestResults$CHR[snptestResults$CHR == "03"] <- 3
#snptestResults$CHR[snptestResults$CHR == "04"] <- 4
#snptestResults$CHR[snptestResults$CHR == "05"] <- 5
#snptestResults$CHR[snptestResults$CHR == "06"] <- 6
#snptestResults$CHR[snptestResults$CHR == "07"] <- 7
#snptestResults$CHR[snptestResults$CHR == "08"] <- 8
#snptestResults$CHR[snptestResults$CHR == "09"] <- 9
#snptestResults$CHR <- as.numeric(snptestResults$CHR)
#names(snptestResults)[[4]] <- "BP"
#snptestResults$BP <- as.numeric(snptestResults$BP)
#names(snptestResults)[[21]] <- "P"
#snptestResults <- snptestResults %>% mutate(SNP = paste(CHR, BP, alleleA, alleleB, sep = ":"))
#snptestResults <- snptestResults %>% mutate(SNPloc = paste(CHR, BP, sep = ":"))
##print(snptestResults$SNP)
#
#print("find snps of interest")
##snpsOfInterest <- inner_join(snptestResults, snpsFromOutliers, by = c("SNPloc" = "SNP")) %>% select(SNP) %>% pull()
##snpsOfInterest <- inner_join(snptestResults, snpsFromOutliers, by = c("SNP" = "SNPloc")) %>% filter(P < 0.001) %>% select(SNP) %>% pull()
#snpsOfInterest <- left_join(snpsFromOutliers, snptestResults, by = c("SNP" = "SNPloc")) %>% filter(P < 0.001) %>% select(SNP) %>% pull()
#print(snpsFromOutliers)
#print(snptestResults$SNP)
#print(snptestResults$SNPloc)
#print("of interest")
#print(snpsOfInterest)
#
#grch38  <- useMart("ensembl",dataset="hsapiens_gene_ensembl")
#miRNA38 <- getBM(attributes=c("ensembl_gene_id","transcript_biotype"),
#                    filters=c("transcript_biotype"),values=list("miRNA",TRUE), mart=grch38)
#
#functionGetBM <- function(chr, pos) {
#    matches <- as_tibble(getBM(c("external_gene_name", "chromosome_name", "start_position", "end_position"), filters=c("chromosome_name", "start", "end", "with_entrezgene"), values = list(chr, pos, pos, TRUE), mart = grch37))
#    matches$CHR <- chr
#    matches$BP <- pos
#    matches$external_gene_name <- as.character(matches$external_gene_name)
#    return(matches)
#}

#print("find sig snps")
#snptestResultsSig <- snptestResults %>% filter(P < 0.001)
#lt1e2 <- FALSE
#if (nrow(snptestResultsSig) == 0) {
#    snptestResultsSig <- snptestResults %>% filter(P < 0.01)
#    lt1e2 <- TRUE
#}
#print(head(snptestResultsSig))
#
#print("get mart")
#grch37 <- useMart(biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", path="/biomart/martservice", dataset="hsapiens_gene_ensembl")
#
#print("define function")
#functionGetBM <- function(chr, pos) {
#    matches <- as_tibble(getBM(c("external_gene_name", "chromosome_name", "start_position", "end_position"), filters=c("chromosome_name", "start", "end", "with_entrezgene"), values = list(chr, pos, pos, TRUE), mart = grch37))
#    matches$CHR <- chr
#    matches$BP <- pos
#    matches$external_gene_name <- as.character(matches$external_gene_name)
#    return(matches)
#}
#
#print("getBM list")
#listGetBM <- apply(snptestResultsSig[ , c('CHR', 'BP')], 1, function(x) functionGetBM( x[1], x[2]))
#
#print("combine list of dfs")
#dfGetBM <- bind_rows(listGetBM)
#
#print("rename cols")
#names(dfGetBM) <- c("external_gene_name", "chromosome_name", "gene_start_pos", "gene_end_pos", "CHR", "BP")
#dfGetBM$CHR[dfGetBM$CHR == "X"] <- 23
#dfGetBM$CHR <- as.numeric(dfGetBM$CHR)
#dfGetBM$BP <- as.numeric(dfGetBM$BP)
#
#print("add bm info")
#finalSnptestResultsSig <- inner_join(snptestResultsSig, dfGetBM, by = c("CHR", "BP"))
#
#finalSnptestResultsSig <- cbind(snptestResultsSig, dfGetBM[ , c(1,3,4)])
#finalSnptestResultsSig
#
#if (!lt1e2) {
#    write_tsv(finalSnptestResultsSig, paste0("./", trait, "/", trait, "_lt1e-3_model1.tsv"))
#} else {
#    write_tsv(finalSnptestResultsSig, paste0("./", trait, "/", trait, "_lt1e-2_model1.tsv"))
#}

#png(paste0("./", trait, "/", trait, "_qqman_model1_outlierRare.png"), width = 6, height = 6, res = 300, units = 'in')
#manhattan(snptestResults, annotatePval = 0.001, annotateTop = FALSE, highlight = snpsOfInterest, ylim = c(0,9), main = paste0("log10_", trait))
#dev.off()
#
#png(paste0("./", trait, "/", trait, "_qq_model1_outlierRare.png"), width = 6, height = 6, res = 300, units = 'in')
#qq(snptestResults$P, main = paste0("LOG10_", trait))
#dev.off()
