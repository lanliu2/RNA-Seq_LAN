#将下载目录中的.sra文件从/raw/sra/idname/.sra下移动到/raw/sra/.sra
#并将idname目录删除
rootpath=$PWD
#创建一个新的fq文件夹保存拆分好的fastq文件
mkdir -p $rootpath/raw/fq/
cd $rootpath/raw/fq/
ls  $rootpath/raw/sra/*.sra |while read id 
do
echo " PROCESS $(basename $id) "
fasterq-dump --split-3 -e 12 -O ./ $id
pigz -p 12   $rootpath/raw/fq/*q
done

