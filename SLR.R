

install.packages("writexl")  # Run once if not installed
library(writexl)
# -------------------------------
# 1. Create Sample Dataset
# -------------------------------

set.seed(123)

data <- data.frame(
  Experience = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  Education_Years = c(12, 14, 16, 16, 18, 18, 20, 20, 22, 22),
  Age = c(22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
)

# Create Salary with some randomness
data$Salary <- 30000 +
               data$Experience * 5000 +
               data$Education_Years * 2000 +
               rnorm(10, 0, 3000)

# Save CSV file (so you can open it in Excel)
write.csv(data, "sample_employee_data.csv", row.names = FALSE)

cat("Sample CSV file created: sample_employee_data.csv\n\n")

# -------------------------------
# 2. Load the CSV File
# -------------------------------

data <- read.csv("sample_employee_data.csv")

cat("First few rows of data:\n")
print(head(data))

# -------------------------------
# 3. Run Multiple Linear Regression
# Salary ~ Experience + Education + Age
# -------------------------------

model <- lm(Salary ~ Experience + Education_Years + Age, data = data)

cat("\nRegression Summary:\n")
sum <- summary(model())
print(summary(model))


# -------------------------------
# 4. Add Predicted Salary
# -------------------------------

data$Predicted_Salary <- predict(model, data)

cat("\nData with Predictions:\n")
print(head(data))

# -------------------------------
# 5. Export Results to Excel
# -------------------------------


write_xlsx(data, "regression_output.xlsx")

cat("\nExcel file created: regression_output.xlsx\n")

# -------------------------------
# 6. Save Model Coefficients Separately
# -------------------------------

coefficients <- as.data.frame(summary(model)$coefficients)
write_xlsx(coefficients, "regression_coefficients.xlsx")

cat("Excel file created: regression_coefficients.xlsx\n")

# -------------------------------
# 7. Diagnostic Plots
# -------------------------------

par(mfrow = c(2, 2))
plot(model)
