#!/usr/bin/env bash

#SBATCH --time=0-06:00:00
#SBATCH --nodes=1
#SBATCH -o gTExQuery-%j.out
#SBATCH -e gTExQuery-%j.err
#SBATCH --mail-user=scott.frodsham@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

geneListFile=$1 # full path of list of genes, one gene per line
#baseListFile=$(basename $geneListFile)
#geneListFileName=${baseListFile%%.*}
#
#scratchDir=$scr/filterByGene/$geneListFileName
#vcfGene=$scratchDir/${vcfName}_$geneListFileName.hg19_multianno.vcf.gz

# read gene list file into variable
readarray -t geneList < $geneListFile
#
for gene in ${geneList[@]}; do 
    echo $gene
    for f in ./GTEx_Analysis_v8_eQTL/*egenes*gz; do
        #echo $gene
        baseFile=$(basename $f)
        tissue=${baseFile%%.*}
        #echo $tissue
        zcat $f | awk -v gen=$gene '$2 == gen { print $1,$2 }' >> geneSymbolID_keyDupEFHD1.txt
        zcat $f | awk -v gen=$gene -v var=$tissue '$2 == gen { print $0,var }' >> ${gene}_egeneEFHD1.txt
        #zcat $f | awk '{ print $1 }' >> allGeneIDsEFHD1.txt
    done
    cat ${gene}_egeneEFHD1.txt | cut -f 1 | sort -u >> uniqGeneIDsEFHD1.txt
done

cat geneSymbolID_keyDupEFHD1.txt | sort -u > geneSymbolID_keyEFHD1.txt # && rm geneSymbolID_keyDupEFHD1.txt

readarray -t geneIDList < uniqGeneIDsEFHD1.txt

for geneID in ${geneIDList[@]}; do 
    for f in ./GTEx_Analysis_v8_eQTL/*signif*gz; do
        baseFile=$(basename $f)
        tissue=${baseFile%%.*}
        zcat $f | awk -v genid=$geneID -v tis=$tissue '$2 == genid { print $0,tis }' >> ${geneID}_SNPsEFHD1.txt
    done
done

cat dkdSigSNPs/*_SNPs17.txt ceramideSigSNPs/*_SNPsCeramide.txt | sort -k 2 -u > sortedEFHD1Genes_GTEx.txt
cat ceramideSigSNPs/* | sort -k 2 -u > sortedEFHD1Genes_GTEx.txt

join -1 2 -2 1 sortedEFHD1Genes_GTEx.txt geneSymbolID_keyEFHD1.txt > EFHD1Genes_GTEx.txt

awk 'BEGIN {OFS="\t"} {print $1,$14,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13}' EFHD1Genes_GTEx.txt > sortedEFHD1Genes_GTEx.txt

rm EFHD1Genes_GTEx.txt
