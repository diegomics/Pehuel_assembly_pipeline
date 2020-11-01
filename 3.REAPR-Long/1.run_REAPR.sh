#!/bin/bash

#SBATCH --job-name=RPR
#SBATCH -o ~/stdout/RPR.%j.out
#SBATCH -e ~/stderr/RPR.%j.err
##SBATCH -D ~/Assemblies/RPR

#SBATCH --mail-type=ALL
#SBATCH --mail-user=123@abc.de

#SBATCH --partition=begendiv,main
##SBATCH -w b001
#SBATCH --qos=standard
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=2G
#SBATCH --time=48:00:00

export PATH=~/Software/anaconda3/bin:$PATH
source activate REAPR_env

REAPR-long="python ~/Software/masterTool/main.py"

## Only change this: #########################
ASSEMBLY="~/Assemblies/Pol/genome.fa"
ONT_READS="~/ONT.fastq"
OUT_DIR="~/Assemblies/RPR"
##############################################


$REAPR-long -ge $ASSEMBLY -fq $ONT_READS -out $OUT_DIR -m ont -t 24 -it 3
