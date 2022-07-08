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
module load angsd


REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa


#Run PCA
pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz --selection --tree \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --pcadapt --inbreedSamples

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON.beagle.gz --selection --tree \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --pcadapt --inbreedSamples


pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER.beagle.gz --selection --tree \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --pcadapt --inbreedSamples



