
library(readxl)
library(plumber)
library(dplyr)
library(readr)
library(tidyverse)
library(stringr)
require(data.table)
library(reticulate)
library(aws.s3)

obj <-get_object("s3://medicaid-devops/UPDATED.csv")  
csvcharobj <- rawToChar(obj)  
con <- textConnection(csvcharobj)  
exclusion_list <- read.csv(file = con)


VARIABLES <- list(
  bus_name = "Name of Business",
  bus_address = "Address of Business")

#* @apiTitle NPI API Exclusion List 

#* Return query of exclusion list
#* @param bus_name Business Name
#* @param bus_address Business Address
#* @get /query
function(bus_name, bus_address) {
    
    hits <- filter(exclusion_list, BUSNAME == bus_name | ADDRESS == bus_address)
    
    return(hits)

}



#* Return query of any business names on exclusion list
#* @param bus_name Business Name
#* @get /BusinessName
function(bus_name) {
  
  hits <- filter(exclusion_list, BUSNAME == bus_name)
  
  return(hits)
  
}


#* Return query of any business addresses on exclusion list
#* @param bus_address Business Address
#* @get /BusinessAddress
function(bus_address) {
  
  hits <- filter(exclusion_list, ADDRESS == bus_address)
  
  return(hits)
  
}
