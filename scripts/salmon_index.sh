#!/bin/bash -l
#SBATCH -D /home/prvasque/projects/niehs/final_scripts/
#SBATCH -o /home/prvasque/projects/niehs/slurm-log/180123-salmindexfmd-stout-%j.txt
#SBATCH -e /home/prvasque/projects/niehs/slurm-log/180123-salmindexfmd-stderr-%j.txt
#SBATCH -J salmon_index
#SBATCH --mem=2600
#SBATCH -p med
#SBATCH -t 24:00:00

set -e
set -u

module load bio

DIR=~/projects/niehs/Data/refseq

cd $DIR

