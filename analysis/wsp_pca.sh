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
module load R


REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#Generate angsd output files (beagle and mags)
angsd -P 100 -out /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pupfish_final \
-minInd 36 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -minMapQ 30 -minQ 35 -setMinDepth 275 -setMaxDepth 425 \
-bam ./ALL_bamlist_norealign -doCounts 1 -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -anc $REF -ref $REF


#Run PCA
pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pupfish_final.beagle.gz --minMaf 0.05 -o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/pupfish_final --threads 100 --sites_save --maf_tole 1e-9 --tole 1e-9 --iter 5000 --maf_iter 5000

#Plot
setwd("./")
#Import covariation matrix
cov<-as.matrix(read.table("pupfish_final.cov"))
#Import population labeling
popmap <- read.delim("popmap", header=FALSE)
#head popmap
                V1 V2    V3
#1 LR-5017_filt.bam LR ESU-1
#2 LR-5018_filt.bam LR ESU-1
#3 LR-5019_filt.bam LR ESU-1
#4 LR-5020_filt.bam LR ESU-1
#5 LR-5021_filt.bam LR ESU-1
#6 LR-5146_filt.bam LR ESU-1
# . . .

#Get eigenvalues
x<-eigen(cov)
#Get Variance explained
x$values/sum(x$values)

#Convert to data frame
PC1_3<-as.data.frame(x$vectors[,1:3])

#Set object for legend title
title<-"Population"
#Plot
ggplot(data=PC1_3, aes(y=V2, x=V1, shape=as.factor(popmap$V2),color=as.factor(popmap$V3)))+ geom_point(size=5,alpha=7/10)+ theme_classic() + xlab("PC1 (38.6%)") +ylab("PC2 (3.2%)")+scale_color_manual(name="", values =c("ESU-1"="black","ESU-2"="darkgrey"))+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual(title,values=c(16,15,18))

#Save as svg
ggsave("Figure_1.svg")

