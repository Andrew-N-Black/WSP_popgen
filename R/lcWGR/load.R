library(ggplot2)
library(reshape2)
library(readxl)
load <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/WS_Pupfish/PopulationGenomics/Manuscript/Figures/Files/load.xlsx")
load$Pop <- ordered(load$Pop,levels = c("LR","SC","MS"))
b <- melt(load, id.vars=c("Pop","ESU"))

ggplot(b, aes(x=Pop,y=value,fill=as.factor(ESU))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~variable,ncol=4,scales = "free_y")+scale_fill_manual("", values =c("ESU-1"="black","ESU-2"="blue"))+xlab("")+ylab("Load Proportion")+ theme(axis.text.x = element_text(size = 10))+ theme(axis.text.x = element_text(angle = 45, vjust = 0.95, hjust=1))
ggsave("~/wsp_load.svg")
