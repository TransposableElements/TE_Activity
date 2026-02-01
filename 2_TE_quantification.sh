source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate irescue

set -euo pipefail

if [ -e "/public7/LT/irescue/ref/GRCh38_GENCODE_rmsk_TE.bed.sorted" ]; then
    echo "pass"
else
    sort -k 1,1 -k2,2n "/public7/LT/irescue/ref/GRCh38_GENCODE_rmsk_TE.bed" > "/public7/LT/irescue/ref/GRCh38_GENCODE_rmsk_TE.bed.sorted"
fi

tmp_path="/dsk2/user/lit/WorkSpace/sc_TE/irescue/TMP"

sample_list=(
    'Case1' 
    'Case2' 
    'Case3' 
    'Case4' 
    'Case5' 
    'Case6' 
    'Case7' 
    'Case8v1' 
    'Case8v2' 
    'Case9' 
    'Control1' 
    'Control10' 
    'Control2' 
    'Control3' 
    'Control4' 
    'Control5' 
    'Control6' 
    'Control7' 
    'Control8v1' 
    'Control8v2' 
    'Control9v1' 
    'Control9v2'  
)

ref_bed="/public7/LT/irescue/ref/GRCh38_GENCODE_rmsk_TE.bed.sorted"


for ID in "${sample_list[@]}" ; do
    echo "${ID}"

    input_bam="/dsk2/user/lit/WorkSpace/star_solo/AD/results/${ID}/${ID}Aligned.sortedByCoord.out.bam"
    out_dir="/dsk2/user/lit/WorkSpace/sc_TE/irescue/AD/outputs/${ID}"
    
    white_arc="/dsk2/user/lit/WorkSpace/sc_TE/AD/bc/${ID}_barcodes.tsv"

    if [ -d "${out_dir}" ]; then
        rm -rf "${out_dir}"
    else
        echo pass
    fi

    irescue \
        -b "${input_bam}" \
        -g GRCh38 \
        -w "${white_arc}" \
        -p 30 \
        -o "${out_dir}" \
        --integers \
        --samtools /dsk2/user/lit/miniforge3/envs/irescue/bin/samtools \
        --bedtools /dsk2/user/lit/miniforge3/envs/irescue/bin/bedtools \
        -r "${ref_bed}" \
        -vv \
        --keeptmp \
        --locus \
        --max-iters 1000


done

echo Done