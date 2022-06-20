ml biocontainers
ml bedtools

#Use bedtools to create coordinates of exons
awk 'BEGIN{OFS="\t";} $3=="exon" {print $1,$4-1,$5}' GCF_016077235.1.gtf |
 bedtools sort | bedtools merge -i - > tularosa_exon.bed



#Use bedtools to create coordinates of intergenic areas
cat GCF_016077235.1.gtf |
  awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' |
  bedtools sort -g chrom |
  bedtools complement -i stdin -g chrom > intergenic.bed
  gzip > my_intergenic.bed.gz
  
  
awk '{print $1}' exon.beagle | sed 's/NW_/NW./g'| tr "1_" "1\t" | sed 's/NW./NW_/g' > ../exons.bed
