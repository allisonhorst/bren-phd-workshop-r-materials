#############################
# Bren PhD Workshop RStudio Day 1
# Allison Horst
# Instructor Script
#############################


#############################
#############################
# 1. Introduce the RStudio environment
#############################
#############################


#############################
#############################
# 2. Create a new project
#############################
#############################

# File > New Project > New Directory > New Project > Choose where/name (we're not worrying about version control - but if you're using Git, this is where you can create a repository...)

# Put it in a folder you can find, name it something easy (good habits...lowercase, limited puncuation, don't start with numbers, etc. mine will be called "my_project")

# Once you name/create the new project, it will automatically open in RStudio. Notice that the pathway is shown at the very top of your RStudio working environment. But there's nothing in it besides the project folder (see Files tab)...let's start adding to that project.


#############################
#############################
# 3. Create a new script
#############################
#############################

# We can work just in the console window...but that's a bummer. Every time you type something in, it runs. That means that you see all the error messages, etc., and it's almost impossible to store the work you do in the console in any way that is at all easy to follow later on.

# Show them just by creating variables in the console what that looks like and how it can be problematic for good data science.

# So instead, when we work in RStudio, we want to work in ways that are easy to follow (for you and collaborators) and easy to reproduce. One way to do that is by working in scripts. A script is like a text editor, where you can include active code AND inactive lines (comments). It only runs the code when you ask it to.

# To create a script, go up to File > New File > R Script and click. This will open a new blank window. Try typing a few things in there and press Enter - you'll notice that nothing happens. That's because we haven't told R to run anything yet, and unlike in the Console window, things don't run unless we tell it to. So how can we start writing a script?

# There are some best practices that we should be aware of.

# First: If your script only consists of active code, it's not a good script. YOU WILL NOT REMEMBER WHAT YOU DID NEXT WEEK, IN 3 WEEKS, in 3 YEARS. And your collaborators will have no idea what's happening. That means that your scripts (or markdown documents, eventually) should be fully documented, commented and fully explained. We create #COMMENTS using the pound sign (#) before typing.

# Start every script with a header that contains at least the following:
# A descriptive title.
# Your name and the date created.
# Any packages and files required
# Additional information (collaborators, Git repository, etc.) of use

# Err on the side of OVERCOMMENTING!!!! There is not really a downside to commenting on every single line.

#################################
# -------------
# ~~~~~
# Use spacing, symbols, etc. to create subsections that more easily break up your script
# Create clearly labeled subsections
#################################


#################################
#################################
# Step 4. Load the tidyverse (you'll basically always do this)
#################################
#################################

# Remember - to load a package, you first need to install it. You can do that by running install.packages("package_name"). But even once installed, you need to load it into R's active brain (explain here why that's the case). Do that using library(package_name).

library(tidyverse) # Load the tidyverse

# Note: readr (in tidyverse) contains the read_csv function for reading in csv files (comma separated values)

##############################
##############################
# Step 5. Load some data!
##############################
##############################

# This is MUCH EASIER if you're working in a project. All you need to do is drag and drop (copy - don't ever change a raw dataset) the dataset you want to work with in R into your PROJECT folder. Once you do that, it will show up in the 'Files' tab in RStudio. But it still isn't actively loaded - it's just in the working directory where R is going to easily find it. To load it into RStudio, use the read_csv("file_name.csv") function and assign it a data frame name:

df <- read_csv("day_4_r_materials/cal_ag.csv") # This reads in that .csv file and stores it at as a data frame 'df'

# NOW that data is actively loaded and we can start working with it. It will also show up in your RStudio 'Environment'

# Here - practice saving, closing, then opening the project again - notice that when you open the PROJECT file, it brings everything with it. But we still need to run the lines of code to do everything again. Use Command + Shift + Enter to run ALL active code in the script... (or Command + Enter to run things line-by-line)

################################
################################
# Step 6. Initial Data Exploration
################################
################################

# The first thing that you should always do when you load data into RStudio is LOOK AT IT. Then consider the data structure, distributions, etc. Here we'll use some basic tools and tricks to explore the data frame we loaded (mine is called 'df')

# Exploring structure of the dataset (sometimes you can just do this in the console if it's purely exploratory and you don't care at all about saving the results...but you MUST at least do this part)

# Use View() (a rare capitalized function) to bring up the data frame in a new window:
View(df)

# Use dim() to see the dimensions
dim(df)

# Use names() to see the variable names (tidy format - touch on this?)
names(df)

# summary() to see a brief summary (with the variable classes)
summary(df)

# class() to learn the class of the df
class(df) # what are tbl, tbl_df, data frame? Tibbles are data frames with some more modern functionality. We definitely don't need to worry about that now...but when you get more into it, you might be interested in learning some of the benefits of tibbles (which you can find online - if you're working with a lot of factors, sometimes things are a little easier)

# head() to see the first X lines of a df
head(df)
head(df, 10)

# tail() to see the last X lines of a df
tail(df)
tail(df, 10)

##########################
# Other operators that are useful
##########################

# $: Use a dollar sign to specify a certain column

total_value <- sum(df$Value) # This calculates the sum of everything in the 'Value' column - note that for this data, that does NOT make sense (because there are totals in that column)

# Use ? to get help with a function (or, the INTERNET)


##########################
##########################
# Step 7. Basic wrangling using dplyr functions
##########################
##########################

# There exist within dplyr (which is included in the tidyverse) a number of functions that are built to easily wrangle your data. That means filtering, subsetting, manipulating, adding, etc.

# Let's follow some steps to make a simplified data frame (first, a long way...then using "piping"). Here are the things we want to do:

# 1. Only keep the columns for CropName, County, Production, and Value
# 2. Rename the 'CropName' column to 'Type'
# 3. Filter to only include data for Fresno County
# 4. Add a new column that is Value in millions of dollars (need to divide by 1,000,000)
# 5. Arrange by decreasing value (in millions)
# 6. Only keep the top 10

# 1. Use select() to only keep specified columns:

df_2 <- select(df, CropName, County, Production, Value) # Retains only those 4 columns from df
# ALWAYS LOOK AT WHAT YOU'VE DONE
# You can similarly keep a range of columns with select(df, start:end)
# And can exclude a column with -column_name

# 2. Use rename() to rename the 'CropName' column to 'Type':

df_3 <- rename(df_2, Type = CropName) # Renames 'CropName' to 'Type'
# LOOK AGAIN

# 3. Filter to only include Fresno County

df_4 <- filter(df_3, County == "Fresno")
# LOOK AGAIN. Show examples here of 'or' argument (|), 'and' argument (&), and is NOT argument (!=)
# An easier way to include "or" statements: column_name %in% c("this","or","that")

# 4. Add new column that has value converted to millions of $$

df_5 <- mutate(df_4, prof_millions = Value / 1000000)
# LOOK AGAIN - this ADDS a column (why this is good practice)

# So that's pretty great, right? Or is it? For many of you, you might think "this seems really tedious and clunky for code." You're right. There is a better way, just be careful. That way is using 'piping'.

# 5. Arrange from high to low profits
df_6 <- arrange(df_5, -prof_millions)

# 6. Only keep the top 10
df_7 <- head(df_6, 10)

############################
############################
# Step 8. Piping
############################
############################

# Piping uses the pipe operator %>% (command + shift + m) to perform sequential operations in ORDER, without needing to save intermediate data frames. So let's say we want to do all the steps above, in a way that is way more efficient using piping.

# Here's how that would look (but you should STILL View the result after every line! With great power comes great responsibility!)

df_piping <- df %>%
  select(CropName, County, Production, Value) %>%
  rename(Type = CropName) %>%
  filter(County == "Fresno") %>%
  mutate(prof_millions = Value / 1000000) %>%
  arrange(-prof_millions) %>%
  head(10)

# Notice that the outcome of that piping process is the SAME, but the code is much cleaner!!! You should still add comments after each line of code so that when FUTURE YOU or COLLABORATORS want to check it out, they know what is happening in each line!


#########################
#########################
# Step 9. Get some basic summary information on the value column
#########################
#########################

fresno_totalvalue <- sum(df_piping$prof_millions)
fresno_meanvalue <- mean(df_piping$prof_millions)
fresno_sdvalue <- sd(df_piping$prof_millions)

# Tomorrow we'll learn group_by + summarize for pivot tables - a better way to get summary statistics!
# and purrr::map() to loop functions over all columns

# Some base R plots (showing for comparison w/ggplot2)
hist(df_piping$prof_millions)
qqnorm(df_piping$prof_millions)
plot(prof_millions ~ Production, df_piping) # not super useful...anyway

#########################
#########################
# Step 10. A quick graph in ggplot (if time)
#########################
#########################

# ggplot is a graphing package (also in the tidyverse) that allows you to more easily customize graphics (vs. base graphics)

my_graph <- ggplot(df_piping, aes(x = Type, y = prof_millions)) +
  geom_col() +
  theme_minimal() +
  coord_flip()

my_graph

# Call it to see it! But that's a really REAAAALLY bad graph...

# This weekend: practice creating a project, opening a script, loading a data frame, and doing some wrangling on it!
