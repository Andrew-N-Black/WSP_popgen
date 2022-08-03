#!/bin/sh -l
#SBATCH -A fnrquail
#SBATCH -N 1
#SBATCH -n 126
#SBATCH -t 12-00:00:00
#SBATCH --job-name=Fst
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=235G

module load biocontainers
module load angsd/0.935

REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/GCF_016077235.1.fna

#Angsd need the reference to be indexed first
#samtools faidx scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/GCF_016077235.1_ASM1607723v1_genomic.fna


# index file
angsd sites index ./FINAL.SITES

#first calculate per pop site allele frequency likelihoods (saf) for each population
#saf for MP
#ls ../final_bams/MS*filt.bam > MS_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/fst/MS \
-minInd 12 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 -minMapQ 30 -minQ 35 \
-bam ./MS_bamlist.txt -doCounts 1 -setMinDepth 90 -setMaxDepth 165 -GL 2 -doSaf 1 -anc $REF -ref $REF \
-sites FINAL.SITES

#saf for LR
#ls ../final_bams/LR*filt.bam > LR_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/fst/LR \
-minInd 12 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 -minMapQ 30 -minQ 35 \
-bam ./LR_bamlist.txt -doCounts 1 -setMinDepth 90 -setMaxDepth 165 -GL 1 -doSaf 1 -anc $REF -ref $REF \
-sites FINAL.SITES


#saf for SC
#ls ../final_bams/SC*filt.bam > SC_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/fst/SC \
-minInd 12 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 -minMapQ 30 -minQ 35 \
-bam ./SC_bamlist.txt -doCounts 1 -setMinDepth 90 -setMaxDepth 165 -GL 1 -doSaf 1 -anc $REF -ref $REF \
-sites FINAL.SITES

#calculate the 1D SFS from allele freq likelihoods
realSFS ../angsd_out/fst/MS.saf.idx -P 126 -fold 1 > ../angsd_out/fst/MS.sfs
realSFS ../angsd_out/fst/LR.saf.idx -P 126 -fold 1 > ../angsd_out/fst/LR.sfs
realSFS ../angsd_out/fst/SC.saf.idx -P 126 -fold 1 > ../angsd_out/fst/SC.sfs

#calculate the 2D SFS
realSFS ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/LR.saf.idx -P 126 > ../angsd_out/fst/MS.LR.ml
realSFS ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/SC.saf.idx -P 126 > ../angsd_out/fst/MS.SC.ml
realSFS ../angsd_out/fst/LR.saf.idx ../angsd_out/fst/SC.saf.idx -P 126 > ../angsd_out/fst/LR.SC.ml

#Now pairwise Fsts

#Index sample so same sites are analyzed for each pop
realSFS fst index ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/LR.saf.idx -sfs ../angsd_out/fst/MS.LR.ml -fstout ../angsd_out/fst/MS.LR -P 126
realSFS fst index ../angsd_out/fst/MS.saf.idx ./angsd_out/fst/SC.saf.idx -sfs ../angsd_out/fst/MS.SC.ml -fstout ../angsd_out/fst/MS.SC -P 126
realSFS fst index ../angsd_out/fst/LR.saf.idx ../angsd_out/fst/SC.saf.idx -sfs ../angsd_out/fst/LR.SC.ml -fstout ../angsd_out/fst/LR.SC -P 126

#Global pairwise estimates
realSFS fst stats ../angsd_out/fst/MS.LR.fst.idx 
realSFS fst stats ../angsd_out/fst/MS.SC.fst.idx 
realSFS fst stats ../angsd_out/fst/LR.SC.fst.idx 
realSFS fst stats ../angsd_out/fst/three_pop.fst.idx 

#sliding window analysis among all population samples
realSFS fst index ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/LR.saf.idx ../angsd_out/fst/SC.saf.idx -sfs ../angsd_out/fst/MS.LR.ml -sfs ../angsd_out/fst/MS.SC.ml -sfs ../angsd_out/fst/LR.SC.ml -fstout ../angsd_out/fst/three_pop -P 126

realSFS fst stats2 ../angsd_out/fst/three_pop.fst.idx -win 50000 -step 10000 -P 126 > ../angsd_out/fst/slidingwindow

#DONE
