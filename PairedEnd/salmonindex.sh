#!/bin/bash
salmon index -t /RAID5_32T/lcl/study/reference/lab_zebrafish/Danio_rerio.GRCz11.Ig.MUC.dna.alt.fa -i index_salmon -p 30
#salmon quant -i athal_index -l A -1 samp_1.fastq.gz -2 samp_2.fastq.gz -p 8 -o quants/sample_quant
