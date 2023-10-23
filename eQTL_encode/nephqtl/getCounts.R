library(tidyverse)

cera <- read_tsv("sorted_ceramide_nephQTL.txt", col_types = "ciccciddddcc")
dkd <- read_tsv("sorted_bigDKD_nephQTL.txt", col_types = "ciccciddddcc")

cera_ccre <- read_tsv("ceraNephQTL_cCRE.txt", col_names = c("chr", "startPos", "endPos", "id", "p", "slope", "gene_symbol", "tissue"))
dkd_ccre <- read_tsv("bigDKDNephQTL_cCRE.txt", col_names = c("chr", "startPos", "endPos", "id", "p", "slope", "gene_symbol", "tissue"))

head(cera)
head(cera_ccre)
head(dkd)
head(dkd_ccre)

cera_sum <- cera %>% group_by(GENE_SYMBOL) %>% summarize(n = n())
cera_ccre_sum <- cera_ccre %>% group_by(gene_symbol) %>% summarize(n = n())
dkd_sum <- dkd %>% group_by(GENE_SYMBOL) %>% summarize(n = n())
dkd_ccre_sum <- dkd_ccre %>% group_by(gene_symbol) %>% summarize(n = n())

write_tsv(cera_sum, "ceraNephQTL_counts.tsv")
write_tsv(cera_ccre_sum, "ceraNephQTL_cCRE_counts.tsv")
write_tsv(dkd_sum, "dkdNephQTL_counts.tsv")
write_tsv(dkd_ccre_sum, "dkdNephQTL_cCRE_counts.tsv")
