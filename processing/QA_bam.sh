#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 25
#SBATCH -t 8-00:00:00
#SBATCH --job-name=angsd_QA
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out
#SBATCH --mem=20GB


module load biocontainers
module load pcangsd/1.10
module load angsd/0.935
module load R

REF=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/ref.fa

#####Dump output files for All samples####
angsd -P 25 -b ALL_bamlist -ref $REF -out ../angsd_out/ALL.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
 #Transpose and add row numbers, corresponding to cov, then plot in R
cat ALL.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > wsp_global

#Prep to plot by Depth by Individual / population:
ls ../cleaned/*1.fq.gz | cut -c 12-18 > samp.names
ls ../cleaned/*1.fq.gz | cut -c 12-13 > pop.names
paste samp.names pop.names ALL.qa.depthSample | sed 's/\t/ /g' > conSamp

####Dump output files ONLY for Lost River samples#####
angsd -P 25 -b LR_bamlist.txt -ref $REF -out ../angsd_out/LR.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1

#Transpose and add row numbers, corresponding to cov
cat LR.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > LR_global

###Dump output files ONLY for Malpais Spring samples####
angsd -P 25 -b MS_bamlist.txt -ref $REF -out ../angsd_out/MS.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1
 
###Dump output files ONLY for Salt Creek samples####
angsd -P 25 -b SC_bamlist.txt -ref $REF -out ../angsd_out/SC.qa \
        -doQsDist 1 -doDepth 1 -doCounts 1 -maxDepth 500 -dumpCounts 1

#Transpose and add row numbers, corresponding to cov
cat SC.qa.depthGlobal | tr "\t" "\n" | awk '{print $0,NR}' | head -n 501 > SC_global

#Once complete, run plot_QA.R
library(reshape2)
a <- read.table("conSamp")
a_sub<-a[1:22]
colnames(a_sub)<-c("Sample","Population","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20")
b <- melt(a_sub, id.vars=c("Sample","Population"))
ggplot(b, aes(x=variable,y=value,fill=as.factor(Population))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~Population,ncol=1)+scale_fill_manual( values =c("SC"="black","LR"="black","MS"="darkgrey"))


