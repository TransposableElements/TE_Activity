out_path="/dsk2/user/lit/WorkSpace/sc_TE/AD/1_arc"
ref_path="/dsk2/user/lit/WorkSpace/ref/sc/refdata-cellranger-arc-GRCh38-2024-A/"

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
    TMP_path="/dsk2/user/lit/WorkSpace/sc_TE/AD/TMP/${ID}"
    rm -rf "${TMP_path}"
    mkdir -p "${TMP_path}"
    cd "${TMP_path}"
    
    outdir="${out_path}/${ID}"
    csv_file="/public5/LT/TE_sc/AD/files/csv/${ID}.csv"
    
    rm -rf "${outdir}"
    
    /dsk2/user/lit/SomeAPP/cellranger-arc-2.1.0/cellranger-arc count \
        --id="${ID}" \
        --reference="${ref_path}" \
        --libraries="${csv_file}" \
        --create-bam=false \
        --jobmode='local' \
        --localcores=16 \
        --localmem=100 \
        --output-dir="${outdir}" \
        --disable-ui
done

echo DONE



out_path="/dsk2/user/lit/WorkSpace/sc_TE/AD/2_aggr"
ref_path="/dsk2/user/lit/WorkSpace/ref/sc/refdata-cellranger-arc-GRCh38-2024-A/"

ID="AD"

TMP_path="/dsk2/user/lit/WorkSpace/sc_TE/AD/TMP/${ID}"
rm -rf "${TMP_path}"
mkdir -p "${TMP_path}"
cd "${TMP_path}"

outdir="${out_path}/${ID}"
csv_file="/dsk2/user/lit/WorkSpace/sc_TE/AD/code/aggr.csv"

rm -rf "${outdir}"

/dsk2/user/lit/SomeAPP/cellranger-arc-2.1.0/cellranger-arc aggr \
    --id="${ID}" \
    --reference="${ref_path}" \
    --csv="${csv_file}" \
    --jobmode='local' \
    --localcores=32 \
    --localmem=100 \
    --output-dir="${outdir}" \
    --disable-ui

echo DONE