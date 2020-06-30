library(caret)
library(ggplot2)

# Load the data 
cars_data <- mtcars

# Exploratory Analysis done in separate R file Exploratory-Analysis.R

# Convert some of the category variables into factors
cars_data$cyl <- as.factor(cars_data$cyl)
cars_data$vs <- as.factor(cars_data$vs)
cars_data$am <- as.factor(cars_data$am)
cars_data$gear <- as.factor(cars_data$gear)
cars_data$carb <- as.factor(cars_data$carb)

# pre-process the data
cars_data_ex <- cars_data[, -1]

##creating vector to hold engine type names
engine_types <- c("V-shaped" = 0, "Straight" = 1)
##creating vector to hold transmission type names
transmission_types <- c("Automatic" = 0, "Manual" = 1)

set.seed(1234)

## creating dummy variables for the factor variables
dummy_vars <- dummyVars(~ ., data = cars_data_ex, fullRank = TRUE)
cars_data_ex <- predict(dummy_vars, newdata = cars_data)

## Standardizing the data
knn_impute <- preProcess(cars_data_ex, method = "knnImpute")
cars_data_ex <- predict(knn_impute, newdata = cars_data_ex)

## converting to dataframe
cars_data_ex <- data.frame(cars_data_ex, row.names = NULL)

## removing columns with near zero var
nearZeroVar(cars_data_ex)
cars_data_ex <- cars_data_ex[, -c(15,16)]

# training and predicting

## adding the outcome column back into the training dataset
cars_data_ex <- cbind(cars_data_ex, "mpg" = cars_data$mpg)

## creating cross validation controls
train_ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

## train model
tr_lm <- train(mpg ~ ., data = cars_data_ex, method = "lm", trControl = train_ctrl)

## Residual Standard Error = 2.727

## predict on user car model
pred_mpg <- function(user_car_specs) {
## match user car data to training data manipulations
set.seed(1234)
user_car_specs <- predict(dummy_vars, newdata = user_car_specs)
user_car_specs <- predict(knn_impute, newdata = user_car_specs)
user_car_specs <- data.frame(user_car_specs, row.names = NULL)
user_car_specs <- user_car_specs[, -c(15,16)]

#predict mpg
pred_user_car_mpg <- predict(tr_lm, newdata = user_car_specs)

if (pred_user_car_mpg < 0) {
  pred_user_car_mpg <- 0
}

round(pred_user_car_mpg, digits = 2)
}







