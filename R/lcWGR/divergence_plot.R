MS_SC_FST_union <- read_excel("pupfish_fst/MS.SC.FST_union.xlsx")
ggplot(MS_SC_FST_union, aes(x=contig_base_wgr, y=fst_wgr)) +geom_point(size=1,shape=1)+ theme_classic() + xlab("Contig")+ylab("Fst")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+xlab("Contig")

ggsave("~/sc-ms-wgr.svg")
