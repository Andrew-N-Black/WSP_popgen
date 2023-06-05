#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -t 10-00:00:00
#SBATCH --job-name=angsd_pca
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=100GB


module load biocontainers
module load angsd

REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#Generate angsd output files for all OK regions
angsd -P 128 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL \
-bam ./ALL_bamlist -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 4 -doMaf 1 -minMaf 0.05 -rmTriallelic 1  \
-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 -SNP_pval 1e-6  -ref $REF -anc $REF \
-sites  ok.bed -rf chr.txt

#Get list of sites:
gzip -d FINAL.beagle.gz
awk '{print $1}' FINAL.beagle | sed 's/NW_/NW./g' | sed 's/_/\t/g' | sed 's/NW./NW_/g' | tail -n +2 > FINAL.SITES
gzip FINAL.beagle.gz










