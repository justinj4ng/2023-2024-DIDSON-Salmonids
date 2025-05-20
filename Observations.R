# Name: Justin Jang (Github: justinj4ng)
# DIDSON 2023-2024 Figures
# Last modified 5/1/2025

###
#Read a CSV file of salmonid observations per hour and render a bar chart.
###
library("tidyverse")

#setwd("U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Scripts")
setwd("C:/Users/justi/OneDrive/Desktop/2023-2024/Scripts")

hour_df <- read_csv("hour.csv")
colnames(hour_df) = c("Hour", "Count")
hour_df$Hour = as.Date(hour_df$Hour, format = "%h")

#hour_df

obs <- ggplot(hour_df, aes(x = Hour, y = Count)) + 
  geom_col(fill = "steelblue", 
           color = "black") +
  ylim(0,200) +
  scale_fill_manual(values = "steelblue") +
  scale_x_continuous(breaks = 0:23) +
  theme_classic(base_size = 15) +
  labs(title = "Salmonid Observations by Hour of the Day",
     x = "Hour of the Day", 
     y = "Salmonid Count",
     fill = "Species") +
  theme(plot.title = element_text(hjust = 0.5))

obs