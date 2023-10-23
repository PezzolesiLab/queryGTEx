library(tidyverse)

cera <- read_tsv("sortedCeramideGenes_GTEx.txt")
dkd <- read_tsv("sortedBigDKDGenes_GTEx.txt")

cera_ccre <- read_tsv("ceraGTEx_cCRE.txt", col_names = c("chr", "startPos", "endPos", "id", "p", "slope", "gene_symbol", "tissue"))
dkd_ccre <- read_tsv("bigDKDGTEx_cCRE.txt", col_names = c("chr", "startPos", "endPos", "id", "p", "slope", "gene_symbol", "tissue"))

head(cera)
head(cera_ccre)
head(dkd)
head(dkd_ccre)

cera_sum <- cera %>% group_by(gene_symbol) %>% summarize(n = n())
cera_ccre_sum <- cera_ccre %>% group_by(gene_symbol) %>% summarize(n = n())
dkd_sum <- dkd %>% group_by(gene_symbol) %>% summarize(n = n())
dkd_ccre_sum <- dkd_ccre %>% group_by(gene_symbol) %>% summarize(n = n())

write_tsv(cera_sum, "ceraGTEx_counts.tsv")
write_tsv(cera_ccre_sum, "ceraGTEx_cCRE_counts.tsv")
write_tsv(dkd_sum, "dkdGTEx_counts.tsv")
write_tsv(dkd_ccre_sum, "dkdGTEx_cCRE_counts.tsv")
