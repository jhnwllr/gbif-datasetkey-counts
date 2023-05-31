setwd("C:/Users/ftw712/Desktop/gbif-datasetkey-counts/")

library(dplyr)
library(purrr)

list.files("data/")
library(dplyr)

load("data/countsByDatasetkey.rda")

h1 = countsByDatasetkey %>% 
select(datasetkey, created, n_occ = countByDatasetkey) %>%
glimpse()

h2 = arrow::open_dataset("data/stats.parquet") %>%
collect() %>%
mutate(created=stringr::str_replace_all(snapshot,"occurrence_","")) %>%
mutate(created=lubridate::ymd(created)) %>%
select(datasetkey = dataset_id, created, n_occ) %>% 
glimpse() 

d = rbind(h1,h2) %>%
na.omit() %>%
mutate(datasetkey = as.factor(datasetkey)) %>%
group_by(created) %>% 
group_split() %>%
glimpse() %>%
map(~ .x %>% readr::write_tsv(paste0("data/tsv/",.x$created[1],".tsv")))

# glimpse() %>% 
# saveRDS("data/historical_counts.rds")



# lookup_table = 
# mutate(datasetkey = row_number()) %>%

# readr::write_tsv("data/historical_counts.tsv")




