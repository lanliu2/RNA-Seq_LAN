#!/bin/bash
mkdir -p  quan_salmon
cd quan_salmon
parallel 'mkdir -p {} && salmon quant -i index_salmon -l A -1 ../rawdata/{}_1.fq.gz -2 ./rawdata/{}_2.fq.gz -o {}' ::: SRR1524238 SRR1524239 SRR1524240 SRR1524241 SRR1524242 SRR1524243 SRR1524244 SRR1524245 SRR1524246 SRR1524247 SRR1524248 SRR1524249

