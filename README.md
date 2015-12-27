# Getting And Cleaning Data - Course Project

## Introduction

The main asset of this repo is the script `run_analysis.R`. 

This script reads UCI HAR data files and writes output to `result.txt`

The `CodeBook.md` has some details.


## Run from command line

1. Clone this repo.
2. Download `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip` and extract files in the repo root folder.
3. Run the script:

       $ Rscript run_analysis.R

4. Look for the final dataset at result.txt

	   $ head -3 data/output/uci_har_mean_std_averages.csv
	   
