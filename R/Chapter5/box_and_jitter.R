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

# summarize
by_country <- organdata %>% group_by(consent_law, country) %>%
  summarise_if(is.numeric, 
               # funs() is soft deprecated, so use a list(tibble::lst) of either functions or lamdas
               .funs = lst(mean,# Set list name(ex, mean = mean) when using list not lst.
                           sd
                           # ~sd(., na.rm = TRUE) # lambda method(but colnames is not sophisicated.)
                           ), na.rm = TRUE
               )

by_country %>% 
  ungroup %>% # as a plain tibble
  ggplot(aes(x = donors_mean, y = reorder(country, donors_mean), colour = consent_law)) +
  geom_point(size = 3)+
  theme(legend.position = "top")

# geom_ pointrange, a cleveland-style
# plot a point of mean and specified range.
by_country %>% ggplot(aes(y = donors_mean, x = reorder(country, donors_mean), colour = consent_law)) + 
  geom_pointrange(aes(ymin = donors_mean - donors_sd, 
                      ymax = donors_mean + donors_sd)) + 
  coord_flip()
