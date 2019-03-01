#/bin/bash -l
#SBATCH --array=1-83%50
#SBATCH -D /home/prvasque/projects/niehs/final_scripts/
#SBATCH -o /home/prvasque/projects/niehs/slurm-log/salmon_quant_stout-%A-%a.txt
#SBATCH -e /home/prvasque/projects/niehs/slurm-log/salmon_quant_stderr-%A-%a.txt
#SBATCH -J salmon_quant_kfish
#SBATCH --mem=8000
#SBATCH -p high
#SBATCH -t 24:00:00
#SBATCH -c 8
## Modififed March 1, 2019 PV

module load bio

DIR=/home/prvasque/projects/niehs/Data/trimmed
INDEX=/home/prvasque/projects/niehs/Data/refseq/kfish_salm_index_fmd
OUTDIR=/home/prvasque/projects/niehs/Data/counts

cd $DIR

f=$(find $DIR -name "*L5_1.qc.fq.gz" | sed -n $(echo $SLURM_ARRAY_TASK_ID)p)
name=$(echo $f | cut -d "/" -f 8 | cut -d "_" -f 1-6)
echo "Processing sample ${name}"

salmon quant -i $INDEX -l ISR \
  -1 <(gunzip -c ${name}_L5_1.qc.fq.gz ${name}_L6_1.qc.fq.gz ${name}_L7_1.qc.fq.gz ${name}_L8_1.qc.fq.gz)\
  -2 <(gunzip -c ${name}_L5_2.qc.fq.gz ${name}_L6_2.qc.fq.gz ${name}_L7_2.qc.fq.gz ${name}_L8_2.qc.fq.gz) \
  -p 8 -o ${OUTDIR}/${name}_quant
