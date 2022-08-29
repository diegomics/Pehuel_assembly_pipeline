#Usage: python filter_contigs.py contigs_file min_contig_length max_N_content > filtered_file
from Bio import SeqIO
import sys
CONTIGS_FILE = open(sys.argv[1], "r")
PARSED_CONTIGS_FILE = SeqIO.parse(CONTIGS_FILE, "fasta")
counter = 0
for CONTIG in PARSED_CONTIGS_FILE:
	if ( len(CONTIG.seq) >= int(sys.argv[2]) ) and ( ( float( CONTIG.seq.count("N") ) / len(CONTIG.seq) ) * 100 ) <= int(sys.argv[3]):
		print(">" + CONTIG.id)
		print(CONTIG.seq)
		counter += 1
