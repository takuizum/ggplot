# Chapter5
# barplot and jitter

library(tidyverse)
library(socviz)

organdata %>% View

# boxplot, + coord_flip
organdata %>% ggplot(aes(x = country, y = donors))+ # transpose, but don't change data
  geom_boxplot() +
  coord_flip()

# boxplot with reordered
organdata %>% ggplot(aes(x = reorder(country, 
                                     donors, 
                                     # optional arguments
                                     FUN = mean, # you like to reoder the categorical variables
                                     na.rm = TRUE # optional arguments of FUN
                                     ), 
                         y = donors))+
  geom_boxplot() +
  coord_flip() + 
  labs(x = NULL) + theme(legend.position = "top")

# jitter
organdata %>% ggplot(aes(x = reorder(country, donors, na.rm = TRUE), 
                         y = donors))+
  geom_jitter(aes(colour = world)) +
  coord_flip() + labs(x = NULL) + # transpose and remove too long label
  theme(legend.position = "top")

# modify jitter option.
organdata %>% ggplot(aes(x = reorder(country, donors, na.rm = TRUE), 
                         y = donors))+
  geom_jitter(aes(colour = world), 
              position = position_jitter(width = 0.15, # scatter along x axis
                                         height = 0.4, # scatter along y axix
                                         seed = 1234)) + # set random seed
  coord_flip() + labs(x = NULL) +
  theme(legend.position = "top")