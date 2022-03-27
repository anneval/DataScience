# Load packages
library(tidyverse)
library(hexbin)

# Set the path to the data
data_path = "/Users/Kathi/Documents/WU/Data Science/02_DataViz/data"

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
ggplot(data = health_data) +
    geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders), color = "red")

# Exercise 2
# Recreate the same scatterplot, this time with the colors of the points indicating the continents.
ggplot(data = health_data) +
    geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders, color = continent))

#### 1.3 Facets

# Exercise 1
# Again create a scatterplot showing the relationship between child and maternal malnutrition and neonatal disorders. Facet the plot into three rows based on the continent.
ggplot(data = health_data) +
    geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    facet_wrap(~ continent, nrow = 3)

# Exercise 2
# Recreate the same plot, this time showing all continents next to each other (one column per continent and only one row). Try to find two different options to create this plot.
# Option 1
ggplot(data = health_data) +
    geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    facet_wrap(~ continent, nrow = 1)
# Option 2
ggplot(data = health_data) +
    geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    facet_grid(. ~ continent)

# Exercise 3
# Again recreate the scatterplot of child and maternal malnutrition and neonatal disorders. Facet the plot by continent and the disease or risk factor causing most deaths. Create one row for each continent and one column for each cause.
ggplot(data = health_data) +
    geom_point(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    facet_grid(continent ~ top_cause)

#### 1.4 Geometric objects

# Exercise 1
# Again create a scatterplot showing the relationship between child and maternal malnutrition and neonatal disorders. Now add a second layer to the plot showing a smooth line fitted to the data and the corresponding confidence interval. Try to create this plot without introducing duplications in your code for the different layers.
# Note: We will get a message on which method is used to fit the line. We could adjust this method, but for now we will stick with the default.
ggplot(data = health_data, mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    geom_point() +
    geom_smooth()

# Exercise 2
# Recreate the same plot with the following two adaptations: 1) use the color of the points to indicate the continent and 2) subset the data shown in the fitted line to Asia.
ggplot(data = health_data, mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    geom_point(mapping = aes(color = continent)) +
    geom_smooth(data = subset(health_data, continent == "Asia"))

#### 1.5 Statistical transformations

# Exercise 1
# Create a bar plot that shows the numbers of countries in each continent in the dataset health_data. Try to find two different options to create this plot.
# Option 1
ggplot(data = health_data) + 
    geom_bar(mapping = aes(x = continent))
# Option 2
ggplot(data = health_data) + 
    stat_count(mapping = aes(x = continent))

# Exercise 2
# Create a bar plot showing the shares of deaths from dementia in Sweden for all years from 2010 to 2017.
ggplot(data = subset(health_data_complete, country=="Sweden")) + 
    geom_bar(mapping = aes(x = year, y = dementia), stat = "identity")

#### 1.6 Position adjustments

# Exercise 1
# Again create a bar plot that shows the numbers of countries in each continent in the dataset health_data. Fill the bars with colors indicating the disaese or risk factor causing most deaths.
ggplot(data = health_data) + 
    geom_bar(mapping = aes(x = continent, fill = top_cause))

# Exercise 2
# Recreate the same plot. To improve the comparability of the proportions accross the groups, extend all bars to the same height
ggplot(data = health_data) + 
    geom_bar(mapping = aes(x = continent, fill = top_cause), position = "fill")

#### 1.7 Coordinate systems

# Exercise 1
# Recreate the bar chart that shows the numbers of countries in each continent in the dataset health_data. Fill the bars with colors indicating the disaese or risk factor causing most deaths. In addition, flip the x and y axis of the plot.
ggplot(data = health_data) + 
    geom_bar(mapping = aes(x = continent, fill = top_cause)) +
    coord_flip()

#### 1.9 Themes and labels

# Exercise 1
# Recreate the bar plot showing the shares of deaths from dementia in Sweden for all years from 2010 to 2017. This time, use a white instead of a gray background.
ggplot(data = subset(health_data_complete, country=="Sweden")) + 
    geom_bar(mapping = aes(x = year, y = dementia), stat = "identity") +
    theme_bw()

# Exercise 2
# Again recreate the bar plot showing the shares of deaths from dementia in Sweden for all years from 2010 to 2017. Now adjust the labels of the y axis to indicate that we are plotting shares.
ggplot(data = subset(health_data_complete, country=="Sweden")) + 
    geom_bar(mapping = aes(x = year, y = dementia), stat = "identity") +
    scale_y_continuous(labels = scales::percent)

# Exercise 3
# Recreate the bar chart that shows the numbers of countries in each continent in the dataset health_data. Fill the bars with colors indicating the disaese or risk factor causing most deaths. In addition, make the plot more self-explanatory by adding a plot title and suitable legend and axis titles.
ggplot(data = health_data) + 
    geom_bar(mapping = aes(x = continent, fill = top_cause)) +
    labs(title = "Numbers of countries by continent and leading cause of death", x = "Continent", y = "Number of countries", fill = "Leading cause of death")

#### 2.3 Variation

# Exercise 1
# Create a histogram showing the distribution of the shares of deaths from dementia in 2017. Choose a suitable binwidth and let the labels of the x axis indicate that you are plotting shares.
ggplot(data = health_data) +
    geom_histogram(mapping = aes(x = dementia), binwidth = 0.01) +
    scale_x_continuous(labels = scales::percent)

# Exercise 2
# Recreate the previous plot and use colors to add information on the continents. Choose a suitable geom.
ggplot(data = health_data) +
    geom_freqpoly(mapping = aes(x = dementia, color = continent), binwidth = 0.01) +
    scale_x_continuous(labels = scales::percent)

#### 2.4 Missing values

# Exercise 1
# Run the following code to create a copy of the dataset health_data in which values larger than 14% are replaced by NAs in the column dementia.
health_data_1 = mutate(health_data, dementia = ifelse(dementia>0.14, NA, dementia))
# Now create a column called "missing" in health_data_1 that indicates whether dementia is NA. Next, create a bar chart that shows the numbers of countries per continent and indicates in which continents we have missing values for dementia.
health_data_1 = mutate(health_data_1, missing = is.na(dementia))
ggplot(data = health_data_1) +
    geom_bar(mapping = aes(x = continent, fill = missing))

#### 2.5 Covariation

# Exercise 1
# Create a boxplot showing the distributions of the shares of deaths from dementia in 2017 by continent. Let the y axis labels indicate that you are plotting shares and order the continents by the median share of deaths from dementia.
ggplot(data = health_data) +
    geom_boxplot(mapping = aes(x = reorder(continent, dementia, FUN = median), y = dementia)) +
    scale_y_continuous(labels = scales::percent)

# Exercise 2
# Use the hexbin package to plot the relationship between child and maternal malnutrition and neonatal disorders. Let the x and y axis labels show that you are plotting shares.
ggplot(data = health_data_complete) +
    geom_hex(mapping = aes(x = child_maternal_malnutrition, y = neonatal_disorders)) +
    scale_x_continuous(labels = scales::percent) +
    scale_y_continuous(labels = scales::percent)




