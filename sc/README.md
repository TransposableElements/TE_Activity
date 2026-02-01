- 0_starsolo: Single-cell–level TE quantification was performed using STARsolo.
  -  Note: Depending on the library chemistry (e.g., 10x Chromium Single Cell 3’ v2, 10x Chromium Single Cell 3’ v3, 10x Chromium Single Cell Multiome),please configure the corresponding cell barcode (CB) and UMI settings, and provide the appropriate whitelist file, etc.  
<img width="828" height="349" alt="图片" src="https://github.com/user-attachments/assets/7a166f8c-0e3b-4ba9-a4f7-44b87434d0fd" />
<img width="710" height="413" alt="图片" src="https://github.com/user-attachments/assets/e387f33b-bad7-4cd6-94e4-eb4e1f2e5462" />

- 1_cellranger: Gene expression was quantified using Cell Ranger for standard downstream single-cell transcriptomic analyses, which is required for cell-type annotation.
  -  TE and gene quantification should be performed using different mapping criteria: TE quantification typically requires more permissive multi-mapping settings because many TEs are short, whereas excessive multi-mapping can compromise the specificity of gene quantification.    
- 2_TE_quantification(https://github.com/bodegalab/irescue.git)
  -  BAM file sorted by coordinate, indexed and annotated with cell barcode.    
  -  A custom repeats annotation can be provided in BED format.
  -  If you already obtained gene-level counts (using STARsolo, Cell Ranger, Alevin, Kallisto or other tools), it is advised to provide the whitelisted cell barcodes list as a text file. This will significantly improve performance by processing viable cells only.    

