install.packages("GetBCBData")

library(GetBCBData)
library(tidyverse)


tjs <- c(cdi = 21340)

df.bcb <- gbcbd_get_series(id = tjs ,
                           first.date = '2001-03-01',
                           last.date = Sys.Date(),
                           format.data = 'long',
                           use.memoise = TRUE, 
                           cache.path = tempdir(), # use tempdir for cache folder
                           do.parallel = FALSE)
glimpse(df.bcb)

# GRÁFICO SIMPLES

p <- ggplot(df.bcb, aes(x = ref.date, y = value/100) ) +
  geom_line(color = "darkblue") + 
  transition_reveal(ref.date) +
  labs(title = '		Índice de Valores de Garantia de Imóveis Residenciais Financiados IVG-R', 
       subtitle = paste0(min(df.bcb$ref.date), ' to ', max(df.bcb$ref.date)),
       x = '', y = '') + 
  theme_light()

print(p)

anim <- animate(
  p,
  width = 8, height = 6,             # polegadas
  units = "in",
  res = 100,                         # resolução (800x600 px)
  fps = 20, duration = 10,
  renderer = gifski_renderer(),
  device = "ragg_png"
)

# Salvar o GIF na pasta figures
anim_save(gif_path, animation = anim)

# Incluir GIF no HTML final
knitr::include_graphics(gif_path)




install.packages("ggplot2")
install.packages("gganimate")
install.packages("gifski")
install.packages("ragg")
install.packages("knitr")
