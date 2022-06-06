#!/bin/sh -l
#SBATCH -A fnrquail
#SBATCH -N 1
#SBATCH -n 100
#SBATCH -t 10-00:00:00
#SBATCH --job-name=angsd_pca
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=100GB


module load biocontainers
module load pcangsd
module load angsd


REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#Generate angsd output files (beagle and mags)
angsd -P 100 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pupfish_final \
-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 \
-bam ./ALL_bamlist_norealign -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -anc $REF -ref $REF


#Run PCA
pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pupfish_final.beagle.gz --minMaf 0.05 -o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/pupfish_final --threads 100 --sites_save --maf_tole 1e-9 --tole 1e-9 --iter 5000 --maf_iter 5000
