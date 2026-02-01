source  /home/lit/miniforge3/etc/profile.d/conda.sh
conda activate ExplorATE

input_path="/public3/gtex/adipose-subcutaneous"
out_path="/public5/LT/TE_bulk/gtex/qc/adipose-subcutaneous/fq"
log_path="/public5/LT/TE_bulk/gtex/qc/adipose-subcutaneous/log"


cat /public5/LT/TE_bulk/gtex/samples/adipose_subcutaneous_list1 | while read id ; do

    fq_1_in="${input_path}/${id}_1.fastq.gz"
    fq_2_in="${input_path}/${id}_2.fastq.gz"
    fq_1_out="${out_path}/${id}_R1.fastq.gz"
    fq_2_out="${out_path}/${id}_R2.fastq.gz"

    fastp \
        -i  "${fq_1_in}"  \
        -I  "${fq_2_in}"  \
        -o  "${fq_1_out}" \
        -O  "${fq_2_out}" \
        -j "${log_path}/${id}.json" \
        -h "${log_path}/${id}.html" \
        -R "${id}" \
        -w  16
    echo "${id}"
    
done

echo "All done"