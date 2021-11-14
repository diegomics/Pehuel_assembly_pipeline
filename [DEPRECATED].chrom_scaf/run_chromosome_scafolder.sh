#!/bin/bash

#SBATCH --job-name=ChrScaf
#SBATCH -o ~/stdout/ChrScaf.%j.out
#SBATCH -e ~/stderr/ChrScaf.%j.err
#SBATCH -D ~/Assemblies/chromosome_scaffolder

#SBATCH --mail-type=ALL
#SBATCH --mail-user=123@abc.de

#SBATCH --partition=begendiv,main
##SBATCH -w b001
#SBATCH --qos=standard
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=1G
#SBATCH --time=12:00:00

module load GCC/8.3.0
module load GCCcore/8.3.0
module load Perl/5.30.0-GCCcore-8.3.0
module load Boost/1.71.0-gompic-2019b

## Only change this: ###################################################################
REF_GENOME="~/Related_sp/Gcal/gc_PacBio_HiC.fasta"
ASSEMBLY="~/Assemblies/Pol_PE/final.genome.scf.PolcaCorrected.fa"
##OUT_DIR="~/Assemblies/chromosome_scaffolder"
########################################################################################

bash ~/Software/MaSuRCA-3.4.2/bin/chromosome_scaffolder.sh -r $REF_GENOME -q $ASSEMBLY -t 24 -nb
