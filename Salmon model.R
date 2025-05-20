# Name: Justin Jang (Github: justinj4ng)
# DIDSON 2023-2024 Figures
# Last modified 5/6/2025

library(ggplot2)
library(dplyr)
library(tidyr)

setwd("C:/Users/justi/OneDrive/Desktop/2023-2024/Scripts")

data_wide <- read_csv("salmon model.csv")

data_long <- data_wide %>%
  pivot_longer(
    cols = -Date,
    names_to = "Measurement_Type",
    values_to = "Count"
  ) %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y"))  # Convert to proper date format

# Create the line graph
ggplot(data_long, aes(x = Date, y = Count, color = Measurement_Type)) +
  ylim(0, 750) +
  scale_y_continuous(breaks = seq(100, max(700), by = 100),
                      limits = c(0, 700))+
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_x_date(date_labels = "Week of %m/%d", date_breaks = "1 week") +
  labs(title = "Salmon Model",
       x = "Date",
       y = "Count",
       color = "Measurement Type") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), plot.title = element_text(hjust = 0.5))