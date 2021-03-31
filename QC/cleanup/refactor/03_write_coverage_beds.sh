#!/bin/bash
#SBATCH -J covBeds
#SBATCH -o logs/out_%j
#SBATCH -e logs/err_%j
#SBATCH -p shared
#SBATCH -n 1
#SBATCH -t 24:00:00
#SBATCH --mem=8000

# sbatch write_coverage_beds.sh spp_name

set -o errexit

mean=$(awk '{sum = sum+$4}{size=size+$2}{avg=sum/size}END{print avg}' $1/$1.summary.tab)

gzip -dc $1/$1.merge.bg.gz | awk -v avg="$mean" -v spp=$1 -f ./sum_cov.awk
