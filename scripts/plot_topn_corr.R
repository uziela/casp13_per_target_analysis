#!/usr/bin/env Rscript

# Written by Karolis Uziela in 2017

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]
output_file <- cargs[2]

script_name <- basename(sub(".*=", "", commandArgs()[4]))

# ---------------------- Main script ------------------------- #

write(paste(script_name, "is running with arguments:"), stderr())
write(paste(" ", cargs), stderr())
write("----------------------- Output ---------------------", stderr())

stats <- read.table(input_file, row.names=1, head=F)

#methods <- stats$V1
#duplicated(methods)
#print(methods)
stats <- stats[,-16]
topn <- seq(10,150,10)
colnames(stats) <- topn
#head(stats)

N = nrow(stats)

stats <- stats[order(rownames(stats)),]
stats$AUC <- rowSums((stats[,-1] + stats[,-15])) / 2 / 15
stats$pch <- 1:N
stats$col <- rep(c(1:6,8),3)[1:N] # skip yellow (id=7)
stats <- stats[order(-stats$AUC),]
#head(stats)

#pdf(output_file)
#tiff(file = output_file, width = 4000, height = 4000, units = "px", res = 600)
tiff(file = output_file, width = 2500, height = 2500, units = "px", res = 350)
plot(topn, stats[1,1:15], type="n", xlim=c(10,150), ylim=c(min(stats[,1:15]),max(stats[,1:15])), ylab="Correlation", xlab="Top N models", xaxt='n')
axis(1, at=topn, labels=topn, las=2)
for (i in 1:N){
    lines(topn, stats[i,1:15], type="b", col=stats[i,'col'], lty=2, pch=stats[i,'pch'])
}
labels <- paste(rownames(stats), " (AUC = ", round(stats$AUC,2), ")", sep="")
legend("bottomright",labels, lty=2, pch=stats$pch, cex=0.5, col=stats$col)
dev.off()

write(paste(script_name, "is done."), stderr())
