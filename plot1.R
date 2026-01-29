# plot1.R
# Plot 1: Histogram of Global Active Power

# Read data
data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Subset data for the required dates
data <- subset(
  data,
  Date == "1/2/2007" | Date == "2/2/2007"
)

# Convert Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Create PNG file
png("plot1.png", width = 480, height = 480)

# Plot histogram
hist(
  data$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)

# Close device
dev.off()
