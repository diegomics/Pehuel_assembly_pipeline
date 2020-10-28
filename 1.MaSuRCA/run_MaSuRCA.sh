#!/bin/bash

#SBATCH --job-name=MaS
#SBATCH -o ~/stdout/MaS.%j.out
#SBATCH -e ~/stderr/MaS.%j.err
#SBATCH -D ~/Assemblies/MaS

#SBATCH --mail-type=ALL
#SBATCH --mail-user=123@abc.de

#SBATCH --partition=begendiv,main
##SBATCH -w b001
#SBATCH --qos=standard
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=13G
#SBATCH --time=72:00:00

module load Boost
module load Perl/5.30.2-GCCcore-9.3.0

export PATH=~/Software/MaSuRCA-3.4.2/bin:$PATH

bash ~/assemble.sh
