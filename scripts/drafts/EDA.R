library(readr)
library(ggplot2)
library(tidyverse)
data <- read_csv("data/card_transdata.csv")
View(data)

dim(data)

# The dataset contains 1000000 observations

data %>%
  ggplot(aes(x = fraud)) +
  geom_histogram(bins=30)

data %>% 
  count(data$fraud)

# We noticed that most transactions are not fraud. so accuracy may not be a proper model evluation metric. 
# Consider AUC-ROC, f1 score etc.