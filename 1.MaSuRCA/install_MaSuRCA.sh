#!/bin/bash
cd ~/Software
wget https://github.com/alekseyzimin/masurca/releases/download/v3.4.2/MaSuRCA-3.4.2.tar.gz
tar -xvzf MaSuRCA-3.4.2.tar.gz
rm MaSuRCA-3.4.2.tar.gz
cd MaSuRCA-3.4.2
module load Boost
module load Perl/5.30.2-GCCcore-9.3.0
./install.sh
