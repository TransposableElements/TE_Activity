source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate starsolo

rm -rf /public5/LT/TE_bulk/gtex/te_locus/adipose-subcutaneous
mkdir -p /public5/LT/TE_bulk/gtex/te_locus/adipose-subcutaneous

bash /dsk2/user/lit/SomeAPP/ExplorATE_shell_script/ExplorATE \
    mo \
    -p 48 \
    -b /dsk2/user/lit/miniforge3/envs/starsolo/bin/bedtools \
    -s /dsk2/user/lit/miniforge3/envs/starsolo/bin/salmon \
    -f /dsk2/user/lit/WorkSpace/ref/hg38/GRCh38.p14.genome.fa \
    -g /dsk2/user/lit/WorkSpace/ref/hg38/gencode.v49.chr_patch_hapl_scaff.annotation.gtf \
    -r /dsk2/user/lit/WorkSpace/ref/rm/hg38.fa.out \
    -e pe \
    -l /public5/LT/TE_bulk/gtex/qc/adipose-subcutaneous/fq/ \
    -o /public5/LT/TE_bulk/gtex/te_locus/adipose-subcutaneous 

echo Finish

