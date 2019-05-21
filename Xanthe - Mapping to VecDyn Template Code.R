#######################################
## map and concatenate the GDPP data ##
#######################################
## load required packages ##
library(lubridate)
library(tidyr)
library(dplyr)
library(tidyverse)
library(readr)

## set working directory ##
setwd("/Users/Xanthe/Documents/Uni/3rd_year/Final_Year_Project/Data")

### data set 1 ###
RothamstedData <- read.csv("../Data/Rothamsted_Insect_Survey_Annual_Report_Parsed.csv", stringsAsFactors = FALSE) 
RothamstedData$DATA.DecimalYearBegin <- format(date_decimal(as.double(RothamstedData$DATA.DecimalYearBegin)), "%Y-%m-%d")
RothamstedData$DATA.DecimalYearEnd <- format(date_decimal(as.double(RothamstedData$DATA.DecimalYearEnd)), "%Y-%m-%d")

### data set 2 ###
gall_forming_aphids <- read.csv("../Data/Regular alternation of high and low population size of gall-forming aphids- analysis of ten years of data parsed.csv", stringsAsFactors = FALSE)
gall_forming_aphids$DATA.DecimalYearBegin <- format(date_decimal(as.double(gall_forming_aphids$DATA.DecimalYearBegin)), "%Y-%m-%d")
gall_forming_aphids$DATA.DecimalYearEnd <- format(date_decimal(as.double(gall_forming_aphids$DATA.DecimalYearEnd)), "%Y-%m-%d")

### data set 3 ###
deciduous_tree_dwelling_aphids <- read.csv("../Data/Population dynamics and abundance of deciduous tree - dwelling aphids parsed.csv", stringsAsFactors = FALSE)
deciduous_tree_dwelling_aphids$DATA.DecimalYearBegin <- format(date_decimal(as.double(deciduous_tree_dwelling_aphids$DATA.DecimalYearBegin)), "%Y-%m-%d")
deciduous_tree_dwelling_aphids$DATA.DecimalYearEnd <- format(date_decimal(as.double(deciduous_tree_dwelling_aphids$DATA.DecimalYearEnd)), "%Y-%m-%d")

### data set 4 ###
density_dependence_in_moths_aphids <- read.csv("../Data/patterns of density dependence in moths & aphids parsed.csv", stringsAsFactors = FALSE)
density_dependence_in_moths_aphids$DATA.DecimalYearBegin <- format(date_decimal(as.double(density_dependence_in_moths_aphids$DATA.DecimalYearBegin)), "%Y-%m-%d")
density_dependence_in_moths_aphids$DATA.DecimalYearEnd <- format(date_decimal(as.double(density_dependence_in_moths_aphids$DATA.DecimalYearEnd)), "%Y-%m-%d")

### concatenate data sets 1-4 ###
complete_data <- rbind(RothamstedData, gall_forming_aphids, deciduous_tree_dwelling_aphids, density_dependence_in_moths_aphids)

##########################################
## Map the data using Francis's methods ##
##########################################

#####################
## vecdyn template ##
#####################

### rename columns ###

#names(complete_data) <----- for when I was writing the code
names(complete_data)[1] <- "taxon"
names(complete_data)[58] <- "title"
## no info for "sampling_strategy" - perhaps "MAIN.SamplingProtocol"?
## no info for "sampling_method" - perhaps insert myself e.g. suction trap for that data set
names(complete_data) [9] <- "measurement_unit"
names(complete_data) [26] <- "sample_start_date"
names (complete_data) [27] <- "sample_end_date"
names(complete_data) [22] <- "sample_value" 
complete_data$sample_location <- complete_data$StudyLocation.ExactName
names(complete_data) [52] <- "sample_collection_area"
names(complete_data) [39] <- "sample_latitude_dd" 
names(complete_data) [38] <- "sample_longitude_dd"
names(complete_data) [57] <- "sample_environment"
names(complete_data) [21] <- "additional_sample_info"
complete_data$additional_sample_info2 <- "all dates were converted from decimal dates to YYYY-MM-DD format"

## merge columns into one ##
complete_data <- complete_data %>% tidyr::unite("location_description", c("StudyLocation.ExactName","StudyLocation.TownName", "StudyLocation.CountyStateProvince", "StudyLocation.Country"), sep = ", ")
complete_data <- complete_data %>% tidyr::unite("study_collection_area", c("StudyLocation.North", "StudyLocation.East", "StudyLocation.South", "StudyLocation.West"), sep = ", ")
complete_data <- complete_data %>% tidyr::unite("additional_location_info", c("StudyLocation.Notes", "StudyLocation.Notes.1"), sep = ", ")
complete_data <- complete_data %>% tidyr::unite("additional_sample_info", c("additional_sample_info", "additional_sample_info2"), sep = "; ")

##########################
## publication template ##
##########################

## rename columns ## 
names(complete_data) [52] <- "collection_author"
## repeat collection_author column for contact_name
names(complete_data) [54] <- "data_rights"

## remove unnecessary columns ##
complete_data <- complete_data[, c("taxon", "measurement_unit", "additional_sample_info", "sample_value", 
                                   "sample_start_date", "sample_end_date", "location_description", 
                                   "sample_longitude_dd", "sample_latitude_dd", "additional_location_info", 
                                   "study_collection_area", "sample_collection_area", "sample_environment", 
                                   "title", "collection_author", "data_rights", "sample_location")]

## add missing columns ##
complete_data$sampling_method <- as.character(NA)
complete_data$sample_sex <- as.character(NA)

## reorder columns ##
complete_data <- complete_data[, c(14, 1, 7, 11, 18, 2, 5, 6, 4, 19, 17, 12, 9, 8, 13, 10, 3)]

############################
## pull the Michigan data ##
############################
michigan_suction_traps <- read.csv("../Data/michigan suction traps exc intro sep genus species.csv", stringsAsFactors = FALSE)

## reformat date ##
michigan_suction_traps$sample_date <- format(as.Date(michigan_suction_traps$sample_date, format = "%d/%m/%Y"), "%Y-%m-%d")

##########################################
## Map the data (Michigan Suction Trap) ##
##########################################

#####################
## vecdyn template ##
#####################
## names(michigan_suction_traps) <----- used when writing code

michigan_suction_traps <- michigan_suction_traps %>% mutate(taxon = paste(genus, species, species2))
michigan_suction_traps$title <- "aphid collection tower site at KBS"
michigan_suction_traps$sampling_method <- "suction trap" 
michigan_suction_traps$measurement_unit <- "count"
michigan_suction_traps$sample_start_date <- michigan_suction_traps$sample_date
names(michigan_suction_traps) [1] <- "sample_end_date"
names(michigan_suction_traps) [8] <- "sample_value" 
names(michigan_suction_traps) [7] <- "sample_sex" 
michigan_suction_traps$sample_location <- michigan_suction_traps$station
michigan_suction_traps <- michigan_suction_traps %>% tidyr::unite("location_description", c("station","state"), sep = ", ")

michigan_suction_traps$sample_longitude_dd <- "-85.385778"
michigan_suction_traps$sample_latitude_dd <- "42.4056395"
michigan_suction_traps$measurement_unit <- "NA"
michigan_suction_traps$additional_sample_info <- "dates converted from DD-MM-YYYY to YYYY-MM_DD, study collection area is the bounding coordinates of Kellogg Biological Station according to https://lter.kbs.msu.edu/datasets/52, sample longitude and latitude are the average of these boundaries"
michigan_suction_traps$additional_location_info <- "NA"
michigan_suction_traps$study_collection_area <- "42.420265, -85.366857, 42.391019, -85.404699"
michigan_suction_traps$sample_collection_area <- "NA"
michigan_suction_traps$sample_environment <- "NA"

##########################
## publication template ##
##########################
michigan_suction_traps$collection_author <- "Kellogg Biological Station Long Term Ecological Research"
michigan_suction_traps$data_rights <- "public"

## reorder and select columns ##
michigan_suction_traps <- michigan_suction_traps[, c(9, 8, 2, 18, 10, 11, 12, 1, 7, 6, 13, 19, 15, 14, 20, 17, 16)]

## correct the latitudes and longitudes ##
Ames <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Ames, IA"),]
Ames$sample_latitude_dd <- "42.030781"
Ames$sample_longitude_dd <- "-93.631913"
Ames$additional_location_info <- "latitude and longitude were searched for online based on Ames, IA being given as the location of data collection. study collection area listed as those same coordinates"
Ames$study_collection_area <- "42.030781, -93.631913, 42.030781, -93.631913"

McNay <- michigan_suction_traps[which(michigan_suction_traps$location_description == "McNay, IA"),]
McNay$sample_latitude_dd <- "40.973422"
McNay$sample_longitude_dd <- "-93.422898"
McNay$additional_location_info <- "latitude and longitude were searched for online based on McNay, IA being given as the location of data collection. study collection area listed as those same coordinates"
McNay$study_collection_area <- "40.973422, -93.422898, 40.973422, -93.422898"

Nashua <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Nashua, IA"),]
Nashua$sample_latitude_dd <- "42.952222"
Nashua$sample_longitude_dd <- "-92.538638"
Nashua$additional_location_info <- "latitude and longitude were searched for online based on Nashua, IA being given as the location of data collection. study collection area listed as those same coordinates"
Nashua$study_collection_area <- "42.952222, -92.538638, 42.952222, -92.538638"

Brownstown <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Brownstown, IL"),]
Brownstown$sample_latitude_dd <- "41.953410"
Brownstown$sample_longitude_dd <- "-87.677838"
Brownstown$additional_location_info <- "latitude and longitude were searched for online based on Brownstown, IL being given as the location of data collection. study collection area listed as those same coordinates"
Brownstown$study_collection_area <- "41.953410, -87.677838, 41.953410, -87.677838"

Dekalb <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Dekalb, IL"),]
Dekalb$sample_latitude_dd <- "41.929474"
Dekalb$sample_longitude_dd <- "-88.750365"
Dekalb$additional_location_info <- "latitude and longitude were searched for online based on Dekalb, IL being given as the location of data collection. study collection area listed as those same coordinates"
Dekalb$study_collection_area <- "41.929474, -88.750365, 41.929474, -88.750365"

DixonSprings <- michigan_suction_traps[which(michigan_suction_traps$location_description == "DixonSprings, IL"),]
DixonSprings$sample_latitude_dd <- "37.384496"
DixonSprings$sample_longitude_dd <- "-88.668664"
DixonSprings$additional_location_info <- "latitude and longitude were searched for online based on Dixon Springs, IL being given as the location of data collection. study collection area listed as those same coordinates"
DixonSprings$study_collection_area <- "37.384496, -88.668664, 37.384496, -88.668664"
DixonSprings$location_description <- str_replace_all(DixonSprings$location_description, "DixonSprings, IL", "Dixon Springs, IL")

Monmouth <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Monmouth, IL"),]
Monmouth$sample_latitude_dd <- "40.911427"
Monmouth$sample_longitude_dd <- "-90.647358"
Monmouth$additional_location_info <- "latitude and longitude were searched for online based on Monmouth, IL being given as the location of data collection. study collection area listed as those same coordinates"
Monmouth$study_collection_area <- "40.911427, -90.647358, 40.911427, -90.647358"

Morris <- michigan_suction_traps[which(michigan_suction_traps$location_description == "MorrisIL, IL"),]
Morris$sample_latitude_dd <- "41.357254"
Morris$sample_longitude_dd <- "-88.421178"
Morris$additional_location_info <- "latitude and longitude were searched for online based on Morris, IL being given as the location of data collection. study collection area listed as those same coordinates"
Morris$study_collection_area <- "41.357254, -88.421178, 41.357254, -88.421178"
Morris$location_description <- str_replace_all(Morris$location_description, "MorrisIL, IL", "Morris, IL")

Perry <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Perry, IL"),]
Perry$sample_latitude_dd <- "39.783103"
Perry$sample_longitude_dd <- "-90.745406"
Perry$additional_location_info <- "latitude and longitude were searched for online based on Perry, IL being given as the location of data collection. study collection area listed as those same coordinates"
Perry$study_collection_area <- "39.783103, -90.745406, 39.783103, -90.745406"

Urbana <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Urbana, IL"),]
Urbana$sample_latitude_dd <- "40.110588"
Urbana$sample_longitude_dd <- "-88.207270"
Urbana$additional_location_info <- "latitude and longitude were searched for online based on Urbana, IL being given as the location of data collection. study collection area listed as those same coordinates"
Urbana$study_collection_area <- "40.110588, -88.207270, 40.110588, -88.207270"

DPAC <- michigan_suction_traps[which(michigan_suction_traps$location_description == "DPAC, IN"),]
DPAC$sample_latitude_dd <- "40.253352"
DPAC$sample_longitude_dd <- "-85.148034"
DPAC$additional_location_info <- "latitude and longitude were searched for online based on DPAC, IN being given as the location of data collection. study collection area listed as those same coordinates"
DPAC$study_collection_area <- "40.253352, -85.148034, 40.253352, -85.148034"
DPAC$location_description <- str_replace_all(DPAC$location_description, "DPAC, IN", "Davis Purdue Agriculture Center, IN")

NEPAC <- michigan_suction_traps[which(michigan_suction_traps$location_description == "NEPAC, IN"),]
NEPAC$sample_latitude_dd <- "41.107299"
NEPAC$sample_longitude_dd <- "-85.399532"
NEPAC$additional_location_info <- "latitude and longitude were searched for online based on NEPAC, IN being given as the location of data collection. study collection area listed as those same coordinates"
NEPAC$study_collection_area <- "41.107299, -85.399532, 41.107299, -85.399532"
NEPAC$location_description <- str_replace_all(NEPAC$location_description, "NEPAC, IN", "North East Purdue Agriculture Center, IN")

PIT <- michigan_suction_traps[which(michigan_suction_traps$location_description == "PIT, IN"),]
PIT$sample_latitude_dd <- "40.267194"
PIT$sample_longitude_dd <- "-86.134902"
PIT$additional_location_info <- "latitude and longitude were searched for online based on PIT, IN being given as the location of data collection. study collection area listed as those same coordinates"
PIT$study_collection_area <- "40.267194, -86.134902, 40.267194, -86.134902"
PIT$location_description <- str_replace_all(PIT$location_description, "PIT, IN", "South Campus of Purdue University, IN")

SEPAC <- michigan_suction_traps[which(michigan_suction_traps$location_description == "SEPAC, IN"),]
SEPAC$sample_latitude_dd <- "39.033145"
SEPAC$sample_longitude_dd <- "-85.525825"
SEPAC$additional_location_info <- "latitude and longitude were searched for online based on SEPAC, IN being given as the location of data collection. study collection area listed as those same coordinates"
SEPAC$study_collection_area <- "39.033145, -85.525825, 39.033145, -85.525825"
SEPAC$location_description <- str_replace_all(SEPAC$location_description, "SEPAC, IN", "South East Purdue Agriculture Center, IN")

Manhattan <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Manhattan, KS"),]
Manhattan$sample_latitude_dd <- "39.183608"
Manhattan$sample_longitude_dd <- "-96.571669"
Manhattan$additional_location_info <- "latitude and longitude were searched for online based on Manhattan, KS being given as the location of data collection. study collection area listed as those same coordinates"
Manhattan$study_collection_area <- "39.183608, -96.571669, 39.183608, -96.571669"

Kellogg <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Kellogg, MI"),]
Kellogg$sample_latitude_dd <- "42.40564"
Kellogg$sample_longitude_dd <- "-85.38578"
Kellogg$additional_location_info <- "study collection area provided on KBS website. Latitude and longitude are the average of those latitudinal and longitudinal points given."
Kellogg$study_collection_area <- "42.420265, -85.366857, 42.391019, -85.404699"

Monroe <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Monroe, MI"),]
Monroe$sample_latitude_dd <- "41.916434"
Monroe$sample_longitude_dd <- "-83.397710"
Monroe$additional_location_info <- "latitude and longitude were searched for online based on Monroe, MI being given as the location of data collection. study collection area listed as those same coordinates"
Monroe$study_collection_area <- "41.916434, -83.397710, 41.916434, -83.397710"

Lamberton <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Lamberton, MN"),]
Lamberton$sample_latitude_dd <- "44.231068"
Lamberton$sample_longitude_dd <- "-95.264164"
Lamberton$additional_location_info <- "latitude and longitude were searched for online based on Lamberton, MN being given as the location of data collection. study collection area listed as those same coordinates"
Lamberton$study_collection_area <- "44.231068, -95.264164, 44.231068, -95.264164"

Antigo <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Antigo, WI"),]
Antigo$sample_latitude_dd <- "45.140245"
Antigo$sample_longitude_dd <- "-89.152335"
Antigo$additional_location_info <- "latitude and longitude were searched for online based on Antigo, WI being given as the location of data collection. study collection area listed as those same coordinates"
Antigo$study_collection_area <- "45.140245, -89.152335, 45.140245, -89.152335"

Arlington <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Arlington, WI"),]
Arlington$sample_latitude_dd <- "43.338044"
Arlington$sample_longitude_dd <- "-89.380396"
Arlington$additional_location_info <- "latitude and longitude were searched for online based on Arlington, WI being given as the location of data collection. study collection area listed as those same coordinates"
Arlington$study_collection_area <- "43.338044, -89.380396, 43.338044, -89.380396"

EauClaire <- michigan_suction_traps[which(michigan_suction_traps$location_description == "EauClaire, WI"),]
EauClaire$sample_latitude_dd <- "44.811349"
EauClaire$sample_longitude_dd <- "-91.498494"
EauClaire$additional_location_info <- "latitude and longitude were searched for online based on Eau Claire, WI being given as the location of data collection. study collection area listed as those same coordinates"
EauClaire$study_collection_area <- "44.811349, -91.498494, 44.811349, -91.498494"
EauClaire$location_description <- str_replace_all(EauClaire$location_description, "EauClaire, WI", "Eau Claire, WI")

Hancock <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Hancock, WI"),]
Hancock$sample_latitude_dd <- "44.133584"
Hancock$sample_longitude_dd <- "-89.523177"
Hancock$additional_location_info <- "latitude and longitude were searched for online based on Hancock, WI being given as the location of data collection. study collection area listed as those same coordinates"
Hancock$study_collection_area <- "44.133584, -89.523177, 44.133584, -89.523177"

Seymour <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Seymour, WI"),]
Seymour$sample_latitude_dd <- "44.514988"
Seymour$sample_longitude_dd <- "-88.330380"
Seymour$additional_location_info <- "latitude and longitude were searched for online based on Seymour, WI being given as the location of data collection. study collection area listed as those same coordinates"
Seymour$study_collection_area <- "44.514988, -88.330380, 44.514988, -88.330380"

Walworth <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Walworth, WI"),]
Walworth$sample_latitude_dd <- "42.531128"
Walworth$sample_longitude_dd <- "-88.599546"
Walworth$additional_location_info <- "latitude and longitude were searched for online based on Walworth, WI being given as the location of data collection. study collection area listed as those same coordinates"
Walworth$study_collection_area <- "42.531128, -88.599546, 42.531128, -88.599546"

PPAC <- michigan_suction_traps[which(michigan_suction_traps$location_description == "PPAC, IN"),]
PPAC$sample_latitude_dd <- "41.439920"
PPAC$sample_longitude_dd <- "-86.925216"
PPAC$additional_location_info <- "latitude and longitude were searched for online based on PPAC, IN being given as the location of data collection. study collection area listed as those same coordinates"
PPAC$study_collection_area <- "41.439920, -86.925216, 41.439920, -86.925216"
PPAC$location_description <- str_replace_all(PPAC$location_description, "PPAC, IN", "Pinney Purdue Agriculture Center, IN")

EastLansing <- michigan_suction_traps[which(michigan_suction_traps$location_description == "EastLansing, MI"),]
EastLansing$sample_latitude_dd <- "42.736979"
EastLansing$sample_longitude_dd <- "-84.483865"
EastLansing$additional_location_info <- "latitude and longitude were searched for online based on East Lansing, MI being given as the location of data collection. study collection area listed as those same coordinates"
EastLansing$study_collection_area <- "42.736979, -84.483865, 42.736979, -84.483865"
EastLansing$location_description <- str_replace_all(EastLansing$location_description, "EastLansing, MI", "East Lansing, MI")

MorrisMN <- michigan_suction_traps[which(michigan_suction_traps$location_description == "MorrisMN, MN"),]
MorrisMN$sample_latitude_dd <- "45.591944"
MorrisMN$sample_longitude_dd <- "-95.918889"
MorrisMN$additional_location_info <- "latitude and longitude were searched for online based on Morris, MN being given as the location of data collection. study collection area listed as those same coordinates"
MorrisMN$study_collection_area <- "45.591944, -95.918889, 45.591944, -95.918889"
MorrisMN$location_description <- str_replace_all(MorrisMN$location_description, "MorrisMN, MN", "Morris, MN")

Rosemount <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Rosemount, MN"),]
Rosemount$sample_latitude_dd <- "44.739410"
Rosemount$sample_longitude_dd <- "-93.125772"
Rosemount$additional_location_info <- "latitude and longitude were searched for online based on Rosemount, MN being given as the location of data collection. study collection area listed as those same coordinates"
Rosemount$study_collection_area <- "44.739410, -93.125772, 44.739410, -93.125772"

Brookings <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Brookings, SD"),]
Brookings$sample_latitude_dd <- "44.311357"
Brookings$sample_longitude_dd <- "-96.798388"
Brookings$additional_location_info <- "latitude and longitude were searched for online based on Brookings, SD being given as the location of data collection. study collection area listed as those same coordinates"
Brookings$study_collection_area <- "44.311357, -96.798388, 44.311357, -96.798388"

Lancaster <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Lancaster, WI"),]
Lancaster$sample_latitude_dd <- "42.847490"
Lancaster$sample_longitude_dd <- "-90.710682"
Lancaster$additional_location_info <- "latitude and longitude were searched for online based on Lancaster, WI being given as the location of data collection. study collection area listed as those same coordinates"
Lancaster$study_collection_area <- "42.847490, -90.710682, 42.847490, -90.710682"

BeanBeet <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Bean&Beet, MI"),]
BeanBeet$sample_latitude_dd <- "43.399284"
BeanBeet$sample_longitude_dd <- "-83.697728"
BeanBeet$additional_location_info <- "latitude and longitude were searched for online based on Bean & Beet, MI  being given as the location of data collection. study collection area listed as those same coordinates"
BeanBeet$study_collection_area <- "43.399284, -83.697728, 43.399284, -83.697728"
BeanBeet$location_description <- str_replace_all(BeanBeet$location_description, "Bean&Beet, MI", "Saginaw Valley Research & Extension Center, MI")

Rhinelander <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Rhinelander, WI"),]
Rhinelander$sample_latitude_dd <- "45.636623"
Rhinelander$sample_longitude_dd <- "-89.412075"
Rhinelander$additional_location_info <- "latitude and longitude were searched for online based on Rhinelander, WI  being given as the location of data collection. study collection area listed as those same coordinates"
Rhinelander$study_collection_area <- "45.636623, -89.412075, 45.636623, -89.412075"

Sutherland <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Sutherland, IA"),]
Sutherland$sample_latitude_dd <- "42.974143"
Sutherland$sample_longitude_dd <- "-95.497506"
Sutherland$additional_location_info <- "latitude and longitude were searched for online based on Sutherland, IA  being given as the location of data collection. study collection area listed as those same coordinates"
Sutherland$study_collection_area <- "42.974143, -95.497506, 42.974143, -95.497506"

Crookston <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Crookston, MN"),]
Crookston$sample_latitude_dd <- "47.774562"
Crookston$sample_longitude_dd <- "-96.609391"
Crookston$additional_location_info <- "latitude and longitude were searched for online based on Crookston, MN  being given as the location of data collection. study collection area listed as those same coordinates"
Crookston$study_collection_area <- "47.774562, -96.609391, 47.774562, -96.609391"

Columbia <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Columbia, MO"),]
Columbia$sample_latitude_dd <- "38.951705"
Columbia$sample_longitude_dd <- "-92.334072"
Columbia$additional_location_info <- "latitude and longitude were searched for online based on Columbia, MO  being given as the location of data collection. study collection area listed as those same coordinates"
Columbia$study_collection_area <- "38.951705, -92.334072, 38.951705, -92.334072"

Metamora <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Metamora, IL"),]
Metamora$sample_latitude_dd <- "40.790592"
Metamora$sample_longitude_dd <- "-89.360643"
Metamora$additional_location_info <- "latitude and longitude were searched for online based on Metamora, IL  being given as the location of data collection. study collection area listed as those same coordinates"
Metamora$study_collection_area <- "40.790592, -89.360643, 40.790592, -89.360643"

Sanilac <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Sanilac, MI"),]
Sanilac$sample_latitude_dd <- "43.406904"
Sanilac$sample_longitude_dd <- "-82.734714"
Sanilac$additional_location_info <- "latitude and longitude were searched for online based on Sanilac, MI  being given as the location of data collection. study collection area listed as those same coordinates"
Sanilac$study_collection_area <- "43.406904, -82.734714, 43.406904, -82.734714"

ACRE <- michigan_suction_traps[which(michigan_suction_traps$location_description == "ACRE, IN"),]
ACRE$sample_latitude_dd <- "40.471148"
ACRE$sample_longitude_dd <- "-86.992231"
ACRE$additional_location_info <- "latitude and longitude were searched for online based on ACRE, IN  being given as the location of data collection. study collection area listed as those same coordinates"
ACRE$study_collection_area <- "40.471148, -86.992231, 40.471148, -86.992231"
ACRE$location_description <- str_replace_all(ACRE$location_description, "ACRE, IN", "Agronomy Center for Research and Education")

Portageville <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Portageville, MO"),]
Portageville$sample_latitude_dd <- "36.425341"
Portageville$sample_longitude_dd <- "-89.699526"
Portageville$additional_location_info <- "latitude and longitude were searched for online based on Portageville, MO  being given as the location of data collection. study collection area listed as those same coordinates"
Portageville$study_collection_area <- "36.425341, -89.699526, 36.425341, -89.699526"

Lexington <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Lexington, KY"),]
Lexington$sample_latitude_dd <- "38.040584"
Lexington$sample_longitude_dd <- "-84.503716"
Lexington$additional_location_info <- "latitude and longitude were searched for online based on Lexington, KY  being given as the location of data collection. study collection area listed as those same coordinates"
Lexington$study_collection_area <- "38.040584, -84.503716, 38.040584, -84.503716"

Princeton <- michigan_suction_traps[which(michigan_suction_traps$location_description == "Princeton, KY"),]
Princeton$sample_latitude_dd <- "37.109216"
Princeton$sample_longitude_dd <- "-87.881959"
Princeton$additional_location_info <- "latitude and longitude were searched for online based on Princeton, KY  being given as the location of data collection. study collection area listed as those same coordinates"
Princeton$study_collection_area <- "37.109216, -87.881959, 37.109216, -87.881959"

##############################
## concatenate all the data ##
##############################
complete_data <- rbind (complete_data, Ames, McNay, Nashua, Brownstown, Dekalb, DixonSprings, Monmouth,
                        Morris, Perry, Urbana, DPAC, NEPAC, PIT, SEPAC, Manhattan, Kellogg, Monroe, 
                        Lamberton, Antigo, Arlington, EauClaire, Hancock, Seymour, Walworth, PPAC, 
                        EastLansing, MorrisMN, Rosemount, Brookings, Lancaster, BeanBeet, Rhinelander, 
                        Sutherland, Crookston, Columbia, Metamora, Sanilac, ACRE, Portageville,
                        Lexington, Princeton)

## clean up names ##
complete_data$taxon <- str_replace_all(complete_data$taxon, "Brachycaudas helichrysi", "Brachycaudus helichrysi")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Cavariella oegopodii", "Cavariella aegopodii")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Cinara", "Cinara sp")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Adelgids NA", "Adelgids sp")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Metapolophium dirhodum", "Metopolophium dirhodum")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Metapolophium festucae", "Metopolophium festucae")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Moneleopsis caryae", "Monelliopsis caryae")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Monellopsis caryae", "Monelliopsis caryae")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Myzocallis Lineomyzocallissp", "Myzocallis Lineomyzocallis sp")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Phylloxerids NA", "Phylloxerids sp")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Pterocallis alni", "Petrocallis alni")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Pterocallis alnifoliae", "Petrocallis alnifoliae")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Rhospalosiphum padi", "Rhopalosiphum padi")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Unknown NA", "Unknown sp")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Uroleucon Lambersiussp", "Uroleucon Lambersius sp")
complete_data$taxon <- str_replace_all(complete_data$taxon, "Prociphilines (genus Prociphilus)", "Prociphilus sp")

View(complete_data)
write_csv(complete_data, "complete_data.csv", na = "")