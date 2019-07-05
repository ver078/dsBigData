#! /bin/bash


# delete the existing output directory with all its files

#rm -R /OSM/CBR/AF_DATASCHOOL/output/ver078 


# load the fastqc module so we can run it.

module load fastqc



# run the fastqc command line with empty output directory specified as ouput directory

fastqc $1 -o $2

