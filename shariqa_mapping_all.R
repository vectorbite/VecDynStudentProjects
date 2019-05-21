
library(tidyverse)

##MANatee
manatee_2012<-read.csv('../data/zenodo/manatee/VectorBase-2012-Manatee_County_Mosquito_Control_District_Florida_USA.csv',stringsAsFactors=FALSE)
manatee_2013<-read.csv('../data/zenodo/manatee/VectorBase-2013-Manatee_County_Mosquito_Control_District_Florida_USA.csv',stringsAsFactors=FALSE)
manatee_2014<-read.csv('../data/zenodo/manatee/VectorBase-2014-Manatee_County_Mosquito_Control_District_Florida_USA.csv',stringsAsFactors=FALSE)
manatee_2015<-read.csv('../data/zenodo/manatee/VectorBase-2015-Manatee_County_Mosquito_Control_District_Florida_USA.csv',stringsAsFactors=FALSE)
manatee_2016<-read.csv('../data/zenodo/manatee/VectorBase-2016-Manatee_County_Mosquito_Control_District_Florida_USA.csv',stringsAsFactors=FALSE)
Manatee_total<-rbind(manatee_2012, manatee_2013, manatee_2014, manatee_2015, manatee_2016)

Manatee_total<-
  Manatee_total%>%
  tidyr::unite("location_description", c("location_ADM2","location_ADM1", "location_country"), sep = ",")
write.csv(Manatee_total, file = "Manatee_total", row.names = FALSE)
#Manatee_total$location_description<-paste(Manatee_total$location_ADM2, ",", Manatee_total$location_ADM1, ",", Manatee_total$location_country)
##applying the title

titlem2012<-rep("Manatee County Mosquito Control District entomological monitoring 2012", nrow(manatee_2012))
titlem2013<-rep("Manatee County Mosquito Control District entomological monitoring 2013", nrow(manatee_2013))
titlem2014<-rep("Manatee County Mosquito Control District entomological monitoring 2014", nrow(manatee_2014))
titlem2015<-rep("Manatee County Mosquito Control District entomological monitoring 2015", nrow(manatee_2015))
titlem2016<-rep("Manatee County Mosquito Control District entomological monitoring 2016", nrow(manatee_2016))

title<-c(titlem2012,titlem2013,titlem2014,titlem2015,titlem2016)
taxon <- Manatee_total$species
sample_value <- Manatee_total$sample_count
sample_sex <- Manatee_total$sex
sample_stage <-  Manatee_total$developmental_stage 
sample_start_date <- Manatee_total$collection_date_start
sample_end_date <- Manatee_total$collection_date_end
sample_lat_dd <- Manatee_total$GPS_lat
sample_long_dd <- Manatee_total$GPS_lon
sample_location <- Manatee_total$location
location_description <- Manatee_total$location_description
sampling_method <- Manatee_total$attractant
sampling_protocol <- Manatee_total$trap_type
species_id_method <- Manatee_total$identification_method
sample_name <-  Manatee_total$trap_id

vecdyn_manatee_total  <- data.frame(title = character(),
                                 taxon = character(),
                                 location_description = character(),
                                 study_collection_area = character(),
                                 geo_datum = character(),
                                 gps_obfuscation_info = character(),
                                 species_id_method = character(),
                                 study_design = character(),
                                 sampling_strategy = character(),
                                 sampling_method = character(),
                                 sampling_protocol = character(),
                                 measurement_unit = character(),
                                 value_transform = character(),
                                 sample_start_date = character(),
                                 sample_start_time = character(),
                                 sample_end_date =  character(),
                                 sample_end_time = character(),
                                 sample_value = numeric(),
                                 sample_sex = character(),
                                 sample_stage = character(),
                                 sample_location = character(),
                                 sample_collection_area = character(),
                                 sample_lat_dd = character(),
                                 sample_long_dd = character(),
                                 sample_environment = character(),
                                 additional_location_info = character(),
                                 additional_sample_info = character(),
                                 sample_name = character(),
                                 stringsAsFactors=FALSE)

a <- cbind(title, taxon, sample_value, sample_sex, sample_stage, sample_start_date, sample_end_date, sample_lat_dd, sample_long_dd, sample_location, location_description, sampling_method, sampling_protocol, species_id_method, sample_name)
a <- data.frame(a, stringsAsFactors=FALSE)
vecdyn_manatee_total <- rbind.fill(vecdyn_manatee_total, a)

View(vecdyn_manatee_total)

unique(Manatee_total$species)
max(vecdyn_manatee_total$taxon)

#Anastasia
Anas_2004= read.csv('../data/zenodo/anastasia/VectorBase-2004-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2005= read.csv('../data/zenodo/anastasia/VectorBase-2005-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2006= read.csv('../data/zenodo/anastasia/VectorBase-2006-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2007= read.csv('../data/zenodo/anastasia/VectorBase-2007-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2008= read.csv('../data/zenodo/anastasia/VectorBase-2008-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2009= read.csv('../data/zenodo/anastasia/VectorBase-2009-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2010= read.csv('../data/zenodo/anastasia/VectorBase-2010-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2011= read.csv('../data/zenodo/anastasia/VectorBase-2011-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2012= read.csv('../data/zenodo/anastasia/VectorBase-2012-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2013= read.csv('../data/zenodo/anastasia/VectorBase-2013-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2014= read.csv('../data/zenodo/anastasia/VectorBase-2014_BG-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2015= read.csv('../data/zenodo/anastasia/VectorBase-2015_BG-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2016= read.csv('../data/zenodo/anastasia/VectorBase-2016_BG-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)
Anas_2017= read.csv('../data/zenodo/anastasia/VectorBase-2017_BG-Anastasia_Mosquito_Control_District_Florida_USA.csv', stringsAsFactors = FALSE)

Anas_total= rbind(Anas_2004,Anas_2005,Anas_2006,Anas_2007,Anas_2008,Anas_2009,Anas_2010,Anas_2011,Anas_2012,Anas_2013,Anas_2014,Anas_2015,Anas_2016,Anas_2017)


##title application
title_anas04<- rep("Anastasia Mosquito Control District entomological monitoring 2004", nrow(Anas_2004))
title_anas05<- rep("Anastasia Mosquito Control District entomological monitoring 2004", nrow(Anas_2005))
title_anas06<- rep("Anastasia Mosquito Control District entomological monitoring 2006", nrow(Anas_2006))
title_anas07<- rep("Anastasia Mosquito Control District entomological monitoring 2007", nrow(Anas_2007))
title_anas08<- rep("Anastasia Mosquito Control District entomological monitoring 2008", nrow(Anas_2008))
title_anas09<- rep("Anastasia Mosquito Control District entomological monitoring 2009", nrow(Anas_2009))
title_anas10<- rep("Anastasia Mosquito Control District entomological monitoring 2010", nrow(Anas_2010))
title_anas11<- rep("Anastasia Mosquito Control District entomological monitoring 2011", nrow(Anas_2011))
title_anas12<- rep("Anastasia Mosquito Control District entomological monitoring 2012", nrow(Anas_2012))
title_anas13<- rep("Anastasia Mosquito Control District entomological monitoring 2013", nrow(Anas_2013))
title_anas14<- rep("Anastasia Mosquito Control District entomological monitoring 2014", nrow(Anas_2014))
title_anas15<- rep("Anastasia Mosquito Control District entomological monitoring 2015", nrow(Anas_2015))
title_anas16<- rep("Anastasia Mosquito Control District entomological monitoring 2016", nrow(Anas_2016))
title_anas17<- rep("Anastasia Mosquito Control District entomological monitoring 2017", nrow(Anas_2017))



vecdyn_Anastasia_total  <- data.frame(title = character(),
                                    taxon = character(),
                                    location_description = character(),
                                    study_collection_area = character(),
                                    geo_datum = character(),
                                    gps_obfuscation_info = character(),
                                    species_id_method = character(),
                                    study_design = character(),
                                    sampling_strategy = character(),
                                    sampling_method = character(),
                                    sampling_protocol = character(),
                                    measurement_unit = character(),
                                    value_transform = character(),
                                    sample_start_date = character(),
                                    sample_start_time = character(),
                                    sample_end_date =  character(),
                                    sample_end_time = character(),
                                    sample_value = numeric(),
                                    sample_sex = character(),
                                    sample_stage = character(),
                                    sample_location = character(),
                                    sample_collection_area = character(),
                                    sample_lat_dd = character(),
                                    sample_long_dd = character(),
                                    sample_environment = character(),
                                    additional_location_info = character(),
                                    additional_sample_info = character(),
                                    sample_name = character(),
                                    stringsAsFactors=FALSE)

title<-c(title_anas04,title_anas05,title_anas06, title_anas07,title_anas08, title_anas09, title_anas10, title_anas11,title_anas12,title_anas13, title_anas14,title_anas15,title_anas16, title_anas17)
taxon <- Anas_total$species
sample_value <- Anas_total$sample_count
sample_sex <- Anas_total$sex
sample_stage <-  Anas_total$developmental_stage 
sample_start_date <- Anas_total$collection_date_start
sample_end_date <- Anas_total$collection_date_end
sample_lat_dd <- Anas_total$GPS_lat
sample_long_dd <- Anas_total$GPS_lon
sample_location <- Anas_total$location
location_description <- Anas_total$location_description
sampling_method <- Anas_total$attractant
sampling_protocol <- Anas_total$trap_type
species_id_method <- Anas_total$identification_method
sample_name <-  Anas_total$trap_id

b <- cbind(title, taxon, sample_value, sample_sex, sample_stage, sample_start_date, sample_end_date, sample_lat_dd, sample_long_dd, sample_location, location_description, sampling_method, sampling_protocol, species_id_method, sample_name)
b <- data.frame(b, stringsAsFactors=FALSE)
vecdyn_Anastasia_total <- rbind.fill(vecdyn_Anastasia_total, b)

#orange county

orange_2015= read.csv('../data/zenodo/orange county/VectorBase-2015-Orange_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors = FALSE)
orange_2016= read.csv('../data/zenodo/orange county/VectorBase-2016-Orange_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors = FALSE)
orange_2017= read.csv('../data/zenodo/orange county/VectorBase-2017-Orange_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors = FALSE)


orange_total= rbind(orange_2015, orange_2016, orange_2017)
orange_total<-
  orange_total%>%
  tidyr::unite("location_description", c("location_ADM2","location_ADM1", "location_country"), sep = ",")
write.csv(orange_total, file = "orange_total", row.names = FALSE)

#title application
titleo15<-rep("Orange County Mosquito Control District entomological monitoring 2015", nrow(orange_2015))
titleo16<-rep("Orange County Mosquito Control District entomological monitoring 2016", nrow(orange_2016))
titleo17<-rep("Orange County Mosquito Control District entomological monitoring 2015", nrow(orange_2017))
titleo<-c(titleo15,titleo16,titleo17)

vecdyn_orange_total  <- data.frame(title = character(),
                                      taxon = character(),
                                      location_description = character(),
                                      study_collection_area = character(),
                                      geo_datum = character(),
                                      gps_obfuscation_info = character(),
                                      species_id_method = character(),
                                      study_design = character(),
                                      sampling_strategy = character(),
                                      sampling_method = character(),
                                      sampling_protocol = character(),
                                      measurement_unit = character(),
                                      value_transform = character(),
                                      sample_start_date = character(),
                                      sample_start_time = character(),
                                      sample_end_date =  character(),
                                      sample_end_time = character(),
                                      sample_value = numeric(),
                                      sample_sex = character(),
                                      sample_stage = character(),
                                      sample_location = character(),
                                      sample_collection_area = character(),
                                      sample_lat_dd = character(),
                                      sample_long_dd = character(),
                                      sample_environment = character(),
                                      additional_location_info = character(),
                                      additional_sample_info = character(),
                                      sample_name = character(),
                                      stringsAsFactors=FALSE)

title<-titleo
taxon <- orange_total$species
sample_value <- orange_total$sample_count
sample_sex <- orange_total$sex
sample_stage <-  orange_total$developmental_stage 
sample_start_date <- orange_total$collection_date_start
sample_end_date <- orange_total$collection_date_end
sample_lat_dd <- orange_total$GPS_lat
sample_long_dd <- orange_total$GPS_lon
sample_location <- orange_total$location
location_description <- orange_total$location_description
sampling_method <- orange_total$attractant
sampling_protocol <- orange_total$trap_type
species_id_method <- orange_total$identification_method
sample_name <-  orange_total$trap_id

c <- cbind(title, taxon, sample_value, sample_sex, sample_stage, sample_start_date, sample_end_date, sample_lat_dd, sample_long_dd, sample_location, location_description, sampling_method, sampling_protocol, species_id_method, sample_name)
c <- data.frame(c, stringsAsFactors=FALSE)
vecdyn_orange_total <- rbind.fill(vecdyn_orange_total, c)
View(vecdyn_orange_total)


#Hernando



hern_2014= read.csv('../data/zenodo/hernando/VectorBase-2014-Hernando_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors=FALSE)
hern_2015= read.csv('../data/zenodo/hernando/VectorBase-2015-Hernando_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors=FALSE)
hern_2016= read.csv('../data/zenodo/hernando/VectorBase-2016-Hernando_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors=FALSE)
hern_2017= read.csv('../data/zenodo/hernando/VectorBase-2017-Hernando_County_Mosquito_Control_Florida_USA.csv', stringsAsFactors=FALSE)

hern_total= rbind(hern_2014, hern_2015, hern_2016, hern_2017)

#title application

titleh14<-rep("Hernando County Mosquito Control District entomological monitoring 2014", nrow(hern_2014))
titleh15<-rep("Hernando County Mosquito Control District entomological monitoring 2015", nrow(hern_2015))
titleh16<-rep("Hernando County Mosquito Control District entomological monitoring 2016", nrow(hern_2016))
titleh17<-rep("Hernando County Mosquito Control District entomological monitoring 2017", nrow(hern_2017))
title<-c(titleh14,titleh15,titleh16,titleh17)

hern_total<-
  hern_total%>%
  tidyr::unite("location_description", c("location_ADM2","location_ADM1", "location_country"), sep = ",")

write.csv(hern_total, file = "hernando_total", row.names = FALSE)
vecdyn_hern_total  <- data.frame(title = character(),
                                   taxon = character(),
                                   location_description = character(),
                                   study_collection_area = character(),
                                   geo_datum = character(),
                                   gps_obfuscation_info = character(),
                                   species_id_method = character(),
                                   study_design = character(),
                                   sampling_strategy = character(),
                                   sampling_method = character(),
                                   sampling_protocol = character(),
                                   measurement_unit = character(),
                                   value_transform = character(),
                                   sample_start_date = character(),
                                   sample_start_time = character(),
                                   sample_end_date =  character(),
                                   sample_end_time = character(),
                                   sample_value = numeric(),
                                   sample_sex = character(),
                                   sample_stage = character(),
                                   sample_location = character(),
                                   sample_collection_area = character(),
                                   sample_lat_dd = character(),
                                   sample_long_dd = character(),
                                   sample_environment = character(),
                                   additional_location_info = character(),
                                   additional_sample_info = character(),
                                   sample_name = character(),
                                   stringsAsFactors=FALSE)

title<-c(titleh14,titleh15,titleh16,titleh17)
taxon <- hern_total$species
sample_value <- hern_total$sample_count
sample_sex <- hern_total$sex
sample_stage <-  hern_total$developmental_stage 
sample_start_date <- hern_total$collection_date_start
sample_end_date <- hern_total$collection_date_end
sample_lat_dd <- hern_total$GPS_lat
sample_long_dd <- hern_total$GPS_lon
sample_location <- hern_total$location
location_description <- hern_total$location_description
sampling_method <- hern_total$attractant
sampling_protocol <- hern_total$trap_type
species_id_method <- hern_total$identification_method
sample_name <-  hern_total$trap_id

d <- cbind(title, taxon, sample_value, sample_sex, sample_stage, sample_start_date, sample_end_date, sample_lat_dd, sample_long_dd, sample_location, location_description, sampling_method, sampling_protocol, species_id_method, sample_name)
d <- data.frame(d, stringsAsFactors=FALSE)
vecdyn_hern_total <- rbind.fill(vecdyn_hern_total, d)
View(vecdyn_hern_total)

#total concatenated data

complete<-rbind(vecdyn_Anastasia_total, vecdyn_manatee_total, vecdyn_hern_total, vecdyn_orange_total)
complete<-data.frame(complete, stringsAsFactors = FALSE)
vecdyn_complete<-data.frame(title = character(),
                            taxon = character(),
                            location_description = character(),
                            study_collection_area = character(),
                            geo_datum = character(),
                            gps_obfuscation_info = character(),
                            species_id_method = character(),
                            study_design = character(),
                            sampling_strategy = character(),
                            sampling_method = character(),
                            sampling_protocol = character(),
                            measurement_unit = character(),
                            value_transform = character(),
                            sample_start_date = character(),
                            sample_start_time = character(),
                            sample_end_date =  character(),
                            sample_end_time = character(),
                            sample_value = numeric(),
                            sample_sex = character(),
                            sample_stage = character(),
                            sample_location = character(),
                            sample_collection_area = character(),
                            sample_lat_dd = character(),
                            sample_long_dd = character(),
                            sample_environment = character(),
                            additional_location_info = character(),
                            additional_sample_info = character(),
                            sample_name = character(),
                            stringsAsFactors=FALSE)
vecdyn_complete <- rbind.fill(vecdyn_complete, complete)



View(vecdyn_complete)
write.csv(vecdyn_complete, file = "vecdyn_complete.csv", row.names = FALSE)


##################################################################################


#############PUBLICATION_TEMPLATE_MAPPING###########################################
title<- "Anastasia Mosquito Control District entomological monitoring 2004"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288481"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288481"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba4<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba4<- data.frame(puba4, stringsAsFactors = FALSE)
vecdyn_acm_2004_publication_info <- rbind.fill(vecdyn_acm_2004_publication_info , puba4)

vecdyn_acm_2004_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
write.csv(vecdyn_mcm_2012_publication_info, file = "vecdyn_mcm_2012_publication_info.csv", row.names = FALSE)


#Anas2005
vecdyn_acm_2005_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2005"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288496"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288496"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba5<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba5<- data.frame(puba5, stringsAsFactors = FALSE)
vecdyn_acm_2005_publication_info <- rbind.fill(vecdyn_acm_2005_publication_info , puba5)

#anas2006##

vecdyn_acm_2006_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2006"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288500"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288500"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba8<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba8<- data.frame(puba8, stringsAsFactors = FALSE)
vecdyn_acm_2006_publication_info <- rbind.fill(vecdyn_acm_2006_publication_info , puba8)

##anas2007

vecdyn_acm_2007_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2007"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288504"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288504"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba8<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba8<- data.frame(puba8, stringsAsFactors = FALSE)
vecdyn_acm_2007_publication_info <- rbind.fill(vecdyn_acm_2007_publication_info , puba8)


#anas 2008
vecdyn_acm_2008_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2008"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288512"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288512"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba8<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba8<- data.frame(puba8, stringsAsFactors = FALSE)
vecdyn_acm_2008_publication_info <- rbind.fill(vecdyn_acm_2008_publication_info , puba8)

#anas2009
vecdyn_acm_2009_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2009"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288572"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288572"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba9<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba9<- data.frame(puba9, stringsAsFactors = FALSE)
vecdyn_acm_2009_publication_info <- rbind.fill(vecdyn_acm_2009_publication_info , puba9)

#anas2010
vecdyn_acm_2010_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2010"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288576"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288576"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba10<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba10<- data.frame(puba10, stringsAsFactors = FALSE)
vecdyn_acm_2010_publication_info <- rbind.fill(vecdyn_acm_2010_publication_info , puba10)

##anas2011

vecdyn_acm_2011_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2011"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288578"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288578"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba11<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba11<- data.frame(puba11, stringsAsFactors = FALSE)
vecdyn_acm_2011_publication_info <- rbind.fill(vecdyn_acm_2011_publication_info , puba11)

#anas2012
vecdyn_acm_2012_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2012"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288580"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288580"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba12<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba12<- data.frame(puba12, stringsAsFactors = FALSE)
vecdyn_acm_2012_publication_info <- rbind.fill(vecdyn_acm_2012_publication_info , puba12)

#anas2013

vecdyn_acm_2013_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2013"
collection_author<- "Richard Weaver,Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1288583"
description<- "Mosquito surveillance from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288583"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba13<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba13<- data.frame(puba13, stringsAsFactors = FALSE)
vecdyn_acm_2013_publication_info <- rbind.fill(vecdyn_acm_2013_publication_info , puba13)

#anas2014

vecdyn_acm_2014_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2014"
collection_author<- "Richard Weaver, Daniel Lawson, Sam Rund"
dataset_doi<- "10.5281/zenodo.1288599"
description<- "Mosquito surveillance using BG-Sentinel traps from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288599"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba14<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba14<- data.frame(puba14, stringsAsFactors = FALSE)
vecdyn_acm_2014_publication_info <- rbind.fill(vecdyn_acm_2014_publication_info , puba14)

#anas 2015
vecdyn_acm_2015_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2015"
collection_author<- "Richard Weaver, Daniel Lawson, Sam Rund"
dataset_doi<- "10.5281/zenodo.1288602"
description<- "Mosquito surveillance using BG-Sentinel traps from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288602"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba15<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba15<- data.frame(puba15, stringsAsFactors = FALSE)
vecdyn_acm_2015_publication_info <- rbind.fill(vecdyn_acm_2015_publication_info , puba15)

##Anas2016
vecdyn_acm_2016_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2016"
collection_author<- "Richard Weaver, Daniel Lawson, Sam Rund"
dataset_doi<- "10.5281/zenodo.1288606"
description<- "Mosquito surveillance using BG-Sentinel traps from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288606"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba16<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba16<- data.frame(puba16, stringsAsFactors = FALSE)
vecdyn_acm_2016_publication_info <- rbind.fill(vecdyn_acm_2016_publication_info , puba16)

#anas2017

vecdyn_acm_2017_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)
title<- "Anastasia Mosquito Control District entomological monitoring 2017"
collection_author<- "Richard Weaver, Daniel Lawson, Sam Rund"
dataset_doi<- "10.5281/zenodo.1288608"
description<- "Mosquito surveillance using BG-Sentinel traps from the Anastasia Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1288608"
contact_name<-"Richard Weaver"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

puba17<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
puba17<- data.frame(puba17, stringsAsFactors = FALSE)
vecdyn_acm_2017_publication_info <- rbind.fill(vecdyn_acm_2017_publication_info , puba17)

##manatee 2012

vecdyn_mcm_2012_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Manatee County Mosquito Control District entomological monitoring 2012"
collection_author<- "Barbara Beyer, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1217702"
description<- "Mosquito surveillance from the Manatee County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1217702"
contact_name<-"Barbara Beyer"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubm12<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubm12<- data.frame(pubm12, stringsAsFactors = FALSE)
vecdyn_mcm_2012_publication_info <- rbind.fill(vecdyn_mcm_2012_publication_info, pubm12)

##manatee2013
vecdyn_mcm_2013_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Manatee County Mosquito Control District entomological monitoring 2013"
collection_author<- "Barbara Beyer, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1217704"
description<- "Mosquito surveillance from the Manatee County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1217704"
contact_name<-"Barbara Beyer"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubm13<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubm13<- data.frame(pubm13, stringsAsFactors = FALSE)
vecdyn_mcm_2013_publication_info <- rbind.fill(vecdyn_mcm_2013_publication_info, pubm13)

#manatee2014

vecdyn_mcm_2014_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Manatee County Mosquito Control District entomological monitoring 2014"
collection_author<- "Barbara Beyer, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1217706"
description<- "Mosquito surveillance from the Manatee County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1217706"
contact_name<-"Barbara Beyer"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubm14<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubm14<- data.frame(pubm14, stringsAsFactors = FALSE)
vecdyn_mcm_2014_publication_info <- rbind.fill(vecdyn_mcm_2014_publication_info, pubm14)

#manatee 2015
vecdyn_mcm_2015_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Manatee County Mosquito Control District entomological monitoring 2015"
collection_author<- "Barbara Beyer, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1217709"
description<- "Mosquito surveillance from the Manatee County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1217709"
contact_name<-"Barbara Beyer"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubm15<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubm15<- data.frame(pubm15, stringsAsFactors = FALSE)
vecdyn_mcm_2015_publication_info <- rbind.fill(vecdyn_mcm_2015_publication_info, pubm15)

#manatee 2016

vecdyn_mcm_2016_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Manatee County Mosquito Control District entomological monitoring 2016"
collection_author<- "Barbara Beyer, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1217711"
description<- "Mosquito surveillance from the Manatee County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1217711"
contact_name<-"Barbara Beyer"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubm16<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubm16<- data.frame(pubm16, stringsAsFactors = FALSE)
vecdyn_mcm_2016_publication_info <- rbind.fill(vecdyn_mcm_2016_publication_info, pubm16)

#hernando 2014

vecdyn_hcm_2014_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Hernando County Mosquito Control District entomological monitoring 2014"
collection_author<- "Sandra L. Fisher-Grainger, J Whitehurst, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220186"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220186"
contact_name<-"Sandra L. Fisher-Grainger"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubh14<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubh14<- data.frame(pubh14, stringsAsFactors = FALSE)
vecdyn_hcm_2014_publication_info <- rbind.fill(vecdyn_hcm_2014_publication_info, pubh14)

#hernando2015
vecdyn_hcm_2015_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Hernando County Mosquito Control District entomological monitoring 2015"
collection_author<- "Sandra L. Fisher-Grainger, J Whitehurst, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220194"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220194"
contact_name<-"Sandra L. Fisher-Grainger"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubh15<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubh15<- data.frame(pubh15, stringsAsFactors = FALSE)
vecdyn_hcm_2015_publication_info <- rbind.fill(vecdyn_hcm_2015_publication_info, pubh15)

#hern 2016

vecdyn_hcm_2016_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Hernando County Mosquito Control District entomological monitoring 2016"
collection_author<- "Sandra L. Fisher-Grainger, J Whitehurst, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220196"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220196"
contact_name<-"Sandra L. Fisher-Grainger"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubh16<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubh16<- data.frame(pubh16, stringsAsFactors = FALSE)
vecdyn_hcm_2016_publication_info <- rbind.fill(vecdyn_hcm_2016_publication_info, pubh16)

#hern 2017
vecdyn_hcm_2017_publication_info  <-data.frame(title=character(), 
                                               collection_author=character(),
                                               dataset_doi=character(),
                                               publication_doi = character(),
                                               description = character(),
                                               url = character(),
                                               contact_name=character(),
                                               contact_affiliation=character(),
                                               email=character(),
                                               orcid=character(),
                                               dataset_license=character(),
                                               data_rights=character(),
                                               embargo_release_date=character(),
                                               data_set_type=character(),
                                               stringsAsFactors=FALSE)

title<- "Hernando County Mosquito Control District entomological monitoring 2017"
collection_author<- "Sandra L. Fisher-Grainger, J Whitehurst, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220198"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220198"
contact_name<-"Sandra L. Fisher-Grainger"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubh17<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubh17<- data.frame(pubh17, stringsAsFactors = FALSE)
vecdyn_hcm_2017_publication_info <- rbind.fill(vecdyn_hcm_2017_publication_info, pubh17)

#orange county
vecdyn_ocm_2015_publication_info <-data.frame(title=character(), 
                                              collection_author=character(),
                                              dataset_doi=character(),
                                              publication_doi = character(),
                                              description = character(),
                                              url = character(),
                                              contact_name=character(),
                                              contact_affiliation=character(),
                                              email=character(),
                                              orcid=character(),
                                              dataset_license=character(),
                                              data_rights=character(),
                                              embargo_release_date=character(),
                                              data_set_type=character(),
                                              stringsAsFactors=FALSE)

title<- "Orange County Mosquito Control District entomological monitoring 2015"
collection_author<- "Dave Pelly, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220198"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220198"
contact_name<-"Dave Pelly"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubo15<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubo15<- data.frame(pubo15, stringsAsFactors = FALSE)
vecdyn_ocm_2015_publication_info <- rbind.fill(vecdyn_ocm_2015_publication_info, pubo15)

#hern 2016
vecdyn_ocm_2016_publication_info <-data.frame(title=character(), 
                                              collection_author=character(),
                                              dataset_doi=character(),
                                              publication_doi = character(),
                                              description = character(),
                                              url = character(),
                                              contact_name=character(),
                                              contact_affiliation=character(),
                                              email=character(),
                                              orcid=character(),
                                              dataset_license=character(),
                                              data_rights=character(),
                                              embargo_release_date=character(),
                                              data_set_type=character(),
                                              stringsAsFactors=FALSE)

title<- "Orange County Mosquito Control District entomological monitoring 2016"
collection_author<- "Dave Pelly, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220220"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220220"
contact_name<-"Dave Pelly"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubo16<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubo16<- data.frame(pubo16, stringsAsFactors = FALSE)
vecdyn_ocm_2016_publication_info <- rbind.fill(vecdyn_ocm_2016_publication_info, pubo16)

#hern 2017
vecdyn_ocm_2017_publication_info <-data.frame(title=character(), 
                                              collection_author=character(),
                                              dataset_doi=character(),
                                              publication_doi = character(),
                                              description = character(),
                                              url = character(),
                                              contact_name=character(),
                                              contact_affiliation=character(),
                                              email=character(),
                                              orcid=character(),
                                              dataset_license=character(),
                                              data_rights=character(),
                                              embargo_release_date=character(),
                                              data_set_type=character(),
                                              stringsAsFactors=FALSE)

title<- "Orange County Mosquito Control District entomological monitoring 2017"
collection_author<- "Dave Pelly, Daniel Lawson"
dataset_doi<- "10.5281/zenodo.1220222"
description<- "Mosquito surveillance from the Hernando County Mosquito Control District Vector Surveillance program to survey mosquito populations."
url<-"https://zenodo.org/record/1220222"
contact_name<-"Dave Pelly"
contact_affiliation<- ""
orchid<-""
data_rights<-"Open"

pubo17<- cbind(title, collection_author, dataset_doi, description, url, contact_name, contact_affiliation, orchid, data_rights)
pubo17<- data.frame(pubo17, stringsAsFactors = FALSE)
vecdyn_ocm_2017_publication_info <- rbind.fill(vecdyn_ocm_2017_publication_info, pubo17)

#



