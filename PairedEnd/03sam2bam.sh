#!/bin/bash
mkdir -p sam2bam
cd sam2bam

ls ../hisat2mapping/*.sam | while read id
do
	samname=$(basename "$id")
	prefixfile=$(basename "$id" .sam)
	samtools sort -@ 12 -o  ./${prefixfile}_sorted.bam  $id
	samtools flagstat -@ 12 $id > ${prefixfile}.flagstat
done


