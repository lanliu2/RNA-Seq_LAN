#!/bin/bash
#过滤掉注释文件包含transcript_id “”的行gene行
rawgtf=/RAID_32T/lcl/ref_genome/Ctenopharyngodon_idella_HZGC01/GCF_019924925.1_HZGC01_genomic.gtf
awk '!($0 ~ /transcript_id "";/)' $rawgtf > filtered.gtf
gtf=../filtered.gtf
mkdir -p stringtie
cd stringtie
ls ../sam2bam/*.bam | while read id
do
	srrnum=$(basename "$id" _sorted.bam)
	mkdir -p ${srrnum}
	stringtie -e -B -p 30 \
		-G $gtf \
		-A ./${srrnum}/${srrnum}_gene_abund.tab \
		-o ./${srrnum}/${srrnum}.gtf ../sam2bam/${srrnum}_sorted.bam

done
#parallel -j 10 stringtie -e -B -p 2 -G /RAID5_32T/lcl/study/reference/lab_zebrafish/Danio_rerio.GRCz11.98.Ig.MUC.gtf -A {/.}_gene_abund.tab -o {.}.gtf ../sam2bam/{.}_sorted.bam ::: ../sam2bam/*_sorted.bam

