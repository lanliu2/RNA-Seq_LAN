mkdir -p getmuc2.1to5.6
cd getmuc2.1to5.6
rm -f muc.csv  # 使用 -f 避免 'rm: cannot remove' 错误如果文件不存在
# 遍历 ../stringtie/ 目录下的文件
ls ../stringtie/ | while read file
do
        echo $file
        list=("$file")  # 初始化 list 为一个数组，包含第一个元素 file

        # 遍历所有 MUC2.x 和 MUC5.x
        for muc in MUC2.1 MUC2.2 MUC2.3 MUC2.4 MUC5.1 MUC5.2 MUC5.3 MUC5.4 MUC5.5 MUC5.6
        do
                # grep 查找 MUC 的值并提取第 8 列，追加到数组 list 中
                list+=("$(grep $muc ../stringtie/${file}/${file}_gene_abund.tab | awk -F "\t" '{print $8}')")
        done
        
        # 设置 IFS 为制表符，然后输出 list 数组
        IFS=$'\t'
        echo "${list[*]}" >> muc.csv
        unset IFS  # 重置 IFS 以避免影响后续命令
done

