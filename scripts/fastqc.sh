#!/bin/bash -l
#SBATCH --array=1-166%50
#SBATCH -D /home/prvasque/projects/niehs/final_scripts/
#SBATCH -o /home/prvasque/projects/niehs/slurm-log/190121_fastqcf-stout-%j.txt
#SBATCH -e /home/prvasque/projects/niehs/slurm-log/190121_fastqcf-stderr-%j.txt
#SBATCH -J fastqcf
#SBATCH --mem=6000
#SBATCH -p med
#SBATCH -t 24:00:00 

set -e
set -u

module load fastqc

DIR='/home/prvasque/projects/niehs'
OUT='/home/prvasque/projects/niehs/Data/fastqc'

cd $DIR

for i in `ls raw_data/*/*.fq.gz`; do
	fastqc $i --noextract -o $OUT
done
