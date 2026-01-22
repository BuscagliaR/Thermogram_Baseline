library(tidyverse)

# Read in the data.  Do some cleaning/verification
DemoBaseline.2 <- readxl::read_excel("data-raw/baseline_demodata_full.xlsx")
DemoBaseline.2 %>% select(matches("3a|11b|12a|15b|16b|29a")) %>% select(-matches("33a|23a|13a"))
Demo.Working <- NULL
Total.Samples <- ncol(DemoBaseline.2)/2
for(i in 1:Total.Samples)
{
  temp.col <- 2*i - 1
  dcp.col <- 2*i
  dummy <- DemoBaseline.2 %>% dplyr::select(temp.col:dcp.col)
  dummy <- dummy %>% mutate(SampleID = colnames(dummy)[2])
  colnames(dummy)[1:2] <- c("Temperature" , "dCp")
  Demo.Working <- Demo.Working %>% rbind(dummy)
}

DemoBaseline <- Demo.Working %>% relocate(SampleID, Temperature, dCp)  %>% drop_na()

# Save the data frame to the data/ directory as MaxTemp.rda
usethis::use_data(DemoBaseline, overwrite = TRUE)



