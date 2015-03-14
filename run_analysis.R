## HUMAN ACTIVITY RECOGNITION

        ## Files were downoloaded and unzipped locally in order to preliminary examining them offline.
        ## Therefore following script may work only insofar those files are in the local Directory:
        ## "F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset" or in Directory of yours where such file have been 
        ## unzipped and saved 

## TEST DATA SECTION

        ## starting with reading "test/X_test.txt" directory into a variable xt and looking at it

rm(list=ls()) ## to cancel any variable left by preceding activity
xt<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/test/X_test.txt", header = F, sep = "", quote = "",
               na.strings = "NA")
dim(xt)
str(xt)

        ## (xt) results to be a data frame of 561 column containing num values; this result is consistant with the indications
        ## in the HAR in its README.txt file (561 types of measurements) 
        ## (xt) results having 2947 rows (those rows are identified by the "y" described - we suppose - in y_test.txt);
        ## let's analyze this last file:

yt<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/test/y_test.txt", header = F, sep = "", quote = "",
               na.strings = "NA")
dim(yt)
names(yt)<-"ACTIVITY"
str(yt)

        ## (yt) results to be a data.frame with 2947 obs. of  1 variable (nums from 1:6)
        ## from file "activity_labels.txt" we learn such nums represent activities as follows: 
        ## 1 WALKING
        ## 2 WALKING_UPSTAIRS
        ## 3 WALKING_DOWNSTAIRS
        ## 4 SITTING
        ## 5 STANDING
        ## 6 LAYING

        ## let's apply such "activity description num codes" as first column of our dataset (t) 
        ## we will later transform them into wording

library(dplyr)
xt1<- tbl_df(xt)  ## use the specifc dplyr format for data.frames
tb<- cbind (yt,xt1)
str(tb)
dim(tb) ## [1] 2947  562 this is consistant having added a column of activities as first column

        ## DATA FRAME DESCRIPTION (tb) 
        ## "tb" is a data.frame (test) which first column is "activity" and following 561 columns are meaurements (properly said
        ##  "features")

        ## About the individuals who volunteered the partecipation to test we know thy are a subset (30%) of the
        ## total n° 30 participants; lets read the identification list of such partecipants to test
        ## in file "test/subject_test.txt"

st<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/test/subject_test.txt", header = F, sep = "", quote = "",
                na.strings = "NA")
dim(st) 
names(st)<-"SUBJECT"

        ## [1] 2947    1 This is consistant with the vertical dimension of our tb 
        ## let's apply such "subject identification codes" as first column of our dataset (tb)

tbs<- cbind (st,tb)
dim (tbs)

## DATA FRAME DESCRIPTION (tbs) 

        ## "tbs" is a data.frame (test) which first column is the individual subject, the second column
        ##  the "activity" num codes and following 561 columns are "features"
        
## EXTRACTING RELEVANT FEATURES ("MEAN" "STD")

        ## the Assignement requestS to extract only measurements of the mean and std for "each" measurement.    
        ## by analizing the "features.txt", we find following fields contain the word "mean" or "std" 

        ## 1 tBodyAcc-mean()-X ,2 tBodyAcc-mean()-Y, 3 tBodyAcc-mean()-Z, 4 tBodyAcc-std()-X, 5 tBodyAcc-std()-Y, 6 tBodyAcc-std()-Z
        ## 41 tGravityAcc-mean()-X, 42 tGravityAcc-mean()-Y, 43 tGravityAcc-mean()-Z, 44 tGravityAcc-std()-X, 45 tGravityAcc-std()-Y, 46 tGravityAcc-std()-Z
        ## 81 tBodyAccJerk-mean()-X, 82 tBodyAccJerk-mean()-Y, 83 tBodyAccJerk-mean()-Z, 84 tBodyAccJerk-std()-X, 85 tBodyAccJerk-std()-Y, 86 tBodyAccJerk-std()-Z
        ## 121 tBodyGyro-mean()-X, 122 tBodyGyro-mean()-Y. 123 tBodyGyro-mean()-Z, 124 tBodyGyro-std()-X, 125 tBodyGyro-std()-Y, 126 tBodyGyro-std()-Z
        ## 161 tBodyGyroJerk-mean()-X, 162 tBodyGyroJerk-mean()-Y, 163 tBodyGyroJerk-mean()-Z, 164 tBodyGyroJerk-std()-X, 165 tBodyGyroJerk-std()-Y, 166 tBodyGyroJerk-std()-Z
        ## 201 tBodyAccMag-mean(), 202 tBodyAccMag-std()
        ## 214 tGravityAccMag-mean(), 215 tGravityAccMag-std()
        ## 227 tBodyAccJerkMag-mean(), 228 tBodyAccJerkMag-std()
        ## 266 fBodyAcc-mean()-X,267 fBodyAcc-mean()-Y,268 fBodyAcc-mean()-Z,269 fBodyAcc-std()-X,270 fBodyAcc-std()-Y,271 fBodyAcc-std()-Z
        ## 345 fBodyAccJerk-mean()-X, 346 fBodyAccJerk-mean()-Y, 347 fBodyAccJerk-mean()-Z, 348 fBodyAccJerk-std()-X, 349 fBodyAccJerk-std()-Y, 350 fBodyAccJerk-std()-Z
        ## 424 fBodyGyro-mean()-X, 425 fBodyGyro-mean()-Y, 426 fBodyGyro-mean()-Z, 427 fBodyGyro-std()-X, 428 fBodyGyro-std()-Y, 429 fBodyGyro-std()-Z
        ## 503 fBodyAccMag-mean(), 504 fBodyAccMag-std()
        ## 516 fBodyBodyAccJerkMag-mean(), 517 fBodyBodyAccJerkMag-std()
        ## 529 fBodyBodyGyroMag-mean(), 530 fBodyBodyGyroMag-std()
        ## 542 fBodyBodyGyroJerkMag-mean(), 543 fBodyBodyGyroJerkMag-std()

        ## therefore following columns should be selected (1:6),(41:46),(81:86), (121:126), (161:166), (201:202), (214:215), (227:228), (266:271), 
        ## (345:350), (424:429), (503:504), (516:517), (529:530), (542:543)

        ## let's read the features file and extract to a variable "self" only (and all) rows which contain the word "mean" or "std"

f<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/features.txt", header = F, sep = "", quote = "",
                na.strings = "NA")
self<- f[c((1:6),(41:46),(81:86), (121:126), (161:166), (201:202), (214:215), (227:228), (266:271), 
                (345:350), (424:429), (503:504), (516:517), (529:530), (542:543)),]
       
## EXTRACTING "mean" and "std" ALL AND ONLY COLUMNS OUT OF THE DATA.FRAME (tbs)
## DATA FRAME DESCRIPTION (tbs) 

        ## "tbs" is a data.frame (test) which first column is the individual "SUBJECT", the second column
        ##  the "ACTIVITY" num codes and following 561 columns are "features"

seltbs<- tbs[, c((1:8),(43:48),(83:88), (123:128), (163:168), (203:204), (216:217), (229:230), (268:273), 
                 (347:352), (426:431), (505:506), (518:519), (531:532), (544:545)),]

head(seltbs) ## checks OK
tail(seltbs) ## do
self$V2<- as.character(self$V2)
names(seltbs)<-as.vector(c("SUBJECT", "ACTIVITY", self$V2))

## DATA FRAME DESCRIPTION (seltbs) (i.e. selected tbs)

        ## "seltbs" is a data.frame (test) which first column is the individual "SUBJECT", the second column
        ##  the "ACTIVITY" num codes and following columns are related to "mean" or "std"
        ## let's apply such description num codes" as first column of our dataset

seltbs$ACTIVITY<- as.character(seltbs$ACTIVITY)
        for (k in 1:2947) 
        if (seltbs$ACTIVITY [k] == "5") {seltbs$ACTIVITY[k] <- "STANDING"}
        for (k in 1:2947) 
        if (seltbs$ACTIVITY [k] == "4") {seltbs$ACTIVITY[k] <- "SITTING"}
        for (k in 1:2947) 
        if (seltbs$ACTIVITY [k] == "3") {seltbs$ACTIVITY[k] <- "W_DOWN"}
        for (k in 1:2947) 
        if (seltbs$ACTIVITY [k] == "2") {seltbs$ACTIVITY[k] <- "W_UP"}
        for (k in 1:2947) 
        if (seltbs$ACTIVITY [k] == "6") {seltbs$ACTIVITY[k] <- "LAYING"}
        for (k in 1:2947) 
        if (seltbs$ACTIVITY [k] == "1") {seltbs$ACTIVITY[k] <- "WALKING"}

###-----------------------------------------------------------------------------------------------------------------------

### TRAIN DATA SECTION (same as TEST DATA SECTION, som many comments omitted)

### starting with reading "train/X_train.txt" directory into a variable t2 and looking at it

xt2<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/train/X_train.txt", header = F, sep = "", quote = "",
                na.strings = "NA")
dim(xt2)
str(xt2)

### (xt) results to be a data frame of 561 column and 7352 rows containing num values; this result is consistant with the indications
### in the HAR in its README.txt file (561 types of measurements) 
### (xt) results having 7352 rows (those rows are identified by the "y" described - we suppose - in y_train.txt);
### let's analyze this last file:

yt2<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/train/y_train.txt", header = F, sep = "", quote = "",
                na.strings = "NA")
dim(yt2)
names(yt2)<-"ACTIVITY"
str(yt2)

### (yt2) results to be a data.frame with 7352 obs. of  1 variable (nums from 1:6)
### from file "activity_labels.txt" we learn such nums represent activities 
### let's apply such "activity description num codes" as first column of our dataset (t) 
### we will later transform them into wording

xt2<- tbl_df(xt2)  ## use the specifc dplyr format for data.frames
tb2<- cbind (yt2,xt2)
str(tb2)
dim(tb2) ## [1] 7352  562 this is consistant having added a column of activities as first column

### DATA FRAME DESCRIPTION (tb2) 
### "tb2" is a data.frame (train) which first column is "activity" and following 561 columns are meaurements (properly said
###  "features")

### About the individuals who volunteered the partecipation to "train" we know thy are a subset (70%) of the
### total n° 30 participants; lets read the identification list of such partecipants to test
### in file "train/subject_train.txt"

st2<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/train/subject_train.txt", header = F, sep = "", quote = "",
                na.strings = "NA")
dim(st2) 
names(st2)<-"SUBJECT"
### [1] 7352    1 This is consistant with the vertical dimension of our tb2 
### let's apply such "subject identification codes" as first column of our dataset (tb)
tbs2<- cbind (st2,tb2)
dim (tbs2)

### DATA FRAME DESCRIPTION (tbs2)

### "tbs2" is a data.frame (train) which first column is the individual subject, the second column
###  the "activity" num codes and following 561 columns are "features"

###  EXTRACTING "mean" and "std" ALL AND ONLY COLUMNS OUT OF THE DATA.FRAME (tbs2)

head(tbs2)        
tail(tbs2)
seltbs2<- tbs2[, c((1:8),(43:48),(83:88), (123:128), (163:168), (203:204), (216:217), (229:230), (268:273), 
                 (347:352), (426:431), (505:506), (518:519), (531:532), (544:545)),]

head(seltbs2) ## checks OK
tail(seltbs2) ## do
self$V2<- as.character(self$V2)
names(seltbs2)<-as.vector(c("SUBJECT", "ACTIVITY", self$V2))

### DATA FRAME DESCRIPTION (seltbs2) (i.e. selected tbs2)
### "seltbs2" is a data.frame (train) which first column is the individual "SUBJECT", the second column
### the "ACTIVITY" num codes and following columns are related to "mean" or "std"
### let's now apply ACTIVITY descriptions instead of num codes as first column of our dataset

seltbs2$ACTIVITY<- as.character(seltbs2$ACTIVITY)
for (k in 1:7352) 
        if (seltbs2$ACTIVITY [k] == "5") {seltbs2$ACTIVITY[k] <- "STANDING"}
for (k in 1:7352) 
        if (seltbs2$ACTIVITY [k] == "4") {seltbs2$ACTIVITY[k] <- "SITTING"}
for (k in 1:7352) 
        if (seltbs2$ACTIVITY [k] == "3") {seltbs2$ACTIVITY[k] <- "W_DOWN"}
for (k in 1:7352) 
        if (seltbs2$ACTIVITY [k] == "2") {seltbs2$ACTIVITY[k] <- "W_UP"}
for (k in 1:7352) 
        if (seltbs2$ACTIVITY [k] == "6") {seltbs2$ACTIVITY[k] <- "LAYING"}
for (k in 1:7352) 
        if (seltbs2$ACTIVITY [k] == "1") {seltbs2$ACTIVITY[k] <- "WALKING"}

### OBTAIN THE MERGED DATA SET BY BINDIG TEST AND TRAIN DATASETS
### THE DATA FRAME (mergedd) CONTAINS ALL AND ONLY FEATURES WHICH NAME INCLUDED MEAN OR STD
### FIRST TWO COLUMNS ARE SUBJECT (THE N° OF THE INDIVIDUAL WHO VOLUNTEERR THE RESEARCH) AND ACTIVITY NAME)

mergedd <- rbind(seltbs2,seltbs)

### ARRANGE (mergedd) by SUBJECT and by ACTIVITY in asc. order
sortedmergedd<- arrange(mergedd, SUBJECT, ACTIVITY)

#### ------------------------------------------------------------------------------------------------------------------
#### PREPARING THE FINAL "INDEPENDENT (TIDY) DATA SET" WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT 

#### As this final set is "independent" and (sortmergedd) contains 64 different features, I decided to utilize
#### for the final set just first feature I arbitrarly consider to be basic features, in order to make such final set
#### of data readable and manageable; of course if wanted by the Client the process can be iterated to all the 64 features

#### selected were: tBodyAcc-mean()-X,tBodyAcc-mean()-Y,tBodyAcc-mean()-Z
####                tBodyAcc-std()-X,tBodyAcc-std()-Y,tBodyAcc-std()-Z
####                tGravityAcc-mean()-X,tGravityAcc-mean()-Y,tGravityAcc-mean()-Z
####                tGravityAcc-std()-X,tGravityAcc-std()-Y,tGravityAcc-std()-Z

#### let's start dropping in (sortedmergedd) the features I considered not necessary creating a new (final) data frame.

final<- sortedmergedd [, (1:14)]
        
#### CHANGING NAMES TO MORE COMPACT FORMAT: 
####                BAccmX,BAccmY,BAccmZ
####                BAccsX,BAccsY,BAccsZ
####                GAccmX,GAccmY,GAccmZ
####                GAccsX,GAccsY,GAccsZ

cnames<- c("SUBJECT", "ACTIVITY","BAccmX","BAccmY","BAccmZ",
           "BAccsX","BAccsY","BAccsZ",
           "GAccmX","GAccmY","GAccmZ",
           "GAccsX","GAccsY","GAccsZ" )
colnames(final)<-cnames

#### GROUP DATA BY SUBJECT, ACTIVITY and CALCULATE MEAN OF EACH FEATURE COLUMN
#### OBTAIN A FINAL DATA SET FOR THE ASSIGNMENT COMPLETION (Tfinal)
#### SAVE (Tfinal) as .txt file

tidyfinal<-group_by(final, SUBJECT, ACTIVITY)

Tfinal<-summarize(tidyfinal, BAccmX=mean(BAccmX),
          BAccmY=mean(BAccmY),
          BAccmZ=mean(BAccmZ) ,
          BAccsX=mean(BAccsX)  ,
          BAccsY=mean(BAccsY)   ,
          BAccsZ=mean(BAccsZ)    ,
          GAccmX=mean(GAccmX)     ,
          GAccmY=mean(GAccmY)      ,
          GAccmZ=mean(GAccmZ)       ,
          GAccsX=mean(GAccsX)        ,
          GAccsY=mean(GAccsY)         ,
          GAccsZ=mean(GAccsZ))
                  
View(Tfinal)
write.table(Tfinal, row.name=F, file="F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/Tfinal.txt")


