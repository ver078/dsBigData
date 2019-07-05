#!/bin/bash -l
#SBATCH --job-name=shaunjob
#SBATCH --ntasks=64
#SBATCH --mem=1gb
#SBATCH --time=0:2:00

##SBATCH --mail-type=ALL
##SBATCH --mail-user=shaun.verrall@csiro.au


# delete the existing output directory with all its files
#rm -R /OSM/CBR/AF_DATASCHOOL/output/ver078 



# load the fastqc module so we can run it.
#module load fastqc


inputdir=/OSM/CBR/AF_DATASCHOOL/input/2019-04-12_Transcritome
outputdir=/OSM/CBR/AF_DATASCHOOL/output/ver078



for filename in $inputdir/*.fastq.gz
do
   echo $filename
   #fastqc $filename -o $outputdir
   sbatch ./singlefile.sh $filename $outputdir
done


