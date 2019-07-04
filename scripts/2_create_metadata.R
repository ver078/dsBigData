library("tidyverse")
# create path
dpath <- '/OSM/CBR/AF_DATASCHOOL/input/2019-04-12_Transcritome/'

# -------------- List files (fastq) in the folder
flist <- list.files(dpath,pattern = '*.gz$')
flist2 <- data.frame(stringr::str_split_fixed(flist,'[_\\.]',13)) #separate a string by '-'
flist3 <- flist2 %>% 
  select(-X1,-X2,-X5,-X6,-X13) %>%  # remove useless columns
  unite(Sample,X3,X4,sep = '_',remove=TRUE) %>%  # samplename
  unite(Manifestname,X7:X11,sep = '_',remove=TRUE)  # Manifestname
colnames(flist3) <- c('Sample','Manifestname','Repetition')
flist4 <- cbind(data.frame(flist),flist3)
# treatment information from sample.txt file
treaminfo <- read_csv(dir(dpath,pattern = '*.txt$',full.names = TRUE))

# sample informaion from R_161128_SHADIL_LIB2500_M002.csv file
sampleinfo <-  read_csv(dir(dpath,pattern = '*.csv$',full.names = TRUE),skip = 14)
sampleinfo <- sampleinfo %>% 
  extract(Index,c('Index-1','Index-2'),'(\\w+\\-\\w\\s\\w+\\-\\w+)\\s\\((\\w+\\-\\w+)') %>% 
  extract(`External ID`,c('Treatment','Treatment-samplename'),'([A-Z])(\\d+)')


md <- left_join(flist4,sampleinfo,by=c('Sample'='Sample/Name'))
md <- md[c(1,2,4,6,7,9,10)]

# Wrtie txt file with 'tab' 
outpath <- 'OSM/CBR/AF_DATASCHOOL/output/ver078'
write_csv(md,outpath+'/metadata.csv')
write.table(md,outpath+'/metadata.txt',sep = '\t')

#write_csv(md,'/home/yu055/dsBigData/2_Metadata/metadata.csv')
#write.table(md,'/home/yu055/dsBigData/2_Metadata/metadata.txt',sep = '\t')

