#!/usr/bin/env bash

#SBATCH --time=1-06:00:00
#SBATCH -o encodeIntersect-%j.out
#SBATCH -e encodeIntersect-%j.err
#SBATCH --mail-user=scott.frodsham@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

ml bedtools

#nephCera="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/kidney_eQTLs/queryNephQTL/geneSet_ceramide/sortedSignif_ceramide_nephQTL_new.txt"
gtexEFHD1="/uufs/chpc.utah.edu/common/home/u0854535/workflows/queryGTEx/sortedEFHD1Gene_GTEx.txt"
#nephDKD="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/kidney_eQTLs/queryNephQTL/geneSet_dkd/sorted_dkd_nephQTL.txt"
#gtexCera="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/ceramide_eQTLs/queryGTEx/sortedCeramideGenes_GTEx.txt"
#gtexDKD="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/ceramide_eQTLs/queryGTEx/sortedDKDGenes_GTEx.txt"
#gtexBigDKD="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/ceramide_eQTLs/queryGTEx/sortedBigDKDGenes_GTEx.txt"
#nephBigDKD="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/kidney_eQTLs/queryNephQTL/geneSet_dkdBig/sortedSignif_bigDKD_nephQTL.txt"

declare -A eqtlMap
eqtlMap[gtexEFHD1]="/uufs/chpc.utah.edu/common/home/u0854535/workflows/queryGTEx/sortedEFHD1Gene_GTEx.txt"
#eqtlMap[nephCera]="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/kidney_eQTLs/queryNephQTL/geneSet_ceramide/sortedSignif_ceramide_nephQTL_new.txt"
#eqtlMap[nephDKD]="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/kidney_eQTLs/queryNephQTL/geneSet_dkd/sorted_dkd_nephQTL.txt"
#eqtlMap[gtexCera]="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/ceramide_eQTLs/queryGTEx/sortedCeramideGenes_GTEx.txt"
#eqtlMap[gtexDKD]="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/ceramide_eQTLs/queryGTEx/sortedDKDGenes_GTEx.txt"
#eqtlMap[gtexBigDKD]="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/ceramide_eQTLs/queryGTEx/sortedBigDKDGenes_GTEx.txt"
#eqtlMap[nephBigDKD]="/uufs/chpc.utah.edu/common/home/u6013142/projects/kathiresan/kidney_eQTLs/queryNephQTL/geneSet_dkdBig/sortedSignif_bigDKD_nephQTL.txt"

# you need to bring in BETA still
for f in ${eqtlMap[@]}; do
    if [[ $f == *"NephQTL"* ]]; then
        #echo $f
        if [[ $f == *"Big"* ]]; then
            #awk 'BEGIN {OFS = "\t"} {gsub(/_/, "\t", $3)} {print $2,$3,$8,$14}' $f | head #awk 'BEGIN{OFS = "\t"} {print $2,$3,$3,$2":"$3"_"$4"/"$5,$6,$7,$1,$8}' - | tail -n +2 | sed 's/b38	//g'  > ~/projects/kathiresan/eQTL_encode/bigDKDNephQTL.bed
            awk 'BEGIN {OFS = "\t"} {print "chr"$1,$2,$2,$3,$7,$10,$11,$12}' $f | tail -n +2 > ~/projects/kathiresan/eQTL_encode/bigDKDNephQTL.bed
        #else if [[ $f == *"dkd"* ]]; then
        #    awk 'BEGIN {OFS = "\t"} {print $1,$2,$2,$3,$10,$11,$12}' $f | tail -n +2 > ~/projects/kathiresan/eQTL_encode/dkdNephQTL.bed
        else
            awk 'BEGIN {OFS = "\t"} {print "chr"$1,$2,$2,$3,$7,$10,$11,$12}' $f | tail -n +2 > ~/projects/kathiresan/eQTL_encode/ceraNephQTL.bed
        fi
    else
        #echo $f
        if [[ $f == *"Big"* ]]; then
            awk 'BEGIN {OFS = "\t"} {gsub(/_/, "\t", $3)} {print $2,$3,$8,$9,$14}' $f | awk 'BEGIN{OFS = "\t"} {print $2,$3,$3,$2":"$3"_"$4"/"$5,$6,$7,$8,$1,$9}' - | tail -n +2 | sed 's/b38	//g'  > ~/workflows/eQTL_encode/bigDKDGTEx.bed
        #else if [[ $f == *"dkd"* || $f == *"DKD"* ]]; then
        #    awk 'BEGIN {OFS = "\t"} {gsub(/_/, "\t", $3)} {print $2,$3,$8,$14}' $f | awk 'BEGIN{OFS = "\t"} {print $2,$3,$3,$2":"$3"_"$4"/"$5,$6,$7,$1,$8}' - | tail -n +2 | sed 's/b38	//g'  > ~/projects/kathiresan/eQTL_encode/dkdGtex.bed
        else
            #awk 'BEGIN {OFS = "\t"} {gsub(/_/, "\t", $3)} {print $2,$3,$8,$9,$14}' $f | awk 'BEGIN{OFS = "\t"} {print $2,$3,$3,$2":"$3"_"$4"/"$5,$6,$7,$8,$1,$9}' - | tail -n +2 | sed 's/b38	//g' > ~/projects/kathiresan/eQTL_encode/ceraGTEx.bed
            awk 'BEGIN {OFS = "\t"} {gsub(/_/, "\t", $3)} {print $2,$3,$8,$9,$14}' $f | awk 'BEGIN{OFS = "\t"} {print $2,$3,$3,$2":"$3"_"$4"/"$5,$6,$7,$8,$1,$9}' - | tail -n +2 | sed 's/b38	//g' > ~/workflows/eQTL_encode/EFHD1_GTEx.bed
        fi
    fi
done

#for fgz in /scratch/general/lustre/u6013142/encodeAnnotations/*.bed.gz; do
#for fgz in /scratch/general/lustre/u6013142/encodeAnnotations/hg19/*.bed.gz; do
#    fName=$(basename $fgz)
#    cCRE=${fName%%.*}
bedtools intersect -a ~/workflows/eQTL_encode/EFHD1_GTEx.bed -b cCRE_regions_hg19.bed > ./gtex/EFHD1GTEx_cCRE.txt
#bedtools intersect -a ~/projects/kathiresan/eQTL_encode/ceraNephQTL.bed -b cCRE_regions_hg19.bed > ./nephqtl/ceraNephQTL_cCRE.txt
#bedtools intersect -a ~/projects/kathiresan/eQTL_encode/bigDKDNephQTL.bed -b cCRE_regions_hg19.bed > ./nephqtl/bigDKDNephQTL_cCRE.txt
#bedtools intersect -a ~/projects/kathiresan/eQTL_encode/dkdGtex.bed -b $fgz > dkdGtex_cCRE.txt
#bedtools intersect -a ~/projects/kathiresan/eQTL_encode/bigDKDGTEx.bed -b cCRE_regions.bed > ./gtex/bigDKDGTEx_cCRE.txt
#bedtools intersect -a ~/projects/kathiresan/eQTL_encode/ceraGTEx.bed -b cCRE_regions.bed > ./gtex/ceraGTEx_cCRE.txt
#done
