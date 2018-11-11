samples="ET ABA JA Multiple_ABA_JA_SA Multiple_ABA_SA Multiple_ET_ABA SA"
for sample in ${samples}
do
	dir=/home/galaxy/Desktop/sqwu/IGV_${sample}
	batch_script=${dir}/igv_batch_script_${sample}.sh
	gene_coor=/home/galaxy/Desktop/sqwu/${sample}.tsv
	sort="sort position\\n"
	mkdir ${dir}
	#touch $batch_script
	echo -e "snapshotDirectory ${dir}\\n" > ${batch_script}
	collapse="collapse\\n"
	snapshot="snapshot"
	for coordinate in $(cat $gene_coor)
	do
		goto="goto $coordinate\\n"
		echo -e $goto$sort$collapse$snapshot >> ${batch_script}
	done
	chmod +x $batch_script
done
