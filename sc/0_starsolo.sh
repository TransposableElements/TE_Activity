source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate starsolo
shopt -s nullglob
set -Eeuo pipefail


index="/dsk2/who/LT_1026/ref/hg38/index"
whitelist="/public7/LT/irescue/whitelist/737K-arc-v1.txt"

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

for ID in "${sample_list[@]}" ; do

    fq_path="/public5/LT/TE_sc/AD/files/0_fq/RNA"
    out_path="/dsk2/user/lit/WorkSpace/star_solo/AD/results/${ID}"
    tmp_path="/dsk2/user/lit/WorkSpace/star_solo/AD/TMP/${ID}"

    
    r1=( "${fq_path}/${ID}/${ID}"*R1_001.fastq.gz )
    r2=( "${fq_path}/${ID}/${ID}"*R2_001.fastq.gz )

    r1_1="${r1[0]}"
    r2_1="${r2[0]}"

    if [ -d "${out_path}" ]; then 
        rm -rf "${out_path}"
    else
        echo pass
    fi
    mkdir -p "${out_path}"
    rm -rf "${tmp_path}"

    STAR \
        --genomeDir "${index}" \
        --runThreadN 20 \
        --outSAMattributes NH HI nM AS CR UR CY UY CB UB GX GN sS sQ sM \
        --outFilterMultimapNmax 500 \
        --winAnchorMultimapNmax 500 \
        --outMultimapperOrder Random \
        --soloType CB_UMI_Simple \
        --soloCBwhitelist "${whitelist}" \
        --readFilesIn \
            "${r2_1}" \
            "${r1_1}" \
        --readFilesCommand 'gzip -c -d' \
        --clipAdapterType CellRanger4 \
        --soloMultiMappers EM \
        --soloFeatures GeneFull_Ex50pAS \
        --soloCellReadStats Standard \
        --outFileNamePrefix "${out_path}/${ID}" \
        --outSAMtype BAM SortedByCoordinate \
        --soloBarcodeReadLength 0 \
        --outTmpDir "${tmp_path}" \
        --soloCBstart 1 --soloCBlen 16 --soloUMIstart 17 --soloUMIlen 12 \
        --soloCBmatchWLtype 1MM_multi_Nbase_pseudocounts \
        --soloUMIfiltering MultiGeneUMI_CR \
        --soloUMIdedup 1MM_CR

    echo "${ID}"
done

echo "All done!"


