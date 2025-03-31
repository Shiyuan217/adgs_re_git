# set up
library(ggplot2)
library(dplyr)
library(here)

# read and format data from Ch 3
half_hourly_fluxes <- readr::read_csv("../data/FLX_CH-Lae_FLUXNET2015_FULLSET_HH_2004-2006_CLEAN.csv")

set.seed(2023)
plot_1 <- half_hourly_fluxes |>
  sample_n(2000) |>  # to reduce the dataset
  ggplot(aes(x = SW_IN_F, y = GPP_NT_VUT_REF)) +
  geom_point(size = 0.75, alpha = 0.4) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(x = expression(paste("Shortwave radiation (W m"^-2, ")")), 
       y = expression(paste("GPP (gC m"^-2, "s"^-1, ")"))) +
  theme_classic()

segment_points <- data.frame(x0 = 332, y0 = 3.65, y_regr = 8.77)

plot_1 <- plot_1 +
  geom_segment(aes(x = x0, y = y0, xend = x0, yend = y_regr), 
               data = segment_points,
               color = "blue", lwd = 1.2, alpha = 0.8)

# save the fugures
getwd()
ggsave("analysis/figures/ch_9_plot.png", plot = plot_1, width = 6, height = 4, dpi = 300)
