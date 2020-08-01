# Saving plots and Writing data
## Saving plots in RStudio
# 1. ggsave()
library(ggplot2)
ggplot(data=gapminder,
       aes(x=year, y=lifeExp, colour=country)) +
    geom_line() +
    theme(legend.position = "none")
ggsave("PlotName.pdf")

# 2. Export from RStudio
# - Make your plot in the RStudio
# - Go to the lower right panel 
# - Select the tab `Plots`
# - Select the options for export from the drop-down menu
# - Save as image or Save as pdf or Copy to clipboard

# 3. Plotting devices
# Plotting devices can be used in the `R` and `RStudio` to save plots. 
# We can control the size and resolution of the plots to be saved using
# arguments to the plotting devices. 
# One such plotting device is `pdf`. 
# The below code chunk can be used to save the `ggplot` as a `pdf` file with the
# specified height and width.


pdf("Life_Exp_vs_time.pdf", width=12, height=4)
ggplot(data=gapminder,
       aes(x=year, y=lifeExp, colour=country)) +
    geom_line() +
    theme(legend.position = "none")
# Make sure to turn off the pdf device.
# Else, the plot won't be saved.
dev.off()


# jpeg, png, tiff etc. are other plotting devices available in `R` to save plots. 
# They can be called with arguments similar to the pdf(). 
# jpeg(..)
# png(..)
# tiff(..)


## Writing Table
# 
# We can use the `write.table()` function for writing tables,
# similar to `read.table()` we used for importing data.
# 
# We can now select the gapminder data for Australia and write it to a table.
#

#subset the data
aust_subset <- gapminder[gapminder$country == "Australia",]
#write the data
write.table(aust_subset,
            file="cleaned-data/gapminder-aus.csv",
            sep=","
)

# For help on the `write.table` function, use the `help` function.
help(write.table)


# Lets use additional arguments for the `write.table` function 
# so that quotes are not present for the values (option `quotes=FALSE`)
# and row names are not written to the cleaned file.

write.table(
    gapminder[gapminder$country == "Australia",],
    file="cleaned-data/gapminder-aus.csv",
    sep=",", quote=FALSE, row.names=FALSE
)

# Lets use the RStudio **`Terminal`** again and examine the cleaned file
# `head cleaned-data/gapminder-aus.csv``



