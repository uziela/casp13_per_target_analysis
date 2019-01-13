#!/bin/bash

# Commands needed to reproduce topn graph plotting
for i in TSV_input/*tsv ; do Rscript scripts/per_target_topn_corr.R $i ; done
for cor_type in topn_pearson topn_spearman ; do
    ./scripts/make_table.sh TSV_input $cor_type topn_out
done
./scripts/sort_and_rename.sh topn_out topn_sorted_out
for i in topn_sorted_out/* ; do base=`basename $i`; ./scripts/grep_ours.sh $i >topn_sorted_ours_out/$base; done
for i in topn_sorted_ours_out/*tsv ; do Rscript scripts/plot_topn_graph.R $i $i.pdf; done

# Commands needed to reproduce weighted correlation calculations
for i in TSV_input/*tsv ; do Rscript scripts/per_target_wcorr.R $i
for cor_type in spearman wspearman pearson wpearson ; do
    ./scripts/make_table.sh TSV_input $cor_type corw_out
done
./scripts/sort_and_rename.sh corw_out corw_sorted_out
