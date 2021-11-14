#!/bin/bash

#SBATCH -J masurca
#SBATCH -o ../stdout/masurca.%j.out
#SBATCH -e ../stderr/masurca.%j.err
##SBATCH -D 

#SBATCH --mail-type=ALL
#SBATCH --mail-user=..@...

#SBATCH --partition=begendiv,main
#SBATCH --qos=standard
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=8G
#SBATCH --time=48:00:00

module load GCC/10.2.0
module load GCCcore/10.2.0
module load Perl/5.32.0-GCCcore-10.2.0
module load Boost/1.74.0-GCC-10.2.0

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=~/Software/MaSuRCA-3.4.2/bin:$PATH

cd ../Condor_project/Pehuel/intermediates/masurca/PE
bash assemble.sh
