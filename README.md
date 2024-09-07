# RNA-Seq分析工具

这是一个用于批量处理RNA-Seq数据的程序。本工具旨在帮助生物信息学者和研究人员自动化地处理RNA序列数据，适用于各种规模的研究。它支持从数据清洗到差异表达分析的整个流程。

## 功能特点

- **数据预处理**：质量控制、去除污染读段、修剪和过滤。
- **数据映射**：支持STAR、HISAT2等映射工具，将读段映射到参考基因组。
- **表达量估计**：使用HTSeq-count或featureCounts进行基因和转录本的表达量估计。
- **差异表达分析**：集成DESeq2和edgeR，进行差异表达基因分析。
- **可视化输出**：生成图形和表格，以直观展示分析结果。

## 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/your-repository/rna-seq-analysis-tool.git

# 进入项目目录
cd rna-seq-analysis-tool

# 安装依赖
pip install -r requirements.txt
