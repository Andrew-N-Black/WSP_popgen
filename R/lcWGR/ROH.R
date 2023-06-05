

setwd("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/WS_Pupfish/PopulationGenomics/Manuscript/Figures/Files/")
ind_rohs <- read_excel("ind_rohs.xlsx")
ind_rohs<-as.data.frame(ind_rohs)
melt_data<-melt(ind_rohs,id.vars = c("ID","Pop","ESU"))
melt_data$Pop <- factor(melt_data$Pop, levels = c("Malpais Spring","Salt Creek","Lost River"))
ggplot(melt_data, aes(fill=Pop, y=value, x=reorder(ID,value))) +geom_bar(stat="identity",position="dodge")+facet_grid(variable~Pop,scales = "free")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+theme_classic()+
+     scale_fill_manual(values=c("black","black","blue"))+ylab("fROH")+xlab("Sample (N=45)")+
+     theme(legend.position="none")+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())

