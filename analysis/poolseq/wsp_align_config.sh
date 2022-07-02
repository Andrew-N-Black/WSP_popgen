#!/bin/bash
#PPalign configuration file

#Input/Output#
	INDIR=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/cleaned
	OUTDIR=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/final
	OUTPOP=pupfish 
	GENOME=/scratch/bell/blackan/PUPFISH/C.tularosa/assembly/ncbi/Cyprinodon-tularosa/GCF_016077235.1_ref/GCF_016077235.1.fna
	SCAHEAD=NW_

#Run Parameters#
	THREADZ=128
	BQUAL=35
	MAPQ=30
	SNPQ=30
	MINLENGTH=30
	INWIN=10
	MAF=0.05
	KMEM=Xmx500g
	MINDP=10
#Run-types#
	SPLITDISC=off
	INDCONT=off
	QUALREPORT=off

#Optional Parameters#
	ALIGNONLY=
	USEVCF=

#Dependency Locations#
	BCFTOOLS=bcftools
	FASTQC=fastqc
	BWA=bwa
	SAMBLASTER=samblaster
	SAMTOOLS=samtools
	PICARDTOOLS=/depot/bioinfo/apps/apps/picard-tools-2.26.2/picard.jar
	BBMAPDIR=/depot/bioinfo/apps/apps/BBMap-37.93
	POOL2=/group/bioinfo/apps/apps/popoolation2_1201

#Languages needed on system#
	#bash/shell
	#perl
	#java
	#R
