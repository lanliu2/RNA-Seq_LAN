#!/bin/bash
#gtf=/RAID_32T/lcl/ref_genome/Ctenopharyngodon_idella_HZGC01/GCF_019924925.1_HZGC01_genomic.gtf
#因为注释文件的基因行里的transcrip_id有空的，需要去除
#命令为：awk '!($0 ~ /transcript_id "";/)' /RAID_32T/lcl/ref_genome/Ctenopharyngodon_idella_HZGC01/GCF_019924925.1_HZGC01_genomic.gtf > filtered.gtf
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

