#!/bin/bash

# Commands needed to reproduce topn plotting
#for i in TSV_input/*tsv ; do Rscript scripts/per_target_topn_corr.R $i ; done
#for i in TSV_input/*tsv ; do Rscript scripts/per_target_topn_first_ranked_loss.R $i ; done
#for cor_type in topn_pearson topn_spearman topn_average_losses ; do
#    ./scripts/make_table.sh TSV_input $cor_type topn_out
#done
#./scripts/sort_and_rename.sh topn_out topn_sorted_out
#mkdir topn_sorted_ours_out
#for i in topn_sorted_out/* ; do base=`basename $i`; ./scripts/grep_ours.sh $i >topn_sorted_ours_out/$base; done
for i in topn_sorted_ours_out/*topn_spearman.tsv topn_sorted_ours_out/*topn_pearson.tsv  ; do Rscript scripts/plot_topn_corr.R $i $i.tiff; done
for i in topn_sorted_ours_out/*topn_average_losses.tsv  ; do Rscript scripts/plot_topn_first_ranked.R $i $i.tiff; done

## Commands needed to reproduce weighted correlation calculations
#for i in TSV_input/*tsv ; do Rscript scripts/per_target_wcorr.R $i ; done
#for i in TSV_input/*tsv ; do Rscript scripts/per_target_wwcorr.R $i ; done # with squared weights
#for cor_type in spearman wspearman wwspearman pearson wpearson wwpearson ; do
#    ./scripts/make_table.sh TSV_input $cor_type corw_out
#done
#./scripts/sort_and_rename.sh corw_out corw_sorted_out
#
