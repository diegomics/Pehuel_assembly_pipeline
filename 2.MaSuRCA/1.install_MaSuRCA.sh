#!/bin/bash
cd ~/Software
wget https://github.com/alekseyzimin/masurca/releases/download/v4.0.6/MaSuRCA-4.0.6.tar.gz
tar -xvzf MaSuRCA-4.0.6.tar.gz
rm MaSuRCA-4.0.6.tar.gz
cd MaSuRCA-4.0.6
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
module load GCC/10.2.0
module load GCCcore/10.2.0
module load Perl/5.32.0-GCCcore-10.2.0
module load Boost/1.74.0-GCC-10.2.0
./install.sh |& tee install_log.txt
