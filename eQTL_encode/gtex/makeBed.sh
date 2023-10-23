cat sortedBigDKDGenes_GTEx.txt | tail -n +2 | tr "_" $"\t" | sed 's/chr//g' | awk 'BEGIN {OFS = "\t"} {print "chr"$3,$4,$4+1,$3":"$4"_"$5"/"$6}' > bigDKDGTEx.bed
cat sortedCeramideGenes_GTEx.txt | tail -n +2 | tr "_" $"\t" | sed 's/chr//g' | awk 'BEGIN {OFS = "\t"} {print $chr"$3,$4,$4+1,$3":"$4"_"$5"/"$6}' > ceramideGTEx.bed
