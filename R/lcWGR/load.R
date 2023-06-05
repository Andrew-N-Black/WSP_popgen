#R version 4.2.0
library(ggplot2)
library(reshape2)
library(readxl)
setwd("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/WS_Pupfish/PopulationGenomics/Manuscript/Figures/Files/")

#Read in excel file
load <- read_excel("load.xlsx")
#Set order of factors
load$Pop <- ordered(load$Pop,levels = c("LR","SC","MS"))
#Reshape dataframe
b <- melt(load, id.vars=c("Pop","ESU"))
#plot
ggplot(b, aes(x=Pop,y=value,fill=as.factor(ESU))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~variable,ncol=4,scales = "free_y")+scale_fill_manual("", values =c("ESU-1"="black","ESU-2"="blue"))+xlab("")+ylab("Load Proportion")+ theme(axis.text.x = element_text(size = 10))+ theme(axis.text.x = element_text(angle = 45, vjust = 0.95, hjust=1))

#Venn diagram of high sites
library(readr)
library(VennDiagram)
library(gplots)
venn.plot <- venn.diagram(list(high_sites$MS, high_sites$SC,high_sites$LR), NULL, fill=c("black", "blue","blue"), alpha=c(1,0.7,0.7), cex = 2,label.col= 8.5,cat.cex=1.5,cat.fontface=4, category.names=c("MS", "SC","LR"),na = "remove")

#Create a table for intersections
v.table <- venn(list(MS=high_sites$MS, SC=high_sites$SC,LR=high_sites$LR),show.plot=FALSE)

attr(,"intersections")$`MS:LR`
 [1] "NW_024037876.1:5144"   
 [2] "NW_024038037.1:1256554"
 [3] "NW_024038127.1:75176"  
 [4] "NW_024038353.1:8217"   
 [5] "NW_024038405.1:740311" 
 [6] "NW_024039079.1:406775" 
 [7] "NW_024039648.1:504380" 

attr(,"intersections")$`MS:SC`
 [1] "NW_024038037.1:1257424"
 [2] "NW_024038077.1:72455"  
 [3] "NW_024038309.1:1812692"
 [4] "NW_024038342.1:61148"  
 [5] "NW_024038353.1:11087"  
 [6] "NW_024038688.1:1538575"
 [7] "NW_024038844.1:928402" 
 [8] "NW_024038851.1:1520384"
 [9] "NW_024038953.1:11946"  
[10] "NW_024039079.1:410108" 
[11] "NW_024039484.1:422195" 
[12] "NW_024039506.1:298429" 
[13] "NW_024039622.1:60415"  

attr(,"intersections")$`SC:LR`
 [1] "NW_024037791.1:76088"  
 [2] "NW_024037791.1:78869"  
 [3] "NW_024037876.1:77029"  
 [4] "NW_024037921.1:232641" 
 [5] "NW_024037933.1:66909"  
 [6] "NW_024037994.1:222253" 
 [7] "NW_024038037.1:1262075"
 [8] "NW_024038077.1:48937"  
 [9] "NW_024038146.1:99403"  
[10] "NW_024038236.1:32731"  
[11] "NW_024038309.1:1752570"
[12] "NW_024038405.1:741436" 
[13] "NW_024038720.1:4154616"
[14] "NW_024038953.1:12055"  
[15] "NW_024038953.1:13581"  
[16] "NW_024039032.1:5234"   
[17] "NW_024039032.1:7065"   
[18] "NW_024039032.1:7067"   
[19] "NW_024039079.1:407222" 
[20] "NW_024039095.1:205051" 
[21] "NW_024039139.1:6081"   
[22] "NW_024039378.1:197909" 
[23] "NW_024039378.1:220659" 
[24] "NW_024039445.1:373943" 
[25] "NW_024039497.1:6051"   
[26] "NW_024039578.1:610049" 

attr(,"intersections")$`MS:SC:LR`
 [1] "NW_024038103.1:1174336"
 [2] "NW_024038127.1:70009"  
 [3] "NW_024038127.1:70092"  
 [4] "NW_024038136.1:12597"  
 [5] "NW_024038146.1:24983"  
 [6] "NW_024038146.1:25284"  
 [7] "NW_024038405.1:740677" 
 [8] "NW_024038475.1:417867" 
 [9] "NW_024038913.1:626380" 
[10] "NW_024038980.1:821911" 
[11] "NW_024039015.1:835425" 
[12] "NW_024039041.1:2666370"
[13] "NW_024039041.1:2667645"
[14] "NW_024039041.1:2671935"
[15] "NW_024039041.1:2672022"
[16] "NW_024039060.1:144021" 
[17] "NW_024039079.1:407799" 
[18] "NW_024039079.1:409475" 
[19] "NW_024039095.1:206934" 
[20] "NW_024039095.1:217453" 
[21] "NW_024039102.1:59380"  
[22] "NW_024039102.1:1177465"
[23] "NW_024039137.1:282189" 
[24] "NW_024039203.1:539297" 
[25] "NW_024039418.1:1597371"
[26] "NW_024039463.1:1909185"
[27] "NW_024039463.1:1909754"
[28] "NW_024039463.1:4628517"
[29] "NW_024039467.1:34891"  
[30] "NW_024039586.1:157578" 
[31] "NW_024039751.1:4071" 

