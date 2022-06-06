#SBATCH -A fnrquail
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -t 12-00:00:00
#SBATCH --job-name=wsp_fst
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=240G



REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/GCF_016077235.1_ASM1607723v1_genomic.fna

#Angsd need the reference to be indexed first
samtools faidx /scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/GCF_016077235.1_ASM1607723v1_genomic.fna

#first calculate per pop site allele frequency likelihoods (saf) for each population
#saf for MP

ls ../final_bams/MS*filt.bam > MS_bamlist.txt

/depot/fnrdewoody/apps/angsd/angsd -P 128 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/fst/MS \
-minInd 12 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 \
-bam ./MS_bamlist.txt -doCounts 1 -setMinDepth 90 -setMaxDepth 165 -GL 1 -doSaf 1 -anc $REF -ref $REF

#saf for LR
ls ../final_bams/LR*filt.bam > LR_bamlist.txt

/depot/fnrdewoody/apps/angsd/angsd -P 128 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/fst/LR \
-minInd 12 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 \
-bam ./LR_bamlist.txt -doCounts 1 -setMinDepth 90 -setMaxDepth 165 -GL 1 -doSaf 1 -anc $REF -ref $REF


#saf for SC
ls ../final_bams/SC*filt.bam > SC_bamlist.txt

/depot/fnrdewoody/apps/angsd/angsd -P 128 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/fst/SC \
-minInd 12 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 -C 50 -baq 1 -minMapQ 30 -minQ 35 \
-bam ./SC_bamlist.txt -doCounts 1 -setMinDepth 90 -setMaxDepth 165 -GL 1 -doSaf 1 -anc $REF -ref $REF

#calculate the 1D SFS from allele freq likelihoods
#/depot/fnrdewoody/apps/angsd/misc/realSFS ../angsd_out/fst/MS.saf.idx  -P 126 > ../angsd_out/fst2/MS.sfs
#/depot/fnrdewoody/apps/angsd/misc/realSFS ../angsd_out/fst/LR.saf.idx  -P 126 > ../angsd_out/fst2/LR.sfs
#/depot/fnrdewoody/apps/angsd/misc/realSFS ../angsd_out/fst/SC.saf.idx  -P 126 > ../angsd_out/fst2/SC.sfs

#calculate the 2D SFS
#/depot/fnrdewoody/apps/angsd/misc/realSFS ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/LR.saf.idx -P 126 > ../angsd_out/fst2/MS.LR.ml
#/depot/fnrdewoody/apps/angsd/misc/realSFS ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/SC.saf.idx -P 126 > ../angsd_out/fst2/MS.SC.ml
#/depot/fnrdewoody/apps/angsd/misc/realSFS ../angsd_out/fst/LR.saf.idx ../angsd_out/fst/SC.saf.idx -P 126 > ../angsd_out/fst2/LR.SC.ml

#Now pairwise Fsts

#Index sample so same sites are analyzed for each pop
/depot/fnrdewoody/apps/angsd/misc/realSFS fst index ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/LR.saf.idx -sfs ../angsd_out/fst2/MS.LR.ml -fstout ../angsd_out/fst2/MS.LR -P 126
/depot/fnrdewoody/apps/angsd/misc/realSFS fst index ../angsd_out/fst/MS.saf.idx ./angsd_out/fst/SC.saf.idx -sfs ../angsd_out/fst2/MS.SC.ml -fstout ../angsd_out/fst2/MS.SC -P 126
#/depot/fnrdewoody/apps/angsd/misc/realSFS fst index ../angsd_out/fst/LR.saf.idx ../angsd_out/fst/SC.saf.idx -sfs ../angsd_out/fst2/LR.SC.ml -fstout ../angsd_out/fst2/LR.SC -P 126

#sliding window analysis among all population samples
/depot/fnrdewoody/apps/angsd/misc/realSFS fst index ../angsd_out/fst/MS.saf.idx ../angsd_out/fst/LR.saf.idx ../angsd_out/fst/SC.saf.idx -sfs ../angsd_out/fst2/MS.LR.ml -sfs ../angsd_out/fst2/MS.SC.ml -sfs ../angsd_out/fst2/LR.SC.ml -fstout ../angsd_out/fst2/three_pop -P 126
/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats2 ../angsd_out/fst2/three_pop.fst.idx -win 50000 -step 10000 -P 128 > ../angsd_out/fst2/slidingwindow

#Global pairwise estimates
/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats ../angsd_out/fst2/MS.LR.fst.idx 
/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats ../angsd_out/fst2/MS.SC.fst.idx 
/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats ../angsd_out/fst2/LR.SC.fst.idx 
/depot/fnrdewoody/apps/angsd/misc/realSFS fst stats ../angsd_out/fst2/three_pop.fst.idx 

