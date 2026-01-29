# plot4.R
# Four-panel plot of power consumption variables

# Read data
data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Date conversion and subsetting
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Create datetime variable
data$DateTime <- strptime(
  paste(data$Date, data$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

# Convert relevant columns to numeric
cols <- c(
  "Global_active_power",
  "Global_reactive_power",
  "Voltage",
  "Sub_metering_1",
  "Sub_metering_2",
  "Sub_metering_3"
)

data[cols] <- lapply(data[cols], as.numeric)

# Create PNG
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

# Plot 1
plot(
  data$DateTime,
  data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# Plot 2
plot(
  data$DateTime,
  data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# Plot 3
plot(
  data$DateTime,
  data$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
  cex = 0.8
)

# Plot 4
plot(
  data$DateTime,
  data$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global Reactive Power"
)

dev.off()
