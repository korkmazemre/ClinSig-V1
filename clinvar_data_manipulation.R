library(dplyr)
library(data.table)
library(tidyverse)
library(haven)
library(stringr)

file <- file.choose()
mutationn1 <- read.delim(file, sep = "\t",header=TRUE)
mutationn1 <- as.data.frame(mutationn1)
mutationn1$amino_acid_change <- mutationn1$Protein.change
mutationn_n <- select(mutationn1, -1,-3:-4,-6:-15)
mutationn_n$Clinical.significance..Last.reviewed. <- gsub("(?=La).*", "", mutationn_n$Clinical.significance..Last.reviewed., perl = TRUE)
mutationn_n$Variant_Classification <- gsub("[(]", "", mutationn_n$Clinical.significance..Last.reviewed.)
mutationn_n$Variant_Classification <- gsub(" ", "_", mutationn_n$Variant_Classification)
mutationn_n$Gene.s.<- str_replace_all(mutationn_n$Gene.s., "[^[:alnum:]]", "")
mutationn_n$Hugo_Symbol <- gsub("LOC105371046", "", mutationn_n$Gene.s.)
mutationn_n <- select(mutationn_n, -1:-2)
mutationn_n$aaa <- as.numeric(gsub("[^[:digit:]]", "", mutationn_n$amino_acid_change))
write.csv(mutationn_n, file = "my_data.csv",sep = "*",row.names = FALSE, quote = FALSE)


