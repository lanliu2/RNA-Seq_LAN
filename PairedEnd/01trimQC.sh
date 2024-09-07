#!/bin/bash
#setting the outdir
mkdir -p trimqc
cd trimqc
#trim the sequence
while read srr
do
	trimmomatic PE -phred33 -threads 30 \
		../fastq/${srr}_1.fastq.gz ../fastq/${srr}_2.fastq.gz \
		${srr}_clean_1.fastq.gz ${srr}_unpaired_1.fastq.gz \
		${srr}_clean_2.fastq.gz ${srr}_unpaired_2.fastq.gz \
		SLIDINGWINDOW:3:15 LEADING:3 TRAILING:3

done < ../srrnum.txt
cd ..
# 创建输出目录
mkdir -p qcfastq
cd qcfastq
# 使用parallel运行fastqc，可以指定同时运行的任务数
ls ../trimqc/* | parallel -j 12 fastqc -t 1 -o ./ {}

# 生成multiqc报告
multiqc ./

