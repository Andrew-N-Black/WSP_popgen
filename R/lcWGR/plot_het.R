#Plot and test significance of individual heterozygosity
#R version 4.2.0
#ggplot2 version 3.3.6
#ggpubr version 0.4.0 
#dplyr version 1.0.9

#Use Excel to calculate proportion of heterozygotes from wsp_het.sh, then import file:
#Set working directory
setwd("~/Files")
library(readxl)
#Import into R
het_pupfish <- read_excel("het_pupfish.xlsx")
#Assign factor
het_pupfish$pop <- factor(het_pupfish$pop , levels=c("MS","SC", "LR"))
#plot
ggplot(het_pupfish,aes(x=pop,y=het,fill=pop))+geom_boxplot(show.legend =FALSE)+scale_fill_manual(name="pop", values =c("SC"="black","LR"="black","MS"="blue"))+xlab("")+ylab("Individual Heterozygosity")+theme_classic()
#produce plot
ggsave("Figure_2.svg")

#Test for normallity then sig
library(ggpubr)
library(dplyr)

#How het estimates fits distribution
ggqqplot(het_pupfish$het)

#Shapiro test
shapiro.test(het_pupfish$het)
#Shapiro-Wilk normality test
#data:  het_pupfish$het
#W = 0.91489, p-value = 0.002849

# Split into three datasets, based upon pop
LR<-het_pupfish[1:15,]
SC<-het_pupfish[31:45,]
MS<-het_pupfish[16:30,]

#do non-parameteric for three pairwise tests based upon wilk
wilcox.test(LR$het,SC$het)

#Wilcoxon rank sum exact test
#data:  LR$het and SC$het
#W = 42, p-value = 0.002702

wilcox.test(LR$het,MS$het)
#Wilcoxon rank sum exact test
#data:  LR$het and MS$het
#W = 0, p-value = 1.289e-08

wilcox.test(SC$het,MS$het)
#Wilcoxon rank sum exact test
#data:  SC$het and MS$het
#W = 0, p-value = 1.289e-08

#DONE
