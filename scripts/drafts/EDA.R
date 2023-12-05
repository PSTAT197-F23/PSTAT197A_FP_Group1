#Yixin Xue

library(readr)
library(ggplot2)
library(tidyverse)
library(corrplot)

data <- read_csv("data/card_transdata.csv") 
head(data)
dim(data)

# The dataset contains 1000000 observations

data %>%
  ggplot(aes(x = fraud)) +
  geom_bar() +
  labs(title = "Fraud Distribution", x = 'fraud', y = 'count') +
  theme(plot.title = element_text(hjust = 0.5))

data %>% 
  group_by(fraud) %>%
  count()

# We noticed that most transactions (over 90%) are not fraud. So accuracy may not be a proper model evaluation metric. 
# Consider AUC-ROC, f1 score as evaluation metric.
# Consider using stratified sampling/oversampling to handle the imbalanced classification problem

# example oversampling
# data %>%
#   smote(form = fraud ~ ., data = ., perc.over = 200, k = 5)

data %>%
  cor(use = 'everything') %>%
  corrplot(type = 'lower')
