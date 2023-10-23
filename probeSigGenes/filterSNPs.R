library(tidyverse)

SigSNPS <- read_tsv("CD160_Sig_Protein.tsv")
GTEx <- read_tsv("sortedCeramideGenes_GTEx.txt", col_names = FALSE)

SigSNPS <- SigSNPS %>%
  mutate(X3 = paste0("chr",Chr,"_",Pos,"_",Ref,"_",Alt,"_b38"))

joined <- left_join(SigSNPS, GTEx)
