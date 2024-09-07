#!/bin/bash
#使用sra-tools中的prefetch下载sra，下载成功的文件会保存为一个目录，
#目录下仅有一个.sra文件，如果有多余的文件可能说明没下载成功
rootpath=$PWD
mkdir -p $PWD/raw/sra/
cd $PWD/raw/sra/

cat  $rootpath/srrnum.txt | while read id ; \
do
      ( prefetch -O ./ $id & )
done
echo "successfully download!!!"
exit 0

#将下载目录中的.sra文件从/raw/sra/idname/.sra下移动到/raw/sra/.sra
#并将idname目录删除
cd $rootpath/raw/sra/
cat $rootpath/srrnum.txt | while read id
do
mv $id/*  ./
rm -rf $id/
done

#创建一个新的fq文件夹保存拆分好的fastq文件
mkdir -p $rootpath/raw/fq/
cd $rootpath/raw/fq/
ls  $rootpath/raw/sra/*.sra |while read id 
do
echo " PROCESS $(basename $id) "
fasterq-dump -3 -e 12 -O ./ $id
pigz -p 12   $rootpath/raw/fq/*q
done
