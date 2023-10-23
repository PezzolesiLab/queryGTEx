#!/usr/bin/env bash

#SBATCH --time=12:00:00
#SBATCH -o dbSNPQueryRun-%j.out
#SBATCH -e dbSNPQueryRun-%j.err
#SBATCH --mail-user=scott.frodsham@hsc.utah.edu
#SBATCH --mail-type=END
#SBATCH --account=pezzolesi-np
#SBATCH --partition=pezzolesi-np

perl query_dbSNP.pl > queryOutput.txt

