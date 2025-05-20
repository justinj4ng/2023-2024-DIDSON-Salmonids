# Name: Justin Jang (Github: justinj4ng)
# DIDSON 2023-2024 Figures
# Last modified 4/16/2025

###
#Read CSV file of Dates and corresponding fish movement tallies. Renders histograms for net movement, upstream tallies, and downstream tallies.
#Refer to Salmonids SOP or notes from Michael Romero, Tim Smoot, and Gillian Campbell for troubleshooting.
#How do you do docstrings in R??
###

# Frivolous comments bc I am new to ggplot
#install tidyverse before running

library("tidyverse")

#setwd("U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Scripts")
setwd("C:/Users/justi/OneDrive/Desktop/2023-2024/Scripts")


# Description: Bocchi the Rock color scheme
# Author: Chenxin Li, Ph.D
# Date: March 20, 2025
# URL: https://github.com/cxli233/Color_palette_by_cxli

bocchi <- c("#F2C9D5", "#B43E44", "#FADF92" , "#496496", "#282828", "#904869")


# Daily net movement counts
net_df <-read_csv("Net movement.csv")

colnames(net_df) = c("Date", "Fish")
net_df$Fish = as.numeric(net_df$Fish)
net_df$Date = as.Date(net_df$Date, format="%m/%d/%Y")

net_bar = ggplot(data = net_df) +
  theme_bw(base_size = 15) +
  ylim(-50, 500) +
  scale_y_continuous(breaks = seq(-100,500,100)) +
  coord_cartesian(ylim = c(-100,500)) +
  geom_bar(aes(x = Date, y = Fish), position = "dodge", stat = "identity", col = "black", fill = "steelblue") +
  geom_rect(aes(xmin = as.Date("11/8/2023 05:39:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("11/13/2023 12:55:17", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  geom_rect(aes(xmin = as.Date("12/20/2023 01:22:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("12/27/2023 12:55:17", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  geom_rect(aes(xmin = as.Date("1/19/2024 09:39:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("1/31/2024 23:59:59", format="%m/%d/%Y %H:%M:%S"),
                 ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  ### These bars represent downtime after the last recorded salmonid movement. Discarded for aesthetic reasons.

  # geom_rect(aes(xmin = as.Date("2/1/2024 00:00:00", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("2/29/2024 23:59:59", format="%m/%d/%Y %H:%M:%S"),
  #               ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  # geom_rect(aes(xmin = as.Date("3/1/2024 00:00:00", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("3/20/2024 15:21:03", format="%m/%d/%Y %H:%M:%S"),
  #               ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  # geom_rect(aes(xmin = as.Date("4/6/2024 07:59:59", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("4/6/2024 07:59:59", format="%m/%d/%Y %H:%M:%S"),
  #               ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  # geom_rect(aes(xmin = as.Date("4/10/2024 12:36:03", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("4/10/2024 12:36:03", format="%m/%d/%Y %H:%M:%S"),
  #               ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  xlab("Date") +
  ylab("Net Counts of Adult Salmonids") +
  ggtitle("Daily Net Counts of Adult Salmonid Movement")

net_bar

ggsave("Net counts.png", path = "U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Figures", width = 7, height = 5)


# Daily Downstream counts

downstream_df = read.csv("Downstream movement.csv")
colnames(downstream_df) = c("Date", "Fish")
downstream_df$Fish = as.numeric(downstream_df$Fish)
downstream_df$Date = as.Date(downstream_df$Date, format="%m/%d/%Y")

downstream_bar = ggplot(data = downstream_df) +
  theme_bw(base_size = 15) +
  geom_bar(aes(x = Date, y = Fish), position = "dodge", stat = "identity", col = "black", fill = "steelblue") +
  geom_rect(aes(xmin = as.Date("11/8/2023 05:39:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("11/13/2023 12:55:17", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  geom_rect(aes(xmin = as.Date("12/20/2023 01:22:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("12/27/2023 12:55:17", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  geom_rect(aes(xmin = as.Date("1/19/2024 09:39:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("1/31/2024 23:59:59", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  ylim(-80,0) +
  scale_y_continuous(expand = c (0,0)) +
  scale_x_date(position = "top") +
  xlab("Date") +
  ylab("Downstream Counts of Adult Salmonids") +
  ggtitle("Daily Downstream Counts of Adult Salmonid Movement") +
  theme(plot.title = element_text(hjust = 0.5))

downstream_bar

ggsave("Downstream counts.png", path = "U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Figures", width = 7, height = 5)


# Daily Upstream counts
upstream_df = read.csv("Upstream movement.csv")
colnames(upstream_df) = c("Date", "Fish")
upstream_df$Fish = as.numeric(upstream_df$Fish)
upstream_df$Date = as.Date(upstream_df$Date, format="%m/%d/%Y")

upstream_bar = ggplot(data = upstream_df) +
  theme_bw(base_size = 15) +
  ylim(0, 500) +
  geom_bar(aes(x = Date, y = Fish), position = "dodge", stat = "identity", col = "black", fill = "steelblue") +
  geom_rect(aes(xmin = as.Date("11/8/2023 05:39:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("11/13/2023 12:55:17", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  geom_rect(aes(xmin = as.Date("12/20/2023 01:22:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("12/27/2023 12:55:17", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  geom_rect(aes(xmin = as.Date("1/19/2024 09:39:39", format="%m/%d/%Y %H:%M:%S"), xmax = as.Date("1/31/2024 23:59:59", format="%m/%d/%Y %H:%M:%S"),
                ymin = -Inf, ymax = Inf), fill = "grey", alpha = 0.02) +
  scale_y_continuous(expand = c (0,0)) +
  # scale_x_date(position = "top") +
  xlab("Date") +
  ylab("Upstream Counts of Adult Salmonids") +
  ggtitle("Daily Upstream Counts of Adult Salmonid Movement") +
  theme(plot.title = element_text(hjust = 0.5))

upstream_bar

ggsave("Upstream counts.png", path = "U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Figures", width = 7, height = 5)
