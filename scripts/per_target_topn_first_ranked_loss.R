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

losses <- NULL

N = length(targets)
for (n in seq(10,150,10)) {
    loss_sum <- 0
    #print("n:")
    #print(n)
    for (target in targets) {
        #print(target)
        stats_target <- stats[stats$target == target,]
        stats_target <- stats_target[order(-stats_target$real_score),]
        stats_topn <- head(stats_target, n)
        first_ranked <- stats_topn[rank(-stats_topn$predicted_score,ties.method="last") == 1,]$real_score
        #print(stats_topn)
        #print(stats_topn[rank(-stats_topn$predicted_score,ties.method="last") == 1,])
        best <- max(stats_topn$real_score)
        loss_sum <- loss_sum + best - first_ranked  
        #print("--------")
    }
    average_loss <- loss_sum / N
    #print(average_loss)
    #print("=================")
    losses <- c(losses, average_loss)
}
#wCorr(stats$score, stats$lddt, method="Pearson")

cat(losses, N,  file=paste(input_file, ".topn_average_losses", sep=""), sep="\t")

#write(paste(script_name, "is done."), stderr())
