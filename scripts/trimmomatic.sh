#!/bin/bash -l
#SBATCH --array=1-664%100
#SBATCH -D /home/prvasque/projects/niehs/final_scripts/
#SBATCH -o /home/prvasque/projects/niehs/slurm-log/190124_trim-stout-%A-%a.txt
#SBATCH -e /home/prvasque/projects/niehs/slurm-log/190124_trim-stderr-%A-%a.txt
#SBATCH -J trim
#SBATCH -p high
#SBATCH --mem=16000
#SBATCH -t 24:00:00

# Last modified 2/20/19

set -e
set -u

module load bio

DIR=~/projects/niehs
SeqDir=$DIR/raw_data
OutDir=$DIR/Data/trimmed

# Change to output directory
cd $OutDir

# Link all the raw_data directories
ln -s $SeqDir/*/*.fq.gz .

# Get all the forward reads and then ?????????
f=$(find . -name "*_1.fq.gz" | sed -n $(echo $SLURM_ARRAY_TASK_ID)p)

# Remove file extension
base=$(basename $f fq.gz)
echo $base

# Create the backwards read name
baseR2=${base//_1./_2.}
echo $baseR2

# Run trimmomatic
trimmomatic PE ${base}fq.gz ${baseR2}fq.gz \
	${base}qc.fq.gz ${base}s1_se \
    ${baseR2}qc.fq.gz ${baseR2}s2_se \
    ILLUMINACLIP:/home/prvasque/projects/niehs/files/NEBnextAdapt.fa:2:40:15 \
    LEADING:2 TRAILING:2 \
    SLIDINGWINDOW:4:2 \
    MINLEN:25

# ???
echo `gzip -9c $OutDir/${base}s1_se $OutDir/${baseR2}s2_se >> $OutDir/${base}orphans.fq.gz`

# What are orphans and why remove them?
rm -f $OutDir/${base}s1_se $OutDir/${baseR2}s2_se

# I like this code
echo -e "\n execution time was `expr $end_time - $start_time` s." 
