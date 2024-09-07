#!/bin/bash

# 创建输出目录
mkdir -p qcfastq
cd qcfastq
# 使用parallel运行fastqc，可以指定同时运行的任务数
ls ./fastq/* | parallel -j 12 fastqc -t 1 -o ./qcfastq {}

# 生成multiqc报告
multiqc ./

