#!/usr/bin/env bash

#SBATCH --time=0-06:00:00
#SBATCH --nodes=1
#SBATCH -o gTExQuery-%j.out
#SBATCH -e gTExQuery-%j.err
#SBATCH --mail-user=devorah.stucki@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

geneListFile=$1 # full path of list of genes, one gene per line

# read gene list file into variable
readarray -t geneList < $geneListFile

#iterate through every gene in list
for gene in ${geneList[@]}; do 
    echo $gene
    #iterate through every tissue type in GTEX resource folder
    for f in /uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources/GTExV8/GTEx_Analysis_v8_eQTL/*egenes*gz; do
        baseFile=$(basename $f)
        tissue=${baseFile%%.*}
        echo $tissue
	#create list of tissues and their corresponding gene IDs
        zcat $f | awk -v gen=$gene '$2 == gen { print $1,$2 }' >> geneSymbolID_keyDupCeramide.txt #this file is just going to overwrite itself every time?
        zcat $f | awk -v gen=$gene -v var=$tissue '$2 == gen { print $0,var }' >> ${gene}_egeneCeramide.txt
        #zcat $f | awk '{ print $1 }' >> allGeneIDsCeramide.txt
    done
    cat ${gene}_egeneCeramide.txt | cut -f 1 | sort -u >> uniqGeneIDsCeramide.txt
done

cat geneSymbolID_keyDupCeramide.txt | sort -u > geneSymbolID_keyCeramide.txt # && rm geneSymbolID_keyDupCeramide.txt

readarray -t geneIDList < uniqGeneIDsCeramide.txt

for geneID in ${geneIDList[@]}; do 
    for f in ./GTEx_Analysis_v8_eQTL/*signif*gz; do
        baseFile=$(basename $f)
        tissue=${baseFile%%.*}
        zcat $f | awk -v genid=$geneID -v tis=$tissue '$2 == genid { print $0,tis }' >> ceramideSigSNPs/${geneID}_SNPsCeramide.txt
    done
done

# (Brady) I think the directories below need to be cleared before a new run. I also added the line above which puts
# the _SNPsCeramide.txt 's in the ceramideSigSNPs directory instead of just in the same directory as the script.
# I also deleted the following files before each run because they were just being appended to:
# *_egeneCeramide.txt, uniqGeneIDsCeramide.txt, and the files mentioned in the above chunk...
cat dkdSigSNPs/*_SNPs17.txt ceramideSigSNPs/*_SNPsCeramide.txt | sort -k 2 -u > sortedCeramideGenes_GTEx.txt
cat ceramideSigSNPs/* | sort -k 2 -u > sortedCeramideGenes_GTEx.txt

join -1 2 -2 1 sortedCeramideGenes_GTEx.txt geneSymbolID_keyCeramide.txt > ceramideGenes_GTEx.txt

#awk 'BEGIN {OFS="\t"} {print $1,$14,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13}' ceramideGenes_GTEx.txt > sortedCeramideGenes_GTEx.txt

#rm ceramideGenes_GTEx.txt
