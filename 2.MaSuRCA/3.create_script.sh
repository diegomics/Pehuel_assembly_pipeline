module load GCC/10.2.0
module load GCCcore/10.2.0
module load Perl/5.32.0-GCCcore-10.2.0
module load Boost/1.74.0-GCC-10.2.0
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
cd ../Condor_project/Pehuel/intermediates/masurca/PE
../Software/MaSuRCA-4.0.6/bin/masurca config.txt
