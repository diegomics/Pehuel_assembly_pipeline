#!/usr/bin/awk -f
##########
#The MIT License (MIT)
#
# Copyright (c) 2015 Aiden Lab
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
##########

# Dedup script that submits deduping jobs after splitting at known 
# non-duplicate
# Juicer version 1.5
BEGIN{
    tot=0;
    name=0;
}
{
    if (tot >= 1000000) {
	if (p1 != $1 || p2 != $2 || p4 != $4 || p5 != $5 || p8 != $8) {
	    sname = sprintf("%s_msplit%04d_", groupname, name);
	    sscriptname = sprintf("%s/.%s.slurm", debugdir, sname);
	    if (justexact) {
		printf("#!/bin/bash -l\n#SBATCH -o %s/dup-split-%s.out\n#SBATCH -e %s/dup-split-%s.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;awk -f %s/scripts/dups.awk -v nowobble=1 -v name=%s/%s %s/split%04d;\necho Reads:%s\ndate\n", debugdir, name, debugdir, name, queue, groupname, juicedir, dir, sname, dir, name, tot) > sscriptname;
	    }
	    else {
		printf("#!/bin/bash -l\n#SBATCH -o %s/dup-split-%s.out\n#SBATCH -e %s/dup-split-%s.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;awk -f %s/scripts/dups.awk -v name=%s/%s %s/split%04d;\necho Reads:%s\ndate\n", debugdir, name, debugdir, name, queue, groupname, juicedir, dir, sname, dir, name, tot) > sscriptname;
	    }
	    sysstring = sprintf("sbatch %s", sscriptname);
	    system(sysstring);
	    outname = sprintf("%s/split%04d", dir, name);
	    close(outname);
	    close(sscriptname);
	    
	    name++;
	    tot=0;
	}
    }
    outname = sprintf("%s/split%04d", dir, name);
    print > outname;
    p1=$1;p2=$2;p4=$4;p5=$5;p6=$6;p8=$8;
    tot++;
}
END {
    sname = sprintf("%s_msplit%04d_", groupname, name);
    sscriptname = sprintf("%s/.%s.slurm", debugdir, sname);
    if (justexact) {
	printf("#!/bin/bash -l\n#SBATCH -o %s/dup-split-%s.out\n#SBATCH -e %s/dup-split-%s.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;awk -f %s/scripts/dups.awk -v nowobble=1 -v name=%s/%s %s/split%04d;\necho Reads:%s\ndate\n", debugdir, name, debugdir, name, queue, groupname, juicedir, dir, sname, dir, name, tot) > sscriptname;
    }
    else {
	printf("#!/bin/bash -l\n#SBATCH -o %s/dup-split-%s.out\n#SBATCH -e %s/dup-split-%s.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;awk -f %s/scripts/dups.awk -v name=%s/%s %s/split%04d;\necho Reads:%s\ndate\n", debugdir, name, debugdir, name, queue, groupname, juicedir, dir, sname, dir, name, tot) > sscriptname;
    }
    sysstring = sprintf("sbatch %s", sscriptname);
    system(sysstring);
    close(sscriptname);

    sscriptname = sprintf("%s/.%s_msplit.slurm", debugdir, groupname);
    printf("#!/bin/bash -l\n#SBATCH -o %s/dup-merge.out\n#SBATCH -e %s/dup-merge.err\n#SBATCH --mem=50G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -d singleton\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;\necho \"\"; cat %s/%s_msplit*_optdups.txt > %s/opt_dups.txt;cat %s/%s_msplit*_dups.txt > %s/dups.txt;cat %s/%s_msplit*_merged_nodups.txt > %s/merged_nodups.txt;\ndate\n", debugdir, debugdir, queue, groupname, dir, groupname, dir, dir, groupname, dir, dir, groupname, dir) > sscriptname;
    sysstring = sprintf("sbatch %s", sscriptname);
    system(sysstring);
    close(sscriptname);

#	sscriptname = sprintf("%s/.%s_rmsplit.slurm", debugdir, groupname);
#	printf("#!/bin/bash -l\n#SBATCH -o %s/dup-rm.out\n#SBATCH -e %s/dup-rm.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -d singleton\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;\nrm %s/*_msplit*_optdups.txt; rm %s/*_msplit*_dups.txt; rm %s/*_msplit*_merged_nodups.txt;rm %s/split*;\ndate\n", debugdir, debugdir, queue, groupname, dir, dir, dir, dir) > sscriptname;
#	sysstring = sprintf("sbatch %s", sscriptname);
#	system(sysstring);
#	close(sscriptname);

    sscriptname = sprintf("%s/.%s_finalize.slurm", debugdir, groupname);
    printf("#!/bin/bash -l\n#SBATCH -o %s/dup-guard-trigger.out\n#SBATCH -e %s/dup-guard-trigger.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -d singleton\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\necho %s %s %s %s;\nsqueue -u %s;\ndate\n", debugdir, debugdir, queue, groupname, topDir, site, genomeID, genomePath, user, user) > sscriptname;
    sysstring = sprintf("sbatch %s", sscriptname);
    system(sysstring);
    (sysstring | getline maildupid);
    var = gensub("[^0-9]", "", "g", maildupid);
    sysstring = sprintf("scontrol update JobID=%s dependency=afterok:%s", guardjid, var);
    system(sysstring);
    close(sscriptname);
    
    sscriptname = sprintf("%s/.%s_mail.slurm", debugdir, groupname);
    printf("#!/bin/bash -l\n#SBATCH -o %s/dup-mail.out\n#SBATCH -e %s/dup-mail.err\n#SBATCH --mem=12G\n#SBATCH --qos=standard\n#SBATCH -p %s\n#SBATCH -J %s_msplit0\n#SBATCH -d singleton\n#SBATCH -t 7200\n#SBATCH -c 1\n#SBATCH --ntasks=1\ndate;\necho %s %s %s %s | mail -r aidenlab@bcm.edu -s \"Juicer pipeline finished successfully @ Voltron\" -t %s@hi-c.io;\ndate\n", debugdir, debugdir, queue, groupname, topDir, site, genomeID, genomePath, user) > sscriptname;
    sysstring = sprintf("sbatch %s", sscriptname);
    system(sysstring);
    close(sscriptname);
}

