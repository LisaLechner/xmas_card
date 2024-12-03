#########################################
# Christmas cards visualization
#########################################
library(tidyverse)
library(ggimage)
library(ggtext)
library(geomtextpath)

# Define paths
path <- "/Users/c4021106/Dropbox/Conscious_datascientist/code/data_viz/data_viz/"

# Data for images
dt <- expand.grid(x = 1:10, y = 1:10)
dt$image <- ifelse(dt$x == 2 & dt$y == 2, paste0(path, "raw_images/earth.png"), NA)
dt$image <- ifelse(dt$x == 9 & dt$y == 2, paste0(path, "raw_images/moon.png"), dt$image)
dt$image2 <- ifelse(dt$x == 7 & dt$y == 2, paste0(path, "raw_images/santa.png"), NA)
rocket_image <- paste0(path, "raw_images/apollo_g2.png")

# Curved path data
t <- seq(2, 9, length.out = 100)
y <- 2 + 510 * sin((t - 2) / (9 - 2) * pi)
curved_text <- data.frame(x = t, y = y, label = "69 hours (2.88 days)")

# Rocket position
rocket_position <- data.frame(
  x = 4.05,
  y = 2 + 410 * sin((5.5 - 2) / (9 - 2) * pi),
  image = rocket_image
)

# Straight path data
straight_text <- data.frame(
  x = c(2, 9),
  y = c(2, 2),
  label = "8 min"
)

# Plot
ggplot() +
  geom_textpath(data = curved_text, aes(x = x, y = y, label = label), 
                color = "#b0b0b0", size = 4, linetype = "dashed") +
  geom_textpath(data = straight_text, aes(x = x, y = y, label = label), 
                color = "#b40024", size = 4, linetype = "dashed") + 
  labs(
    title = "If Santa visits all people on Christmas day, he needs to travel at a speed of <span style='color:#b40024; font-weight:bold;'>2340000 mph</span>",
    subtitle = "So fast that he would travel to the moon in <span style='color:#b40024; font-weight:bold;'>8 minutes</span>  <span style='color:#b0b0b0; font-weight:bold;'>(510 x faster than Apollo 8)</span>",
    caption = "Data from: https://bit.ly/4g7ybjQ"
  ) +
  geom_image(data = dt, aes(x = x, y = y, image = image), size = 0.17, by = 'height') +
  geom_image(data = dt, aes(x = x, y = y, image = image2), size = 0.1, by = 'height') +
  geom_image(data = rocket_position, aes(x = x, y = y, image = image), size = 0.1) + 
  theme_void() +
  theme(
    plot.title = element_markdown(color = "#b0b0b0", size = 14),
    plot.subtitle = element_markdown(color = "#b0b0b0", size = 12),
    plot.caption = element_text(size = 5, color = "gray50"),
    plot.background = element_rect(fill = "black", color = NA),
    panel.background = element_rect(fill = "black", color = NA),
    plot.margin = margin(50, 50, 50, 50)
  ) +
  annotate("text",x=7,y=100,label="Poor Santa can't,\nbut he picked you.\nBecause you make\n the world a better place.\nThank You!",color="white")+
  scale_x_continuous(expand = expansion(mult = 0.1)) +
  scale_y_continuous(expand = expansion(mult = 0.1))
