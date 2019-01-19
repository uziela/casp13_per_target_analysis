#!/usr/bin/env Rscript

# Written by Karolis Uziela in 2019

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

cors_pearson <- NULL
cors_spearman <- NULL

N = length(targets)
for (n in seq(10,150,10)) {
    corr_pearson_sum <- 0
    corr_spearman_sum <- 0
    for (target in targets) {
        #print(target)
        stats_target <- stats[stats$target == target,]
        stats_target <- stats_target[order(-stats_target$real_score),]
        stats_topn <- head(stats_target, n)
        corr_pearson <- cor(stats_topn$predicted_score, stats_topn$real_score, method="pearson")
        corr_spearman <- cor(stats_topn$predicted_score, stats_topn$real_score, method="spearman")
        if (is.finite(corr_pearson)) {
            corr_pearson_sum <- corr_pearson_sum + corr_pearson
        }
        if (is.finite(corr_spearman)) {
            corr_spearman_sum <- corr_spearman_sum + corr_spearman
        }
        #print(wcorr_pearson_sum)
        #print(nrow(stats_target))
        #print(stats_target)
        #print("--------")
    }
    corr_pearson_mean <- corr_pearson_sum/N
    corr_spearman_mean <- corr_spearman_sum/N
    cors_pearson <- c(cors_pearson, corr_pearson_mean)
    cors_spearman <- c(cors_spearman, corr_spearman_mean)
}
#wCorr(stats$score, stats$lddt, method="Pearson")

#print(cors_pearson)
#print("--")
#print(cors_spearman)
#print("result:")
cat(cors_pearson, N,  file=paste(input_file, ".topn_pearson", sep=""), sep="\t")
cat(cors_spearman, N, file=paste(input_file, ".topn_spearman", sep=""), sep="\t")

#write(paste(script_name, "is done."), stderr())
