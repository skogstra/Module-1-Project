#install.packages(c("ggplot2", "tidyverse"))
library(ggplot2)
library(tidyverse)
setwd("C:/Users/cjboo/Desktop/R-Programs/Module-1/Module-1-Project")

# A dat variable containing the scales dataset.
dat <- read.csv("scales.csv")
head(dat)

# A line of code which reports the class of each column in the dataset.
sapply(dat,class)

dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species

# A line of code which reports the dimensions of the dataset.
length(species)

# Code that produces a summary of the number of scales punctured for each species.
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

# Code that produces a summary of the number of specimens sampled for each species.
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

# Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot of puncture force verus quadrant.
pdf("Conor_Booth_species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()
list.files(pattern=".pdf")
