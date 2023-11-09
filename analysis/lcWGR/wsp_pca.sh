#!/bin/sh -l
#SBATCH -A fnrquail
#SBATCH -N 1
#SBATCH -n 50
#SBATCH -t 1-00:00:00
#SBATCH --job-name=angsd_pca
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=50GB


module load biocontainers
module load pcangsd


REF=ref_100kb.fa


#Run PCA
pcangsd -b FINAL.beagle.gz --selection --tree \
-o FINAL --threads 50 --pcadapt --inbreedSamples

pcangsd -b EXON.beagle.gz --selection --tree \
-o FINAL/ --threads 50 --pcadapt --inbreedSamples


pcangsd -b INTER.beagle.gz --selection --tree \
-o FINAL/ --threads 50 --pcadapt --inbreedSamples


#DONE
