# igv-snapshot
Snapshot IGV with batch file


### 1. Prepration

* gene coordinate tsv file
![paper](https://github.com/mayupsc/figures_in_ReadMe/blob/master/Selection_008.png)
* adjusted gene coordinate file
![paper](https://github.com/mayupsc/figures_in_ReadMe/blob/master/Selection_011.png)

ps:I get these files via Rscript interest_gene_coor.R, a script that means to extract gene coordinate from gff file.

* region batch file(show DMRs around genes of interest,which could be get by overlaping DMRs with gene coordinate file)
```
bedtools intersect -wa -a stress_gene_coor.bed -b Dml1_Dml2_merge.bed | sort -k1,1 -k2,2n|uniq> DMR_stress_gene_overlap.bed
sed 's/^/region/g' DMR_stress_gene_overlap.bed > DMR_stress_gene_overlap.sh
```
![paper](https://github.com/mayupsc/figures_in_ReadMe/blob/master/Selection_010.png)

* snapshot batch file(run IGV_batch.sh)
![paper](https://github.com/mayupsc/figures_in_ReadMe/blob/master/Selection_012.png)
```
./IGV_batch.sh
```


### 2. Load files into IGV
open IGV -> tools -> Run Batch Script -> open load_files.sh

### 3. Change paramters like data range, track color, track height and so on

### 4. Annote DMRs
open IGV -> tools -> Run Batch Script -> open DMR_stress_gene_overlap.sh

### 5. Snapshot
open IGV -> tools -> Run Batch Script -> open igv_batch_script_${sample}.sh

