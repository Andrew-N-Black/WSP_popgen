#!/bin/bash
#SBATCH --job-name=wsp_fastq_clean
#SBATCH -A fnrquail
#SBATCH -t 14-00:00:00

#cd $SLURM_SUBMIT_DIR

module load bioinfo
module load samtools
module load BEDTools
module load TrimGalore

cd $SLURM_SUBMIT_DIR

#Make a directory to house the cleaned / cutadapt samples. Also	make a directory to house the fastqc and multiqc reports
#mkdir -p ../cleaned/fastqc_out/QC

for i in $(ls -1 *_R1_*fastq.gz )
do
SAMPLENAME=`echo $i | cut -c 1-6`
R1FILE=`echo $i | sed -r 's/_R2_/_R1_/'`
R2FILE=`echo $i | sed -r 's/_R1_/_R2_/'`


#echo " processing ${SAMPLENAME} "

# -q Trim low-quality ends from reads in addition to adapter removal. phred 20
# run fastqc
trim_galore --stringency 1 --length 30 --quality 20 --paired -o ../cleaned/ ./$R1FILE ./$R2FILE

done

#Run fastqc followed by multiqc to assess read quality
mkdir fastqc_out
fastqc *fastq.gz -o fastqc_out
cd fastqc_out

mkdir QC
multiqc . -o ./QC
