#!/bin/bash
cd ~/Software
wget https://github.com/alekseyzimin/masurca/releases/download/v3.4.2/MaSuRCA-3.4.2.tar.gz
tar -xvzf MaSuRCA-3.4.2.tar.gz
rm MaSuRCA-3.4.2.tar.gz
cd MaSuRCA-3.4.2
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
module load GCC/8.3.0
module load GCCcore/8.3.0
module load Perl/5.30.0-GCCcore-8.3.0
module load Boost/1.71.0-gompic-2019b
./install.sh |& tee install_log.txt
