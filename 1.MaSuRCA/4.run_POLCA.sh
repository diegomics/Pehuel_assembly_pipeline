#!/bin/bash

#SBATCH --job-name=Pol
#SBATCH -o ~/stdout/Pol.%j.out
#SBATCH -e ~/stderr/Pol.%j.err
#SBATCH -D ~/Assemblies/Pol

#SBATCH --mail-type=ALL
#SBATCH --mail-user=123@abc.de

#SBATCH --partition=begendiv,main
##SBATCH -w b001
#SBATCH --qos=standard
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=1G
#SBATCH --time=72:00:00

module load Boost
module load Perl/5.30.2-GCCcore-9.3.0
module load

export PATH=~/Software/MaSuRCA-3.4.2/bin:$PATH

polca.sh -a genome.fasta -r 'reads1.fastq reads2.fastq.gz' -t 16 -m 1G
