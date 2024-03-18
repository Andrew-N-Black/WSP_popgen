#!/bin/bash
#SBATCH -A fnrtowhee
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 05-00:00:00
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.err
#SBATCH --job-name=mitogenome_pup


cd $SLURM_SUBMIT_DIR
module purge
module load bioinfo

#Create mitigenome generation job file for each sample

while read -a line
do
        echo "#!/bin/sh -l
#SBATCH -A fnrtowhee
#SBATCH -N 1
#SBATCH -n 5
#SBATCH -t 01-00:00:00
#SBATCH --job-name=${line[0]}_mito_pup
#SBATCH --error=${line[0]}_mito.err
#SBATCH --output=${line[0]}_mito.out

module purge
module load bioinfo
module load MITObim/1.8
module load bwa
module load picard-tools
module load bedops
module load GATK/3.6.0
module load samtools
export coalpath=~/CoalQC/scripts
cd $SLURM_SUBMIT_DIR
mkdir ${line[0]}
cd ${line[0]}

#Preparing the bam alignment file - use available tularosa mitogenome in NCBI and mapped the reads to it. Filterd the reads mapped to it to avoid
#Nuclear copies of mitochondrial DNA (NUMTs)
~/CoalQC/scripts/coalqc map -g ../C.tularosa_mt_ref -f ../${line[0]}_R1_001_val_1.fq.gz -r ../${line[0]}_R2_001_val_2.fq.gz -p ./mapped_${line[0]} -n 5

samtools view -b -F 4 mapped_${line[0]}/mapped_${line[0]}.sort.bam > mapped_${line[0]}.bam

#Convert bam files over to fastq
samtools bam2fq ./mapped_${line[0]}.bam > mapped_${line[0]}.fastq

#modify headers for forward and paired reads
cat mapped_${line[0]}.fastq | grep '^@.*/1$' -A 3 --no-group-separator > mapped_${line[0]}_r1.fastq
cat mapped_${line[0]}.fastq | grep '^@.*/2$' -A 3 --no-group-separator > mapped_${line[0]}_r2.fastq
gzip mapped_${line[0]}_r1.fastq mapped_${line[0]}_r2.fastq

#Interleave mapped fastq paired-end reads
interleave-fastqgz-MITOBIM.py mapped_${line[0]}_r1.fastq.gz mapped_${line[0]}_r2.fastq.gz > pup_${line[0]}_interleaved.fastq

#Run mitobim with congener mt genome with pupfish reads that ONLY mapped to it (mapped_mt.fastq)
MITObim.pl -start 1 -end 150 -sample ${line[0]} -ref tularosa -readpool pup_${line[0]}_interleaved.fastq --quick ../C.tularosa_mt_ref --trimoverhang --clean &> log5" > ./jobs/${line[0]}_pup_mt.sh

done < ./sample.list

##job submission

cd $SLURM_SUBMIT_DIR

cd /samples/jobs
for prefix in $(ls *.sh | sed -r 's/_pup_mt[.]sh//' | uniq)
do
 cd /jobs/errors/
sbatch /jobs/${prefix}_pup_mt.sh
done

