library(tidyverse)

# Read in the data.  Do some cleaning/verification
DemoBaseline <- readxl::read_excel("data-raw/baseline_demodata_small.xlsx") %>%
  pivot_longer(seq(1,11,2), names_to = 'Sample', values_to = 'Temperature') %>%
  select(-Sample) %>%
  pivot_longer(1:6, names_to = "SampleID", values_to = "dCp") %>%
  relocate(SampleID, Temperature, dCp) %>%
  mutate(SampleID = str_sort(SampleID, decreasing=TRUE)) %>%
  mutate(SampleID = factor(SampleID)) %>%
  filter(between(Temperature, 40, 90))

# Save the data frame to the data/ directory as MaxTemp.rda
usethis::use_data(DemoBaseline, overwrite = TRUE)
