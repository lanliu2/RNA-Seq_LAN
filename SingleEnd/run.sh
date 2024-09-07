#!/bin/bash
#sh 00ascp_download.sh
#sh 01trimQC.sh
sh 02hisat2mapping.sh
sh 03sam2bam.sh
sh 04stringtie_count.sh
