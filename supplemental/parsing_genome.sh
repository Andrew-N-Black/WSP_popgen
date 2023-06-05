ml biocontainers
ml bedtools

#Use bedtools to create coordinates of intergenic areas
samtools faidx GCF_016077235.1_ASM1607723v1_genomic.fna 
cut -f 1-2 GCF_016077235.1_ASM1607723v1_genomic.fna.fai > chrom

#Use bedtools to create coordinates of genes
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' GCF_016077235.1.gtf |
 bedtools sort -g chrom| bedtools merge -i - > genes.bed

#Get coordinates of intergenic regions
cat GCF_016077235.1_ASM1607723v1_genomic.gtf | awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' |   bedtools sort -g chrom |   bedtools complement -i stdin -g chrom > intergenic.bed

#DONE
