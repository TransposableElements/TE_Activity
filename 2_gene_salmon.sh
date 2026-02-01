source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate RNAseq

cat /public5/LT/TE_bulk/gtex/samples/adipose_subcutaneous_list1 | while read id ; do
    echo "${id}"
    fq_1="/public5/LT/TE_bulk/gtex/qc/adipose-subcutaneous/fq/${id}_R1.fastq.gz"
    fq_2="/public5/LT/TE_bulk/gtex/qc/adipose-subcutaneous/fq/${id}_R2.fastq.gz"
    out_path="/public5/LT/TE_bulk/gtex/gene/adipose-subcutaneous/${id}_quant"
    salmon quant \
        -i /public0/LT/gtex_TE/ref/salmon/human/hg38_salmon_index \
        --libType A \
        -1 "${fq_1}" \
        -2 "${fq_2}" \
        -o "${out_path}" \
        -p 40 
done

echo Done
