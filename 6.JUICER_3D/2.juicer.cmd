module load BWA/0.7.17-foss-2018b; module load SAMtools/1.9-foss-2018b; module load Java/1.8.0_192; module load CUDA/10.0.130

bash ../Condor_project/Pehuel/intermediates/juicer/scripts/juicer.sh -d ../Condor_project/Pehuel/intermediates/juicer/work/PEHUEL.s1 -g PEHUEL.s1 -z ../Condor_project/Pehuel/intermediates/juicer/references/PEHUEL.s1.fa -s MboI -y ../Condor_project/Pehuel/intermediates/juicer/restriction_sites/PEHUEL.s1_MboI.txt -p ../Condor_project/Pehuel/intermediates/juicer/restriction_sites/PEHUEL.s1_chrom.sizes -S early -t 32 -A begendiv
