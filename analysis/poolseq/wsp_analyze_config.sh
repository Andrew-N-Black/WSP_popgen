#!/bin/bash
#PPanalyze configuration file
 analyze_ESU.config

#Populations for analysis#
POPS=1,2,3

#Input files and names#
PREFIX=three.pops.10
COVFILE=OK_coverage.txt
SYNC=OK.sync
FZFILE=OK.fz
BLACKLIST=OK_poly_all.txt
OUTDIR=Final

#Types of Analyses#
FST=on
SLIDINGFST=on
FET=off
NJTREE=off

#Global Parameters#
MINCOV=10
MAXCOV=100
MAF=0.05

#FST Parameters#
FSTTYPE=traditional
WINDOW=25000
STEP=12500
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

