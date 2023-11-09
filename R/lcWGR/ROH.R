#R version 4.2.0
library(ggplot2)
library(readxl)
library(reshape2)

#Load excel file listing fROH values
ind_rohs <- read_excel("ind_rohs.xlsx")
#Convert to Dataframe for reshape2
ind_rohs<-as.data.frame(ind_rohs)
#Reshape
melt_data<-melt(ind_rohs,id.vars = c("ID","Pop","ESU"))
#Set order of populations
melt_data$Pop <- factor(melt_data$Pop, levels = c("Malpais Spring","Salt Creek","Lost River"))
#plot with ggplot2
ggplot(melt_data, aes(fill=Pop, y=value, x=reorder(ID,value))) +geom_bar(stat="identity",position="dodge")+facet_grid(variable~Pop,scales = "free")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+theme_classic()+
+     scale_fill_manual(values=c("black","black","blue"))+ylab("fROH")+xlab("Sample (N=45)")+
+     theme(legend.position="none")+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())

