### 1.Load Libraries

library(tidymodels)
library(xgboost)
library(tidyverse)

### 2.Data Cleaning:

# read in raw data
data <- read_csv("data/card_transdata.csv") 
head(data)

trim <- function(x, .at){
  x[abs(x) > .at] <- sign(x[abs(x) > .at])*.at
  return(x)
}

# rename and scale: since some variable are on distance scale/some are ratio
data <- data %>%
  rename(dist_home = distance_from_home,
         dist_last_transact = distance_from_last_transaction,
         ratio_to_med_price = ratio_to_median_purchase_price) %>%
  mutate(across(.cols = c(dist_home, dist_last_transact, ratio_to_med_price), 
                ~ trim(scale((.x))[, 1], .at = 3)))

# One-Hot Encoding(EXPLAIN IN WRITE-UP)
# XGBoost only accept numerical value, so convert categorical to numeric by one-hot encoding
# when doing write up, refer to: https://machinelearningmastery.com/why-one-hot-encode-data-in-machine-learning/
# we don't have to worry about it since all variables in our data set in numeric


### 3.Splitting Data

#set seed for reproducibility
set.seed(197)
#split training/testing
data.split <- data %>% 
  initial_split(prop = 0.8)

### 4.Data Preparation

#define predictor and response variables in training set
# NOTE: XGBoost only use matrix data
train.x <-  data.matrix(training(data.split) %>% select(-fraud))
train.y <-  training(data.split) %>% pull(fraud)

#define predictor and response variables in testing set
test.x <-  data.matrix(testing(data.split) %>% select(-fraud))
test.y <-  testing(data.split) %>% pull(fraud)

#define final training and testing sets
xgb.train <-  xgb.DMatrix(data = train.x, label = train.y)
xgb.test <-  xgb.DMatrix(data = test.x, label = test.y)

### 5. Model Fitting

# there is a 'nrounds' parameter in the xgboost(), which specifies the number of 
# boosting iterations to be run while training the XGBoost model. In each round,
# a new decision tree is added to the model to correct the mistakes made by trees in the previous rounds
# large dataset usually need more rounds
# we don't want overfitting, so keep an eye on test-rmse(Test Root Mean Squared Error)

# max.depth is how deep to grow the individual decision trees. We typically use small number like 2 or 3, as
# this approach tends to produce more accurate models.
#define watchlist
watchlist = list(train=xgb.train, test=xgb.test)

#fit XGBoost model and display training and testing data at each round
model <-  xgb.train(data = xgb.train, max.depth = 3, watchlist=watchlist, nrounds = 500)

# Typically, find the number of rounds where test-rmse is the lowest and the afterwards start to increase
# From result we noticed, 500 rounds looks good(ACTUALLY NOT SURE, PLEASE VERIFY)

#define final model
# The argument verbose = 0 tells R not to display the training and testing error for each round.
final <-  xgboost(data = xgb.train, max.depth = 3, nrounds = 500, verbose = 0)

### Feature Importance
# WRITE-UP refer to: https://cran.r-project.org/web/packages/xgboost/vignettes/discoverYourData.html
importance <- xgb.importance(feature_names = colnames(train.x), model = final)
head(importance)

# plot
xgb.plot.importance(importance_matrix = importance)



