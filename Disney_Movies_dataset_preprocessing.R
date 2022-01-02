#Set Working Directory
setwd("C:/Users/utente/Documents/R/GitHub_Projects/Disney_Movies_dataset_analysis")

#Import packages
library(tidyverse)
library(readxl)
library(writexl)
library(dplyr)


#Import dataset
data <- read.csv("./disney_movies_total_gross.csv")

#Descriptive statistics
library(summarytools)
view(dfSummary(data))


#Rename columns
names(data) <- c("Title","Release_Date","Genre",
                 "MPAA_Rating","Total_Gross","Adjusted_Gross")

##Genre column
unique(data$Genre)

no <- filter(data, Genre == "")%>%
              select(Title,Genre,MPAA_Rating) # no genre

Genre_missing <- c("Musical","Comedy","Adventure","Comedy",
                   "Adventure","Comedy","Musical","Comedy",
                   "Comedy","Thriller/Suspense","Comedy",
                   "Drama","Thriller/Suspense","Comedy",
                   "Documentary","Comedy","Black Comedy")

#Replace missing values in original dataset
data[which(data$Genre == ""),3] <- Genre_missing

##MPAA_Rating column
unique(data$MPAA_Rating)

no <- data[which(data$MPAA_Rating == ""),1:4] #no rating

#Replace missing values in original dataset
MPAA_missing <- as.data.frame(c(rep("G",52),"R",rep("G",3)))
data[which(data$MPAA_Rating == ""),4] <- MPAA_missing

no <- data[which(data$MPAA_Rating == "Not Rated"),1:4] # not rated
data[which(data$MPAA_Rating == "Not Rated"),4] <- "G"

index <- which(grepl("€", data$Title, fixed = TRUE))
data[index,1]

#Adjust cells' names
index <- which(grepl("€", data$Title, fixed = TRUE))
data[index,1]

no <- c("The Last Flight of Noah's Ark", "DuckTales: The Movie - Treasure of the Lost Lamp",
         "Homeward Bound II: Lost in San Francisco",  "An Alan Smithee Film: Burn Hollywood Burn",
         "Pirates of the Caribbean: The Curse of the Black Pearl",
         "The Chronicles of Narnia: The Lion, the Witch and the Wardrobe",
         "Pirates of the Caribbean: Dead Man's Chest", "Tim Burton's The Nightmare Before Christmas",
         "Pirates of the Caribbean: At World's End", "Hannah Montana & Miley Cyrus: Best of Both Worlds Concert",
         "Jonas Brothers: The 3D Concert Experiance¦", "Pirates of the Caribbean: On Stranger Tides",
         "Alexander and the Terrible, Horrible, No Good, Very Bad Day", "Pete's Dragon")

data[index,1] <- no #replace values with anomalous characters

#Export preprocessed dataset as .xlsx file
write_xlsx(data,".\\Disney Movies Preprocessed.xlsx")

data <- data[order(data$Total_Gross,decreasing = TRUE),]
