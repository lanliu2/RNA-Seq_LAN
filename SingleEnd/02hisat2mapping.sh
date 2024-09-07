#!/bin/bash
genome=/RAID_32T/lcl/ref_genome/Ctenopharyngodon_idella_HZGC01/GCF_019924925.1_HZGC01_genomic.fna
index=Ctenopharyngodon_idella
#gtf=/RAID5_32T/lcl/study/reference/Xenopus_laevis_Xenopus_laevis_v10.1/GCF_017654675.1_Xenopus_laevis_v10.1_genomic.gtf

#创建输出目录
mkdir -p hisat2index
cd hisat2index
hisat2-build -p 30 $genome ${index}
cd ..
mkdir -p hisat2mapping
cd hisat2mapping
#对文件执行mapping
while read id
do
	hisat2 -t -p 30 -x ../hisat2index/${index} \
	-U ../trimqc/${id}_clean.fastq.gz -S ${id}.sam
done < ../srrnum.txt


