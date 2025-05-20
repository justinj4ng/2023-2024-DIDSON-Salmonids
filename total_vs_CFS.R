# Name: Justin Jang (Github: justinj4ng)
# DIDSON 2023-2024 Figures
# Last modified 4/16/2025

###
#Read a CSV file of total salmonid observations over total recording period.
#Will not run without internet connection as this script uses USGS API.
###
library("tidyverse")
library("dataRetrieval")

#setwd("U:/Natural/_Fish/CDFW/DIDSON/Reports/2023-2024/Scripts")
setwd("C:/Users/justi/OneDrive/Desktop/2023-2024/Scripts")

# Total observations of salmonids
obs_df <- read_csv("total_obs.csv")
obs_df$Date = as.Date(obs_df$Date, format="%m/%d/%Y")

# USGS dataRetrieval API, call data from USGS for Lagunitas Creek discharge
siteNo <- "11460600" # site number for Lagunitas C NR PT Reyes Station CA
pCode <- "00060" # discharge in CFS
start.date <- "2023-11-03"
end.date <- "2024-01-19"

#read data from(?)
lagunitas <- readNWISdv(
  siteNumbers = siteNo,
  parameterCd = pCode,
  startDate = start.date,
  endDate = end.date
)

names(lagunitas)

lagunitas <- renameNWISColumns(lagunitas) # create Flow column
names(lagunitas)

CFS <- ggplot() +
  geom_col(data = obs_df,
           aes(Date, Count, fill = "Salmonid Observations"), 
           color = "black") +
  geom_line(data = lagunitas,
            aes(Date, Flow, color = "Discharge (CFS)"), 
            linewidth = 1) +
  scale_y_continuous(name = "Salmonid Observations", sec.axis = sec_axis(trans=~.*1,name="Discharge (CFS)")) +
  ## create a legend
  scale_fill_manual(name = "", values = c("Salmonid Observations" = "darkred"), label = "Salmonid Observations (n = 2167)") +
  scale_color_manual(name = "", values = c("Discharge (CFS)" = "steelblue")) +
  labs(title = "Total Salmonid Observations vs Discharge at Lagunitas Creek",
       x = "Month") +
  theme(plot.title = element_text(hjust = 0.5)) +
  #theme_classic(base_size = 15) +
  theme(legend.position = "right",
        legend.box = "vertical",
        plot.margin = margin(b = 60, unit = "pt"), # Increase bottom margin
        axis.title.x = element_text(margin = margin(t = 20))# Add space above x-axis label)
  ) +
  scale_x_date(
    date_breaks = "1 month",
    date_labels = "%b",  # Show abbreviated month names
    limits = as.Date(c("2023-11-01", "2024-01-31"))  # Extend axis to February
  )
CFS

# CFS <- ggplot() +
#     geom_line(data = lagunitas,
#               aes(Date, Flow)) +
#     geom_col(data = obs_df,
#              aes(Date, Count),
#              fill = "steelblue", 
#              color = "black") +
#     labs(title = "Total Salmonid Observations vs Discharge at Lagunitas Creek",
#        x = "Date",
#        y = "Salmonid Observations (n = 2167) / Flow (CFS)")
#     theme_classic()
# CFS
