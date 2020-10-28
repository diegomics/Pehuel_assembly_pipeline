#!/bin/bash

#SBATCH -J Bt2.demit
#SBATCH -o ~/stdout/Bt2.demit.%j.out
#SBATCH -e ~/stderr/Bt2.demit.%j.err
##SBATCH -D ~/

#SBATCH --mail-type=ALL
#SBATCH --mail-user=123@abc.de

#SBATCH --partition=begendiv,main
##SBATCH -w b001
#SBATCH --qos=standard
#SBATCH --cpus-per-task=32
##SBATCH --mem-per-cpu=1G
#SBATCH --mem=32G
#SBATCH --time=48:00:00


## Only change this: #############################################################
FASTA="~/Related_sp/RELATED_SP_mt.fasta"
FASTQ1="~/READS_1.fastq.gz"
FASTQ2="~/READS_2.fastq.gz"
##################################################################################

DIR=$(dirname $FASTQ1)

INDEX=$(basename $FASTA .fasta)

BOWTIE2_DIR="~/Software/bowtie2-2.3.5.1"

NEW=$(basename $FASTQ1 _1.fastq.gz)

#mkdir $DIR/bt2_idx


## build index
#$BOWTIE2_DIR/bowtie2-build --threads 32 -f $FASTA $DIR/bt2_idx/$INDEX

## align reads
$BOWTIE2_DIR/bowtie2 --local -p 32 -x $DIR/bt2_idx/\"$INDEX\" -1 $FASTQ1 -2 $FASTQ2 --un-conc $DIR/$NEW.demit --al-conc $DIR/$NEW.mit -S $DIR/$NEW.sam



