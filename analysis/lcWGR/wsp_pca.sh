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


pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --admix -e 1  --admix_iter 100 --admix_K 2 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --admix -e 1  --admix_iter 100 --admix_K 3 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --admix -e 1  --admix_iter 100 --admix_K 4 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/FINAL.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/FINAL --threads 50 --admix -e 1  --admix_iter 100 --admix_K 5 --minMaf 0.05


pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/EXON --threads 50 --admix -e 1  --admix_iter 100 --admix_K 2 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/EXON --threads 50 --admix -e 1  --admix_iter 100 --admix_K 3 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/EXON --threads 50 --admix -e 1  --admix_iter 100 --admix_K 4 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/EXON.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/EXON --threads 50 --admix -e 1  --admix_iter 100 --admix_K 5 --minMaf 0.05


pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/INTER --threads 50 --admix -e 1  --admix_iter 100 --admix_K 2 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/INTER --threads 50 --admix -e 1  --admix_iter 100 --admix_K 3 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/INTER --threads 50 --admix -e 1  --admix_iter 100 --admix_K 4 --minMaf 0.05

pcangsd -b /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/INTER.beagle.gz \
-o /scratch/bell/blackan/PUPFISH/C.tularosa/popgen/illumina/angsd_out/pca/INTER --threads 50 --admix -e 1  --admix_iter 100 --admix_K 5 --minMaf 0.05

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

