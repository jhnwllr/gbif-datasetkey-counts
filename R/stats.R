
library(dplyr)
library(purrr)

# setwd("C:/Users/ftw712/Desktop/gbif-datasetkey-counts/")

# save archive of datasetkey counts every 3 months 
readr::read_tsv("https://api.gbif.org/v1/dataset/search/export?format=TSV") %>% 
mutate(created = as.character(Sys.Date())) %>% 
select(datasetkey = dataset_key, created, n_occ = occurrence_records_count) %>% 
filter(n_occ > 0) %>% 
glimpse() %>%
readr::write_tsv(paste0("exports/tsv/",Sys.Date(),".tsv"))

