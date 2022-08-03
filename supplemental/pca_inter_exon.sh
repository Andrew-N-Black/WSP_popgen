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


REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa


#Run PCA for exogenic

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON.beagle.gz  \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 

#Run PCA for intergenic
pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 


#DONE
