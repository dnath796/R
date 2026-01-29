# ---------------------------------
# 1. CREATE SAMPLE DATA
# ---------------------------------
set.seed(123)

data <- data.frame(
  Experience = c(1,2,3,4,5,6,7,8,9,10),
  Education_Years = c(12,14,16,16,18,18,20,20,22,22),
  Age = c(22,24,26,28,30,32,34,36,38,40)
)

data$Salary <- 30000 +
               data$Experience * 5000 +
               data$Education_Years * 2000 +
               rnorm(10, 0, 3000)

write.csv(data, "sample_employee.csv", row.names = FALSE)

cat("Sample dataset saved as sample_employee.csv\n\n")

# ---------------------------------
# 2. LOAD DATA
# ---------------------------------
data <- read.csv("sample_employee.csv")

# ---------------------------------
# 3. RUN LINEAR REGRESSION
# ---------------------------------
model <- lm(Salary ~ Experience + Education_Years + Age, data = data)

cat("===== REGRESSION SUMMARY IN TERMINAL =====\n")
print(summary(model))

# ---------------------------------
# 4. SAVE PREDICTED VALUES
# ---------------------------------
data$Predicted_Salary <- predict(model, data)
write.csv(data, "regressionpredictions.csv", row.names = FALSE)

# ---------------------------------
# 5. EXTRACT FULL SUMMARY DETAILS
# ---------------------------------
model_summary <- summary(model)

# Coefficients table
coeff_table <- as.data.frame(model_summary$coefficients)
coeff_table$Variable <- rownames(coeff_table)
coeff_table <- coeff_table[, c("Variable", "Estimate", "Std. Error", "t value", "Pr(>|t|)")]

write.csv(coeff_table, "regressioncoefficients.csv", row.names = FALSE)

# Residuals summary
residuals_table <- data.frame(
  Metric = c("Min", "1Q", "Median", "3Q", "Max"),
  Value = model_summary$residuals[1:5]
)

write.csv(residuals_table, "regressionresidualssummary.csv", row.names = FALSE)

# Model statistics
model_stats <- data.frame(
  Metric = c("R-squared",
             "Adjusted R-squared",
             "Residual Standard Error",
             "F-statistic",
             "DF Model",
             "DF Residual",
             "Observations"),
  Value = c(model_summary$r.squared,
            model_summary$adj.r.squared,
            model_summary$sigma,
            model_summary$fstatistic[1],
            model_summary$fstatistic[2],
            model_summary$fstatistic[3],
            length(model$fitted.values))
)

write.csv(model_stats, "regressionmodelstatistics.csv", row.names = FALSE)

# ---------------------------------
# 6. DIAGNOSTIC PLOTS
# ---------------------------------
par(mfrow = c(2,2))
plot(model)

cat("\nAll regression outputs saved as CSV files. Open them in Excel.\n")
