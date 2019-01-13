#!/usr/bin/env Rscript

# Written by Karolis Uziela in 2019

library(wCorr)

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]

script_name <- basename(sub(".*=", "", commandArgs()[4]))

# ---------------------- Main script ------------------------- #

#write(paste(script_name, "is running with arguments:"), stderr())
write(paste(" ", cargs), stderr())
#write("----------------------- Output ---------------------", stderr())

stats <- read.table(input_file, head=F)
colnames(stats) <- c("model", "predicted_score", "real_score")
stats$target <- gsub("TS.*$", "", stats$model)

targets <- unique(stats$target)

wcorr_pearson_sum = 0
wcorr_spearman_sum = 0
corr_pearson_sum = 0
corr_spearman_sum = 0

for (target in targets) {
    #print(target)
    stats_target <- stats[stats$target == target,]
    wcorr_pearson = weightedCorr(stats_target$predicted_score, stats_target$real_score, method="Pearson", weights=stats_target$real_score)
    wcorr_spearman = weightedCorr(stats_target$predicted_score, stats_target$real_score, method="Spearman", weights=stats_target$real_score)
    corr_pearson = cor(stats_target$predicted_score, stats_target$real_score, method="pearson")
    corr_spearman = cor(stats_target$predicted_score, stats_target$real_score, method="spearman")
    if (is.finite(wcorr_pearson)) {
        wcorr_pearson_sum = wcorr_pearson_sum + wcorr_pearson
    }
    if (is.finite(wcorr_spearman)) {
        wcorr_spearman_sum = wcorr_spearman_sum + wcorr_spearman
    }
    if (is.finite(corr_pearson)) {
        corr_pearson_sum = corr_pearson_sum + corr_pearson
    }
    if (is.finite(corr_spearman)) {
        corr_spearman_sum = corr_spearman_sum + corr_spearman
    }
    #print(wcorr_pearson_sum)
    #print(nrow(stats_target))
    #print(stats_target)
    #print("--------")
}
#wCorr(stats$score, stats$lddt, method="Pearson")

#print("result:")
N = length(targets)
cat(wcorr_pearson_sum/N, N,  file=paste(input_file, ".wpearson", sep=""), sep="\t")
cat(wcorr_spearman_sum/N, N, file=paste(input_file, ".wspearman", sep=""), sep="\t")
cat(corr_pearson_sum/N, N,  file=paste(input_file, ".pearson", sep=""), sep="\t")
cat(corr_spearman_sum/N, N, file=paste(input_file, ".spearman", sep=""), sep="\t")

#write(paste(script_name, "is done."), stderr())
