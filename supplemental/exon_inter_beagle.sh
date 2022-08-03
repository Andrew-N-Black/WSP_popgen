#!/bin/sh -l
#SBATCH -A fnrquail
#SBATCH -N 1
#SBATCH -n 80
#SBATCH -t 10-00:00:00
#SBATCH --job-name=angsd_pca
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=60GB


module load biocontainers
module load angsd

REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#Generate angsd output files
angsd -P 80 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL \
-bam ./ALL_bamlist -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 4 -doMaf 1 -minMaf 0.05 -rmTriallelic 1  \
-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 -SNP_pval 1e-6  -ref $REF -anc $REF


#Index exon sites
angsd sites index exon.bed 

#Generate angsd output files for exon regions
angsd -P 80 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON \
-bam ./ALL_bamlist -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 4 -doMaf 1 -minMaf 0.05 -rmTriallelic  1  \
-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 -SNP_pval 1e-6  -ref $REF -anc $REF \
-sites exon.bed -rf chr.exon

#Index intergenic sites
angsd sites index inter.bed

#Generate angsd output files for intergenic regions
angsd -P 80 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER \
-bam ./ALL_bamlist -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 4 -doMaf 1 -minMaf 0.05 -rmTriallelic 1  \
-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 -SNP_pval 1e-6  -ref $REF -anc $REF \
-sites  inter.bed -rf chr.inter
