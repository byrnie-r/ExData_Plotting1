# plot3.R
# Energy sub-metering over time

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

# Convert sub-metering columns to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Create PNG
png("plot3.png", width = 480, height = 480)

plot(
  data$DateTime,
  data$Sub_metering_1,
  type = "l",
  ylab = "Energy sub metering",
  xlab = ""
)

lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n"
)

dev.off()
