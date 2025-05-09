install.packages("GetBCBData")

library(GetBCBData)
library(tidyverse)


tjs <- c(cdi = 432)

df.bcb <- gbcbd_get_series(id = tjs ,
                           first.date = '1999-03-05',
                           last.date = Sys.Date(),
                           format.data = 'long',
                           use.memoise = TRUE, 
                           cache.path = tempdir(), # use tempdir for cache folder
                           do.parallel = FALSE)
glimpse(df.bcb)

# GRÁFICO SIMPLES

p <- ggplot(df.bcb, aes(x = ref.date, y = value/100) ) +
  geom_line(color = "darkblue") + 
  labs(title = '	Meta Selic definida pelo Copom', 
       subtitle = paste0(min(df.bcb$ref.date), ' to ', max(df.bcb$ref.date)),
       x = '', y = 'Taxa de juros Meta Selic, % a.a.') + 
  theme_light()

print(p)
