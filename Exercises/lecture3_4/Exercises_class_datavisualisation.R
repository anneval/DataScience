
installed.packages("tidyverse")
installed.packages("hexbin")
# Load packages
library(tidyverse)
library(hexbin)

# Set the path to the data
data_path = "/Users/annevalder/Desktop/UNI /WU WIEN/WS 20:21/Data Science/Specialisation"

# Select the dataset we want to load
ihme_global_data = "ihme_global_data.csv"

# Load the dataset
health_data_complete = read.csv(file.path(data_path, ihme_global_data))

# Create a subset including only the year 2017
health_data = subset(health_data_complete, year==2017)

###################
#### Exercises ####
###################

#### 1.2 Aesthetic mappings

# Exercise 1
# Use the dataset health_data to create a scatterplot showing the relationship between child and maternal malnutrition and neonatal disorders. Color all points in red.
names(health_data)

ggplot(data = health_data) +
  geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders, color= "red"))

# Exercise 2
# Recreate the same scatterplot, this time with the colors of the points indicating the continents.


ggplot(data = health_data) +
  geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders, color= continent))

#### 1.3 Facets

# Exercise 1
# Again create a scatterplot showing the relationship between child and maternal malnutrition and neonatal disorders. Facet the plot into three rows based on the continent.

ggplot(data = health_data) +
  geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
  facet_wrap(~ continent, nrow = 3)

# Exercise 2
# Recreate the same plot, this time showing all continents next to each other (one column per continent and only one row). Try to find two different options to create this plot.

ggplot(data = health_data) +
  geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
  facet_wrap(~ continent, nrow = 1)

# Exercise 3
# Again recreate the scatterplot of child and maternal malnutrition and neonatal disorders. Facet the plot by continent and the disease or risk factor causing most deaths. Create one row for each continent and one column for each cause.
ggplot(data = health_data_complete) +
  geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
  facet_grid(continent ~ child_maternal_malnutrition)

