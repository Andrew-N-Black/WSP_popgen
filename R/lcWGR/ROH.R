ind_rohs <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/WS_Pupfish/PopulationGenomics/Manuscript/Figures/Files/ind_rohs.xlsx")
ind_rohs<-as.data.frame(ind_rohs)
melt_data<-melt(ind_rohs,id.vars = c("ID","Pop"))



ROH_habitat <- read_excel("~/ROH_pop.xlsx")
ROH_habitat <- read_excel("~/ROH_pop.xlsx")
ggplot(melt_data, aes(fill=variable, y=value, x=reorder(ID,value))) +geom_bar(stat="identity")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+theme_classic()+scale_fill_manual(values=c("black","darkred"))+facet_grid(~Pop)+ylab("fROH")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(), axis.ticks.x=element_blank())
