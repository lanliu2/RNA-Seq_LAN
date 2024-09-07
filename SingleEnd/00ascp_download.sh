#!/bin/sh
### 下载SRA二代测序数据，获取SRR号和GSM的对应关系 ###

#创建fastq文件保存目录
mkdir -p fastq
cd fastq
#获取fastq格式文件的下载链接
cat ../srrnum2.txt | while read srr
do
    wget -O ${srr}.fq.json "https://www.ebi.ac.uk/ena/portal/api/filereport?result=read_run&fields=fastq_ftp&format=JSON&accession="$srr

    sed 's/,/\n/g' ${srr}.fq.json | sed 's/}/\n/g' | grep fastq  | cut -f2 -d":" | sed 's/"//g' >> ${srr}.fq.link
done
#指定命令内容
myascp="/home/lcl/miniconda3/envs/scrna/bin/ascp -QT -l 300m -P33001 -i /home/lcl/miniconda3/envs/scrna/etc/asperaweb_id_dsa.openssh "
#执行命令
sed 's/;/\n/g' *link | sed 's/ftp.sra.ebi.ac.uk/era-fasp@fasp.sra.ebi.ac.uk:/g' | while read line
do
        while ! $myascp $line .
        do
                echo Faild and Retry
        done
done

#删除生成的中间文件.fq.link和.fq.json
#rm *.fq.link
#rm ../*.fq.json

#安装aspera--ascp
#conda install -c hcc aspera-cli=3.9.1 -y
#/RAID6_48T/hqy/software3/anaconda3/bin/ascp -QT -l 300m -P33001 -i /RAID6_48T/hqy/software3/anaconda3/etc/asperaweb_id_dsa.openssh  .
#ascp下载（注意：文件较大（Gb级），下载速度约21Mb/s，下载速度不够时可尝试全路径调用ascp）
# ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR164/070/SRR16480170/SRR16480170.fastq.gz . --file-manifest=GSMtest.SRR16480170.fastq.gz

