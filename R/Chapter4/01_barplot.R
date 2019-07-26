# Chapter4
# barplot

library(tidyverse)
library(socviz)

View(gss_sm)
gss_cat

# triple facet grid
gss_sm %>% ggplot(aes(x = age, y = childs)) +
  geom_point(alpha = 0.2)+
  geom_smooth()+
  facet_grid(sex ~ race ~ degree)

# hide guides
gss_sm %>% ggplot(aes(x = religion, fill = religion))+
  geom_bar()+
  guides(fill = FALSE)

# ..prop..
gss_sm %>% ggplot(aes(x = bigregion)) + 
  geom_bar(aes(y = ..prop.., group = "A")) # integer or string can be used as group index

# fill position
gss_sm %>% ggplot(aes(x = bigregion, fill = religion)) + 
  geom_bar(position = "fill")

# proportion of religions by each big region (using 'dodge')
# The grouping variable is religion, not big region!
gss_sm %>% ggplot(aes(x = bigregion, fill = religion)) + 
  geom_bar(aes(y = ..prop.., group = religion), position = "dodge")

# 