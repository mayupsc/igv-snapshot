gff <- read.table("~/genome/SL3.0/ITAG3.2_gene_models.gff",quote = "",sep = "\t",stringsAsFactors = F)
#gtf <- read.table("~/genome/SL3.0/ITAG3.2.gtf",quote = "",sep = "\t")
gene_list <- read.csv("~/Desktop/sqwu/Hormone genes.csv",sep = ",",stringsAsFactors = F)
gff <- gff[gff$V3=="gene",]
gff$V10 <- apply(gff,1,function(x){strsplit(x[9],split = ";")[[1]][2]})
gff$V10 <- gsub("Alias=","",gff$V10)


gene_list <- gene_list[-1,]
gene_list <- gene_list[substring(gene_list$Tomato.Accession,1,5)=="Solyc",]
stress_gene_list <- gene_list[,c(1,4)]
stress_gene_coor <- gene_list[,c(1,4)]
stress_gene_list$pos <- NA
stress_gene_coor$chr <- NA
stress_gene_coor$start <- NA
stress_gene_coor$end <- NA

for (i in 1:nrow(stress_gene_list)) {
  pos_index <- which(gff$V10==stress_gene_list$Tomato.Accession[i])
 
    stress_gene_list$pos[i] <- paste0(gff$V1[pos_index],":",as.numeric(gff$V4[pos_index])-2000,"-",as.numeric(gff$V5[pos_index])+2000)
    stress_gene_coor$chr[i] <- gff$V1[pos_index]
    stress_gene_coor$start[i] <- as.numeric(gff$V4[pos_index])-2000
    stress_gene_coor$end[i] <- as.numeric(gff$V5[pos_index])+2000
}


stress_gene_list$Hormone <- as.factor(stress_gene_list$Hormone)
Hormone_levels <- levels(stress_gene_list$Hormone)
stress_gene_coor <- stress_gene_coor[,-c(1,2)]
write.table(stress_gene_coor,"stress_gene_coor.bed",sep = "\t",row.names = F,col.names = F,quote = F)

for (j in 1:length(Hormone_levels)) {
  hormone <- Hormone_levels[j]
  table <- stress_gene_list[stress_gene_list$Hormone==hormone,]
  table <- table[which(table$pos!=":-"),]
  table$Hormone <- NULL
  table$Tomato.Accession <- NULL
  write.table(table,paste0("~/Desktop/sqwu/",gsub(" |/","_",hormone),".tsv"),sep = "\t",col.names = F,row.names = F,quote = F)
}