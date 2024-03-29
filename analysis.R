# Overview ----------------------------------------------------------------

# Assignment 2: U.S. COVID Trends
# For each question/prompt, write the necessary code to calculate the answer.
# For grading, it's important that you store your answers in the variable names
# listed with each question in `backtics`. Please make sure to store the
# appropriate variable type (e.g., a string, a vector, a dataframe, etc.)
# For each prompt marked `Reflection`, please write a response
# in your `README.md` file.



# Loading data ------------------------------------------------------------

# You'll load data at the national, state, and county level. As you move through
# the assignment, you'll need to consider the appropriate data to answer
# each question (though feel free to ask if it's unclear!)

# Load the tidyverse package
library(tidyverse)
library(dplyr)
library(stringr)

# Load the *national level* data into a variable. `national`
# (hint: you'll need to get the "raw" URL from the NYT GitHub page)
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")

# Load the *state level* data into a variable. `states`
states <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

# Load the *county level* data into a variable. `counties`
# (this is a large dataset, which may take ~30 seconds to load)
counties <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

# How many observations (rows) are in each dataset?
# Create `obs_national`, `obs_states`, `obs_counties`
obs_national <- nrow(national)
obs_counties <- nrow(states)
obs_counties <- nrow(counties)

# Reflection: What does each row represent in each dataset?


# How many features (columns) are there in each dataset?
# Create `num_features_national`, `num_features_states`, `num_features_counties`
num_features_national <- ncol(national)
num_features_states <- ncol(states)
num_features_counties <- ncol(counties)

# Exploratory analysis ----------------------------------------------------

# Use functions from the DPLYR package to explore the datasets by answering
# the following questions. Note, you must return the specific column being
# asked about (e.g., using `pull()`). For example, if you are asked the *county*
# with the highest number of deaths, your answer should
# be a single value (the name of the county: *not* an entire row of data).
# (again, make sure to read the documentation to understand the meaning of
# each row -- it isn't immediately apparent!)

# How many total cases have there been in the U.S. by the most recent date
# in the dataset? `total_us_cases`
total_us_cases <- national %>%
  filter(date == max(date)) %>%
  pull(cases)

# How many total deaths have there been in the U.S. by the most recent date
# in the dataset? `total_us_deaths`
total_us_deaths <- national %>%
  filter(date == max(date)) %>%
  pull(deaths)

# Which state has had the highest number of cases?
# `state_highest_cases`
state_highest_cases <- states %>%
  filter(cases == max(cases)) %>%
  pull(state)

# What is the highest number of cases in a state?
# `num_highest_state`
num_highest_state <- states %>%
  filter(cases == max(cases)) %>%
  pull(cases)

# Which state has the highest ratio of deaths to cases (deaths/cases), as of the
# most recent date? `state_highest_ratio`
# (hint: you may need to create a new column in order to do this!)
updated_states <- mutate(states, ratio = (deaths / cases))
state_highest_ratio <- updated_states %>%
  filter(date == max(date)) %>%
  filter(ratio == max(ratio)) %>%
  pull(state)

# Which state has had the lowest number of cases *as of the most recent date*?
# (hint, this is a little trickier to calculate than the maximum because
# of the meaning of the row). `state_lowest_cases`
state_lowest_cases <- updated_states %>%
  filter(date == min(date, na.rm = TRUE)) %>%
  filter(cases == min(cases, na.rm = TRUE)) %>%
  pull(state)
#[Ray] You may want to include na.rm = T

# Reflection: What did you learn about the dataset when you calculated
# the state with the lowest cases (and what does that tell you about
# testing your assumptions in a dataset)?

# Which county has had the highest number of cases?
# `county_highest_cases`
county_highest_cases <- counties %>%
  filter(cases == max(cases)) %>%
  pull(county)

# What is the highest number of cases that have happened in a single county?
# `num_highest_cases_county`
num_highest_cases_county <- counties %>%
  filter(cases == max(cases)) %>%
  pull(cases)

# Because there are multiple counties with the same name across states, it
# will be helpful to have a column that stores the county and state together
# (in the form "COUNTY, STATE").
# Add a new column to your `counties` data frame called `location`
# that stores the county and state (separated by a comma and space).
# You can do this by mutating a new column, or using the `unite()` function
# (just make sure to keep the original columns as well)
counties <- mutate(counties, location = paste0(county, ", ", state))

# What is the name of the location (county, state) with the highest number
# of deaths? `location_most_deaths`
location_most_deaths <- counties %>%
  filter(deaths == max(deaths, na.rm = TRUE)) %>%
  pull(location)

location_most_cases <- counties %>%
  filter(cases == max(cases)) %>%
  pull(location)

# Reflection: Is the location with the highest number of cases the location with
# the most deaths? If not, why do you believe that may be the case?


# At this point, you (hopefully) have realized that the `cases` column *is not*
# the number of _new_ cases in a day (if not, you may need to revisit your work)
# Add (mutate) a new column on your `national` data frame called `new_cases`
# that has the nubmer of *new* cases each day (hint: look for the `lag`
# function).
national <- mutate(national, new_cases = lag(national$cases))

# Similarly, the `deaths` columns *is not* the nubmber of new deaths per day.
# Add (mutate) a new column on your `national` data frame called `new_deaths`
# that has the nubmer of *new* deaths each day
national <- mutate(national, new_deaths = lag(national$deaths))

# What was the date when the most new cases occured?
# `date_most_cases`
date_most_cases <- national %>%
  filter(new_cases == max(new_cases, na.rm = TRUE)) %>%
  pull(date)

# What was the date when the most new deaths occured?
# `date_most_deaths`
date_most_deaths <- national %>%
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>%
  pull(date)

# How many people died on the date when the most deaths occured? `most_deaths`
most_deaths <- national %>%
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>%
  pull(new_deaths)

# Create a (very basic) plot by passing `national$new_cases` column to the
# `plot()` function. Store the result in a variable `new_cases_plot`.
new_cases_plot <- plot(national$new_cases)

# Create a (very basic) plot by passing the `new_deaths` column to the
# `plot()` function. Store the result in a variable `new_deaths_plot`.
new_deaths_plot <- plot(national$new_deaths)

# Reflection: what do the plots of new cases and deaths tell us about the
# pandemic happening in "waves"? How (and why, do you think) these plots
# look different?


# Grouped analysis --------------------------------------------------------

# An incredible power of R is to perform the same computation *simultaneously*
# across groups of rows. The following questions rely on that capability.

# What is the county with the *current* (e.g., on the most recent date)
# highest number of cases in each state? Your answer, stored in
# `highest_in_each_state`, should be a *vector* of
# `location` names (the column with COUNTY, STATE).
# Hint: be careful about the order of filtering your data!
highest_in_each_state <- counties %>%
  group_by(state) %>%
  filter(date == max(date)) %>%
  filter(cases == max(cases)) %>%
  pull(location)

# Which locaiton (COUNTY, STATE) has had the highest number of cases
# in Washington? `highest_in_wa`
# (hint: you may need to find a match of a particular *string*, and you may
# just want to use base R syntax rather than a dplyr function)
highest_in_wa <- highest_in_each_state[str_detect(highest_in_each_state, "Washington")]
#[Ray] highest_in_wa not highest_in_washington

# What is the county with the *current* (e.g., on the most recent date)
# lowest number of deaths in each state? Your answer, stored in
# `lowest_in_each_state`, should be a *vector* of
# `location` names (the column with COUNTY, STATE).
lowest_in_each_state <- counties %>% 
  group_by(state) %>%
  filter(date == max(date, na.rm = TRUE)) %>%
  filter(deaths == min(deaths, na.rm = TRUE)) %>%
  pull(location)
#[Ray] You may want to use na.rm = T

# Reflection: Why are there so many observations (counties) in the variable
# `lowest_in_each_state` (i.e., wouldn't you expect the number to be ~50)?


# What *proportion* of counties have had zero deaths in each state? In other
# words, in each state, how many counties have had zero deaths, divided by
# the total number of counties in the state? You should return a *dataframe*
# with both the state name, and the proportion (`prop`) in a variable
# called `prop_no_deaths`
# (this one is tricky.... take your time)
prop_no_deaths <- counties %>%
  select(state, county, deaths) %>%
  group_by(state) %>%
  summarize(prop = (sum(deaths==0) / sum(deaths >= 0)))
#[Ray] You may also want to include those with 0 values' states.
#I cannot figure out what that is asking :(

# What proportion of counties in Washington have had zero deaths?
# `wa_prop_no_deaths`
wa_prop_no_deaths <- prop_no_deaths %>%
  filter(state == "Washington") %>%
  pull(prop)

# The following is a check on our understanding of the data.
# Presumably, if we add up all of the cases on each day in the
# `states` or `counties` dataset, they should add up to the number at the
# `national` level. So, let's check.

# First, let's create `state_by_day` by adding up the cases on each day in the
# `states` dataframe. For clarity, let's call the column with the total cases
# `state_total`
# This will be a dataframe with the columns `date` and `state_total`.
state_by_day <- states %>%
  group_by(date) %>%
  summarize(state_total = sum(cases))

# Next, let's create `county_by_day` by adding up the cases on each day in the
# `counties` dataframe. For clarity, let's call the column with the total cases
# `county_total`
# This will also be a dataframe, with the columns `date` and `county_total`.
county_by_day <- counties %>%
  group_by(date) %>%
  summarize(county_total = sum(cases))

# Now, there are a few ways to check if they are always equal. To start,
# let's *join* those two dataframes into one called `totals_by_day`
totals_by_day <-  left_join(state_by_day, county_by_day)

# Next, let's create a variable `all_totals` by joining `totals_by_day`
# to the `national` dataframe
all_totals <- left_join(totals_by_day, national)

# How many rows are there where the state total *doesn't equal* the natinal
# cases reported? `num_state_diff`
num_state_diff <- all_totals %>%
  filter(cases != state_total) %>%
  nrow()

# How many rows are there where the county total *doesn't equal* the natinal
# cases reported? `num_county_diff`
num_county_diff <- all_totals %>%
  filter(cases != county_total) %>%
  nrow()

# Oh no! An inconsistency -- let's dig further into this. Let's see if we can
# find out *where* this inconsistency lies. Let's take the county level data,
# and add up all of the cases to the state level on each day (e.g.,
# aggregating to the state level). Store this dataframe with three columns
# (state, date, county_totals) in the variable `sum_county_to_state`.
# (To avoid DPLYR automatically grouping your results,
# specify `.groups = "drop"` in your `summarize()` statement. This is a bit of
# an odd behavior....)
sum_county_to_state <- counties %>%
  group_by(date) %>%
  group_by(state) %>%
  summarize(county_totals = sum(cases), .groups = "drop")

sum_by_state <- states %>%
  group_by(date) %>%
  group_by(state) %>%
  summarize(state_total = sum(cases), .groups = "drop")

# Then, let's join together the `sum_county_to_state` dataframe with the
# `states` dataframe into the variable `joined_states`.
joined_states <- left_join(sum_county_to_state, sum_by_state)

# To find out where (and when) there is a discrepancy in the number of cases,
# create the variable `has_discrepancy`, which has *only* the observations
# where the sum of the county cases in each state and the state values are
# different. This will be a *dataframe*.
has_discrepancy <- joined_states %>%
  filter(county_totals != state_total)

# Next, lets find the *state* where there is the *highest absolute difference*
# between the sum of the county cases and the reported state cases.
# `state_highest_difference`.
# (hint: you may want to create a new column in `has_discrepancy` to do this.)
state_highest_difference <- has_discrepancy %>%
  mutate(has_discrepancy, difference = abs(state_total - county_totals)) %>%
  filter(difference == max(difference)) %>%
  pull(state)

# Independent exploration -------------------------------------------------

# Ask your own 3 questions: in the section below, pose 3 questions,
# then use the appropriate code to answer them.

# 1. What state had the *lowest absolute difference* between the sum of the 
# county cases and the reported state cases?
state_lowest_difference <- has_discrepancy %>%
  mutate(has_discrepancy, difference = abs(state_total - county_totals)) %>%
  filter(difference == max(difference)) %>%
  pull(state)

# 2. Which state has the lowest ratio of deaths to cases (deaths/cases), as of the
# most recent date? 
state_lowest_ratio <- updated_states %>%
  filter(date == max(date)) %>%
  filter(ratio == min(ratio)) %>%
  pull(state)

# 3. # What is the highest number of cases that have happened in a single county?
num_lowest_cases_county <- counties %>%
  filter(cases == min(cases)) %>%
  pull(cases)


# Reflection: What surprised you the most throughout your analysis?
