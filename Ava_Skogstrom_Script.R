library(ggplot2)
library(dplyr)

setwd("~/BIOL3140/Module-1-Project/Scales")

dat <- read.csv("scales.csv")
dim(dat)
head(dat)

class(dat$N)
class(dat$quadrant)
class(dat$species)
class(dat$specimen)

#A line of code which reports the class of each column in the dataset
sapply(dat,class)

dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species 

#A line of code which reports the dimensions of the dataset
print(paste(length(dat), "x", length(species)))

dat$species==species[1]
dat$species[dat$species==species[1]]

A.rup <- length(dat$species[dat$species==species[1]])
L.gib <- length(dat$species[dat$species==species[2]])
L.mac <- length(dat$species[dat$species==species[3]])
M.sal <- length(dat$species[dat$species==species[4]])
M.sax <- length(dat$species[dat$species==species[5]])

P.fla <- length(dat$species[dat$species==species[6]])
species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs

species.n <- dat %>% 
  group_by(species) %>% 
  summarise(n=n())
species.n  

dat %>% 
  count(species,specimen) %>% 
  print() %>% 
  count(species,name="n.specimens")

for(i in species){
  p <- dat %>% 
    filter(species==i) %>% 
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
    print(p)
}

pdf("species_quadrant.pdf")
for(i in species){
    p <- dat %>% 
    filter(species==i) %>% 
  ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")

