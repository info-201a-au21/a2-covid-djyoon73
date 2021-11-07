# A2: U.S. COVID Trends

## Overview
In many ways, we have come to understand the gravity and trends in the COVID-19 pandemic through quantitative means. Regardless of media source, people are consuming more epidemiological information than ever, primarily through reported figures, charts, and maps.

This assignment is your opportunity to work directly with the same data used by the New York Times. While the analysis is guided through a series of questions, it is your opportunity to use programming skills to ask more detailed questions about the pandemic.

You'll load the data directly from the [New York Times GitHub page](https://github.com/nytimes/covid-19-data/), and you should make sure to read through their documentation to understand the meaning of the datasets.

Note, this is a long assignment, meant to be completed over the two weeks when we'll be learning data wrangling skills. I strongly suggest that you **start early**, and approach it with patience. We're asking real questions of real data, and there is inherent trickiness involved.

## Analysis
You should start this assignment by opening up your `analysis.R` script. The script will guide you through an initial analysis of the data. Throughout the script, there are prompts labeled **Reflection**. Please write 1 - 2 sentences for each of these reflections below:

- What does each row in the data represent (hint: read the [documentation](https://github.com/nytimes/covid-19-data/)!)?
  Each row of data represents the cumulative number of coronavirus cases and deaths based on the reporting up to the moment.

- What did you learn about the dataset when you calculated the state with the lowest cases (and what does that tell you about testing your assumptions in a dataset)?
  I learned that Washington had the lowest number of cases as of the most recent date. This tells me that there must have been a combination of several factors such as vaccination rate, strict policies, and policy obedience that explain why Washington is the lowest.

- Is the location with the highest number of cases the location with the most deaths? If not, why do you believe that may be the case?
  The location with the highest number of cases is not the same as the location with the most deaths. This may be different because of differing demographics in the area. It may be that the location with the most deaths have more immunocompromised people including elderly or young children.

- What do the plots of cases and deaths tell us about the  pandemic happening in "waves"? How (and why, do you think) these plots look so different?
  The two plots actually do not look very different, they look almost identical, explaining the consistent proportionate nature of COVID deaths to cases. The plots show us that the pandemic happens in "waves", where there are periods of rapid increase but also stagnant periods.

- Why are there so many observations (counties) in the variable `lowest_in_each_state` (i.e., wouldn't you expect the number to be ~50)?
  There could be multiple counties in different states where the number of deaths was 0 (the lowest possible minimum). Therefore, since there could have been multiple counties in each of the 50 states, we see many more observations (counties) in the variable 'lowest_in_each_state'.

- What surprised you the most throughout your analysis?
  Something that surprised me most throughout my analysis was the discrepancies between the national, states, and county datasets. It leads me to question why those discrepancies occur, perhaps a flaw in data collection? What does one do when such discrepancies exist, and how does it affect data analysis?
