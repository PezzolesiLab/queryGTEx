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
f=/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources/NephQTL/download_res/eQTLs_chrAll_50_peers_cis1000kb_Tube.NephQTL2.txt

#iterate through every gene in list
for gene in ${geneList[@]}; do 
    echo $gene
    #probe NephQTL for every instance of the gene
    zcat $f | awk -v gen=$gene '$1 == gen' >> nephQTL_query.txt
done

