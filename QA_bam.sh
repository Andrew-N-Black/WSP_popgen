#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 25
#SBATCH -t 8-00:00:00
#SBATCH --job-name=angsd_QA
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=20GB


module load biocontainers
module load pcangsd/1.10
module load angsd/0.935

REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#Dump output files for All samples
angsd -P 25 -b ALL_bamlist -ref $REF -out ../angsd_out/ALL.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
#Dump output files ONLY for Lost River samples
angsd -P 25 -b LR_bamlist.txt -ref $REF -out ../angsd_out/LR.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
#Dump output files ONLY for Malpais Spring samples
angsd -P 25 -b MS_bamlist.txt -ref $REF -out ../angsd_out/MS.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
#Dump output files ONLY for Salt Creek samples
angsd -P 25 -b SC_bamlist.txt -ref $REF -out ../angsd_out/SC.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
        
#Output files will need to be manually modified prior to plotting (see R/QA.R plots)
