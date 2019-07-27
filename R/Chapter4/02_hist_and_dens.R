# Chapter4
# Histogram and density plot

library(tidyverse)
library(socviz)

midwest %>% colnames

midwest %>% ggplot(aes(x = area)) + 
  geom_histogram(bins = 100) # `bins` controls the number of bins of plot

# It's also possible to use several variablese at once to compare thire distributions

# Scales hist and density dose not match.
subset(midwest, state %in% c("OH", "WI")) %>% # same as `filter` ?
  ggplot(aes(x = percollege, fill = state))+
  geom_histogram(aes(y = ..density..), alpha = 0.4, binwidth = 1) +
  geom_density(aes(y = ..density..), alpha = 0.1)

# Match scale.
midwest %>% ggplot(aes(x = percollege, fill = state)) +
  geom_histogram(aes(y = ..density..), alpha = 0.4, binwidth = 0.5, position = "identity") +  
  # set "identity" to position to adjust scales.
  geom_density(aes(y = ..density.., colour = state), alpha = 0.5)

# Not to transform
titanic %>% View
titanic %>% ggplot(aes(x = fate, y = percent, fill = sex))+
  geom_bar(stat = "identity", 
           # If set identity, geom_bar() don't calculate count and use dataset value directly 
           position = "dodge")

