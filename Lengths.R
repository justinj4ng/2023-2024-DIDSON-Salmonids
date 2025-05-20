# Name: Justin Jang (Github: justinj4ng)
# DIDSON 2023-2024 Figures
# Last modified 5/1/2025

###
#Read a CSV file of estimated salmonid lengths and render histograms from data.
###

library("tidyverse")

#setwd("U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Scripts")
setwd("C:/Users/justi/OneDrive/Desktop/2023-2024/Scripts")

lengths_df <- read_csv("salmonid lengths.csv")


# ggplot(lengths_df, aes(x = lengths, color = lengths)) +
#   theme_bw(base_size = 15) +
#   geom_histogram(binwidth = 5,
#                  breaks = c(40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90),
#                  fill = "steelblue", 
#                  color = "black") +
#   #geom_text(stat = 'count') +
#   labs(title = "Distribution of Adult Salmonid Lengths",
#        x = "Length (cm)",
#        y = "Number of Adult Salmonids",
#        theme(plot.title = element_text(hjust = 0.5))) +
#   theme_classic()

# Define breaks every 10 cm starting at 40
breaks <- seq(40, 100, by = 10)
# Create labels like "40-49", "50-59", etc.
labels <- paste0(breaks[-length(breaks)], "-", breaks[-1] - 1)

# Categorize lengths into bins
lengths_df$bins <- cut(lengths_df$lengths, 
                       breaks = breaks, 
                       right = FALSE, 
                       labels = labels, 
                       include.lowest = TRUE)

# Render plot with corrected bins and caption
ggplot(lengths_df, aes(x = bins)) +
  geom_bar(fill = "steelblue", color = "black") +
  ylim(0, 800) +
  geom_text(
    aes(label = after_stat(count)),  # Use computed count
    stat = "count",                   # Use stat to calculate counts
    vjust = -0.5,                     # Adjust vertical position
    size = 4,                         # Label size
    color = "black"
    ) +
  labs(title = "Distribution of Adult Salmonid Lengths",
       x = "Length (cm)",
       y = "Number of Adult Salmonids",
       caption = "Length Interval(cm)") +
  theme_classic(base_size = 15) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1),
        plot.caption = element_text(hjust = 0.5, margin = margin(t = 10)))

