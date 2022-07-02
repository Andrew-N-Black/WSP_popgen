#!/bin/bash
#PPanalyze configuration file
pupfish_poly_all.txt
#Populations for analysis#
POPS=1,2,3

#Input files and names#
PREFIX=pupish_analyze
COVFILE=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/final/filters/pupfish_coverage.txt
SYNC=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/final/pupfish.sync
FZFILE=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/final/pupfish.fz
BLACKLIST=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/final/filters/pupfish_poly_all.txt
OUTDIR=/scratch/bell/blackan/PUPFISH/C.tularosa/popgen/poolseq/final/analysis

#Types of Analyses#
FST=on
SLIDINGFST=on
FET=on
NJTREE=off

#Global Parameters#
MINCOV=10
MAXCOV=100
MAF=0.05

#FST Parameters#
FSTTYPE=traditional
WINDOW=50000
STEP=10000
NIND=30

#NJ Tree Parameters
STRWINDOW=10000
BSTRAP=1000
AFFILT=1
METHOD="mean"

#Dependencies#
POOL2=/group/bioinfo/apps/apps/popoolation2_1201

#Languages needed on system#
	#bash/shell
	#perl
	#R
