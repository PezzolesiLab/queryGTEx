#!/usr/bin/env bash

#SBATCH --time=0-01:00:00
#SBATCH -o sortAfterCat-%j.out
#SBATCH -e sortAfterCat-%j.err
#SBATCH --mail-user=scott.frodsham@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

cat bigDkdSigSNPs/* | sort -u > sortedBigDKDGenes_GTEX.txt
