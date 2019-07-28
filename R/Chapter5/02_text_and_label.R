# schatter and geom_text
by_country %>% ggplot(aes(x = roads_mean, donors_mean))+
  geom_point()+
  geom_text(aes(label = country), 
            hjust = -0.1) # slide text not to coverd point

# using ggrepel to adjust the places of labels automaticaly.
library(ggrepel)
elections_historic %>%
  ggplot(aes(x = popular_pct, y = ec_pct, label = winner_label))+
  geom_point()+
  geom_text_repel()+ 
  scale_x_continuous(labels = scales::percent)+
  scale_y_continuous(labels = scales::percent)+
  geom_hline(yintercept = 0.5, size = 1.4, colour = "gray80")+
  geom_vline(xintercept = 0.5, size = 1.4, colour = "gray80")

# Create a dummy variables for labels.
organdata <- organdata %>% 
  mutate(ind = ccode %in% c("Ita", "Spa") & year > 1998) 
# Logical vector operator is `&`, not`&&`

organdata%>%
  ggplot(aes(x = roads, y = donors, colour = ind))+
  geom_point()+
  geom_text_repel(data = filter(organdata, ind), aes(label = ccode), 
                  seed = 1234)+
  guides(label = FALSE, colour = FALSE)