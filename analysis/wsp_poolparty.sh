









#Define Populations
#head pop*
#==> pop_1.txt <==
#SC-p_R1_val_1
#==> pop_2.txt <==
#LR-p_R1_val_1
#==> pop_3.txt <==
#MS-p_R1_val_1

#Parse fst, fstS, and fet files
cut -f 8  pupish_analyze_raw.fst  | cut -c 5-20 > LR.MS.fst.txt
cut -f 7  pupish_analyze_raw.fst | cut -c 5-20 > SC.MS.fst.txt
cut -f 6  pupish_analyze_raw.fst | cut -c 5-20 > SC.LR.fst.txt

cut -f 8  pupish_analyze_raw.Sfst  | cut -c 5-20 > LR.MS.fstS.txt
cut -f 7  pupish_analyze_raw.Sfst | cut -c 5-20 > SC.MS.fstS.txt
cut -f 6  pupish_analyze_raw.Sfst | cut -c 5-20 > SC.LR.fstS.txt

cut -f 8  pupish_analyze_raw.fet  | cut -c 5-20 > LR.MS.fet.txt
cut -f 7  pupish_analyze_raw.fet | cut -c 5-20 > SC.MS.fet.txt
cut -f 6  pupish_analyze_raw.fet | cut -c 5-20 > SC.LR.fet.txt

pupish_analyze_raw <- read.delim("~/analysis/pupish_analyze_raw.fet", header=FALSE)
colnames(pupish_analyze_raw)<-c("scaf","bp","window","step","cov","LR:MS","SC.MS","SC.LR")
library(qqman)
fst.plot(pupish_analyze_raw, scaffold.widths = NULL, scaffs.to.plot = NULL,fst.name = "LR:MS", chrom.name = "scaf", bp.name = "bp", y.lim = NULL, xlabels = NULL, xlab.indices = NULL, axis.size = 0.5, pt.cols = c("darkgrey", "lightgrey"),pt.cex = 0.5)

