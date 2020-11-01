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
#SBATCH --mem-per-cpu=8G
#SBATCH --time=48:00:00

module load GCC/8.3.0
module load GCCcore/8.3.0
module load Perl/5.30.0-GCCcore-8.3.0
module load Boost/1.71.0-gompic-2019b

export PATH=~/Software/MaSuRCA-3.4.2/bin:$PATH

bash ~/assemble.sh
