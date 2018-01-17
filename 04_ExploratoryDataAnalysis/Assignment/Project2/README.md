# Introduction

Fine particulate matter (PM_{2.5}) is an ambient air pollutant for which there
is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM_{2.5}. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the [EPA National Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of
PM_{2.5} were emitted from that source over the course of the entire year. The
data that we use for this assignment are for 1999, 2002, 2005, and
2008. The data is available [here](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip).

## Data

* **PM2.5 Emissions Data** (`𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜`): 

This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.

	- Variables:

		`𝚏𝚒𝚙𝚜`: A five-digit number (represented as a string) indicating the U.S. county

		`𝚂𝙲𝙲`: The name of the source as indicated by a digit string (see source code classification table)
	
		`𝙿𝚘𝚕𝚕𝚞𝚝𝚊𝚗𝚝`: A string indicating the pollutant
	
		`𝙴𝚖𝚒𝚜𝚜𝚒𝚘𝚗𝚜`: Amount of PM2.5 emitted, in tons
	
		`𝚝𝚢𝚙𝚎`: The type of source (point, non-point, on-road, or non-road)
	
		`𝚢𝚎𝚊𝚛`: The year of emissions recorded

* **Source Classification Code Table** (`𝚂𝚘𝚞𝚛𝚌𝚎_𝙲𝚕𝚊𝚜𝚜𝚒𝚏𝚒𝚌𝚊𝚝𝚒𝚘𝚗_𝙲𝚘𝚍𝚎.𝚛𝚍𝚜`ß): 

This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

Each of the two files can be read using the `𝚛𝚎𝚊𝚍𝚁𝙳𝚂()` function in R:

```r
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

## Goal
The overall goal is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999-2008.

* Questions

	- Have total emissions from PM_{2.5} decreased in the United States from 1999 to 2008? Using the **base** plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

	plot1.png

	- Have total emissions from PM2.5 decreased in the **Baltimore City**, Maryland(``𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶"``) from 1999 to 2008? Use the **base** plotting system to make a plot answering this question.

	plot2.png

	- Of the four types of sources indicated by the ``type`` (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for **Baltimore City**? Which have seen increases in emissions from 1999–2008? Use the **ggplot2** plotting system to make a plot answer this question.

	plot3.png

	- Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

	plot4.png

	- How have emissions from motor vehicle sources changed from 1999-2008 in  **Baltimore City**?

	plot5.png

	- Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in **Los Angeles County**, California (``𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"``). Which city has seen greater changes over time in motor vehicle emissions?

## Making and Submitting Plots 

For each plot you should

* Construct the plot and save it to a PNG file.

* Create a separate R code file (𝚙𝚕𝚘𝚝𝟷.𝚁, 𝚙𝚕𝚘𝚝𝟸.𝚁, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. 𝚙𝚕𝚘𝚝𝟷.𝚁 should only include code for producing 𝚙𝚕𝚘𝚝𝟷.𝚙𝚗𝚐)

* Upload the PNG file on the Assignment submission page

* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.


	plot6.png
