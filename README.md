### run_analysis
Coursera Getting and Cleaning Data Course Project
###**HUMAN ACTIVITY RECOGNITION**

####**EXPLANATION HOW SCRIPT WORKS:**

Files were downloaded and unzipped locally in order to preliminary examining them offline.
Therefore script may work only insofar those files are in the local Directory:
"F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset" or in Directory of yours where such file have been 
unzipped and saved 

####TEST DATA SECTION

Script starts with reading "test/X_test.txt" directory into a variable xt and looking at it

	(xt) results to be a data frame of 561 column containing num values; this number is consistant with the indications
	in the HAR in its README.txt file (561 types of measurements); (xt) results having 2947 rows (those rows are identified
	by the "y" described - we suppose - in y_test.txt);
         
Script goes on by analyzing this "y" file:

	yt<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/test/y_test.txt", header = F, sep = "", quote = "",
               na.strings = "NA")

	(yt) results to be a data.frame with 2947 obs. of  1 variable (nums from 1:6)
        from file "activity_labels.txt" we learn such nums represent activities as follows: 
        
		1. WALKING
		2. WALKING_UPSTAIRS
		3. WALKING_DOWNSTAIRS
		4. SITTING
		5. STANDING
		6. LAYING

Script continues by applying such "activity description num codes" as first column of a dataset named (t) 
	we will later transform them into wording

Then Script opens "dplyr"

	library(dplyr)
	xt1<- tbl_df(xt)  (it uses the specifc dplyr format for data.frames
	tb<- cbind (yt,xt1)
	str(tb)
	dim(tb) [1] 2947  (562 this is consistant having added a column of activities as first column)

####**DATA FRAME DESCRIPTION (tb)** 

	"tb" is a data.frame (test) which first column is "activity" and following 561 columns are meaurements (properly said
	"features"). About the individuals who volunteered the partecipation to test we know they are a subset (30%) of the
	total n° 30 participants.

Script now reads the identification list of such partecipants to test in file "test/subject_test.txt"

	st<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/test/subject_test.txt", header = F, sep = "", quote = "",
			na.strings = "NA")
	dim(st) [1] 2947    1 This is consistant with the vertical dimension of our tb 
	names(st)<-"SUBJECT"

Script now applys such "subject identification codes" as first column of our dataset (tb) obtaining (tbs)

####**DATA FRAME DESCRIPTION (tbs)** 

        "tbs" is a data.frame (test) which first column is the individual subject, the second column
        the "activity" num codes and following 561 columns are "features"
        
####**EXTRACTING RELEVANT FEATURES ("MEAN" "STD")**

        Assignement requestS to extract only measurements of the mean and std for **each** measurement.     
        By analizing the "features.txt". Utilizing a simple txt editor we find following fields contain the word "mean" or "std" 

        -   1 tBodyAcc-mean()-X ,2 tBodyAcc-mean()-Y, 3 tBodyAcc-mean()-Z, 4 tBodyAcc-std()-X, 5 tBodyAcc-std()-Y, 6 tBodyAcc-std()-Z
        -  41 tGravityAcc-mean()-X, 42 tGravityAcc-mean()-Y, 43 tGravityAcc-mean()-Z, 44 tGravityAcc-std()-X, 45 tGravityAcc-std()-Y, 46 tGravityAcc-std()-Z
        -  81 tBodyAccJerk-mean()-X, 82 tBodyAccJerk-mean()-Y, 83 tBodyAccJerk-mean()-Z, 84 tBodyAccJerk-std()-X, 85 tBodyAccJerk-std()-Y, 86 tBodyAccJerk-std()-Z
        - 121 tBodyGyro-mean()-X, 122 tBodyGyro-mean()-Y. 123 tBodyGyro-mean()-Z, 124 tBodyGyro-std()-X, 125 tBodyGyro-std()-Y, 126 tBodyGyro-std()-Z
        - 161 tBodyGyroJerk-mean()-X, 162 tBodyGyroJerk-mean()-Y, 163 tBodyGyroJerk-mean()-Z, 164 tBodyGyroJerk-std()-X, 165 tBodyGyroJerk-std()-Y, 166 tBodyGyroJerk-std()-Z
        - 201 tBodyAccMag-mean(), 202 tBodyAccMag-std()
        - 214 tGravityAccMag-mean(), 215 tGravityAccMag-std()
        - 227 tBodyAccJerkMag-mean(), 228 tBodyAccJerkMag-std()
        - 266 fBodyAcc-mean()-X,267 fBodyAcc-mean()-Y,268 fBodyAcc-mean()-Z,269 fBodyAcc-std()-X,270 fBodyAcc-std()-Y,271 fBodyAcc-std()-Z
        - 345 fBodyAccJerk-mean()-X, 346 fBodyAccJerk-mean()-Y, 347 fBodyAccJerk-mean()-Z, 348 fBodyAccJerk-std()-X, 349 fBodyAccJerk-std()-Y, 350 fBodyAccJerk-std()-Z
        - 424 fBodyGyro-mean()-X, 425 fBodyGyro-mean()-Y, 426 fBodyGyro-mean()-Z, 427 fBodyGyro-std()-X, 428 fBodyGyro-std()-Y, 429 fBodyGyro-std()-Z
        - 503 fBodyAccMag-mean(), 504 fBodyAccMag-std()
        - 516 fBodyBodyAccJerkMag-mean(), 517 fBodyBodyAccJerkMag-std()
        - 529 fBodyBodyGyroMag-mean(), 530 fBodyBodyGyroMag-std()
        - 542 fBodyBodyGyroJerkMag-mean(), 543 fBodyBodyGyroJerkMag-std()

        therefore following columns should be selected (1:6),(41:46),(81:86), (121:126), (161:166), (201:202), (214:215), (227:228), (266:271), 
        (345:350), (424:429), (503:504), (516:517), (529:530), (542:543)

Script will read the features file and extract to a variable "self" only (and all) rows which contain the word "mean" or "std"

####**ABOUT NAMES OF THE VARIABLES:**

        Assignment ask to " Appropriately label the Data set with descriptive variable names" and in other chapter, 
        to prepare...tidy data to be used in later analisys. I decided to leave them as they are for the moment and use
        more sintetic and handy names after merge and before sorting them for the tidy set 
        Activity mum. codes will be later translated into wording (as specifically required by Assignment instructions) 

	f<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/features.txt", header = F, sep = "", quote = "",
			na.strings = "NA")
	self<- f[c((1:6),(41:46),(81:86), (121:126), (161:166), (201:202), (214:215), (227:228), (266:271), 
			(345:350), (424:429), (503:504), (516:517), (529:530), (542:543)),]
       
####**EXTRACTING "mean" and "std" ALL AND ONLY COLUMNS OUT OF THE DATA.FRAME (tbs)**

####**DATA FRAME DESCRIPTION (tbs)** 

        "tbs" is a data.frame (test) which first column is the individual "SUBJECT", the second column
        the "ACTIVITY" num codes and following 561 columns are "features"


Script now selects the relevant "features" (such contaning the word "mean" or "std"

	seltbs<- tbs[, c((1:8),(43:48),(83:88), (123:128), (163:168), (203:204), (216:217), (229:230), (268:273), 
                 (347:352), (426:431), (505:506), (518:519), (531:532), (544:545)),]
	self$V2<- as.character(self$V2)
	names(seltbs)<-as.vector(c("SUBJECT", "ACTIVITY", self$V2))

####**DATA FRAME DESCRIPTION (seltbs) (i.e. selected tbs)**

        "seltbs" is a data.frame (test) which first column is the individual "SUBJECT", the second column
        the "ACTIVITY" num codes and following columns are related to "mean" or "std"
        
        
Script will now apply descriptions:

seltbs$ACTIVITY<- as.character(seltbs$ACTIVITY)
    for (k in 1:2947); if (seltbs$ACTIVITY [k] == "5") {seltbs$ACTIVITY[k] <- "STANDING"}
    for (k in 1:2947); if (seltbs$ACTIVITY [k] == "4") {seltbs$ACTIVITY[k] <- "SITTING"}......
    
-----------------------------------------------------------------------------------------------------------------------


###**TRAIN DATA SECTION**
#####(same as TEST DATA SECTION, so many comments omitted)

Script is starting with reading "train/X_train.txt" directory into a variable t2 and looking at it

	xt2<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/train/X_train.txt", header = F, sep = "", quote = "",
                na.strings = "NA")

	(xt) results to be a data frame of 561 column and 7352 rows containing num values; this result is consistant with the indications
	in the HAR in its README.txt file (561 types of measurements) 
	(xt) results having 7352 rows (those rows are identified by the "y" described - we suppose - in y_train.txt);

Script analyzes "y" file:

	yt2<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/train/y_train.txt", header = F, sep = "", quote = "",
                na.strings = "NA")
	names(yt2)<-"ACTIVITY"

	(yt2) results to be a data.frame with 7352 obs. of  1 variable (nums from 1:6)
	from file "activity_labels.txt" we learn such nums represent activities 
	
Script applies such "activity description num codes" as first column of our dataset (t) we will later transform them into wording

Script now uses the specifc dplyr format for data.frames

	xt2<- tbl_df(xt2)  
	tb2<- cbind (yt2,xt2)
	dim(tb2)  [1] 7352  (562 this is consistant having added a column of activities as first column)

####**DATA FRAME DESCRIPTION (tb2)** 
	"tb2" is a data.frame (train) which first column is "activity" and following 561 columns are meaurements (properly said
	"features")

	About the individuals who volunteered the partecipation to "train" we know thy are a subset (70%) of the
	total n° 30 participants ; 
	
Script reads the identification list of such partecipants to test in file "train/subject_train.txt"

	st2<- read.table("F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/train/subject_train.txt", header = F, sep = "", quote = "",
			na.strings = "NA")
	dim(st2) [1] 7352    1 This is consistant with the vertical dimension of our tb2 
	names(st2)<-"SUBJECT"
	
Script applies such "subject identification codes" as first column of our dataset (tb)
	tbs2<- cbind (st2,tb2)
	dim (tbs2)

####**DATA FRAME DESCRIPTION (tbs2)**

	"tbs2" is a data.frame (train) which first column is the individual subject, the second column
	the "activity" num codes and following 561 columns are "features"

####**EXTRACTING "mean" and "std" ALL AND ONLY COLUMNS OUT OF THE DATA.FRAME (tbs2)**

	seltbs2<- tbs2[, c((1:8),(43:48),(83:88), (123:128), (163:168), (203:204), (216:217), (229:230), (268:273), 
			 (347:352), (426:431), (505:506), (518:519), (531:532), (544:545)),]
	self$V2<- as.character(self$V2)
	names(seltbs2)<-as.vector(c("SUBJECT", "ACTIVITY", self$V2))

####**DATA FRAME DESCRIPTION (seltbs2) (i.e. selected tbs2)**

	"seltbs2" is a data.frame (train) which first column is the individual "SUBJECT", the second column
	the "ACTIVITY" num codes and following columns are related to "mean" or "std"
	
Script now applies ACTIVITY descriptions instead of num codes as first column of our dataset

---------------------------------------------------------------------------------------------------------------------

###**OBTAIN THE MERGED DATA SET by binding TEST and TRAIN Datasets**

##### THE DATA FRAME (mergedd) CONTAINS ALL AND ONLY FEATURES WHICH NAME INCLUDED MEAN OR STD
##### FIRST TWO COLUMNS ARE SUBJECT (THE N° OF THE INDIVIDUAL WHO VOLUNTEERR THE RESEARCH) AND ACTIVITY NAME)

	mergedd <- rbind(seltbs2,seltbs)

Script now ARRANGE (mergedd) by SUBJECT and by ACTIVITY in asc. order

	sortedmergedd<- arrange(mergedd, SUBJECT, ACTIVITY)
	
----------------------------------------------------------------------------------------------------------------------

###**PREPARING THE FINAL "INDEPENDENT (TIDY) DATA SET"** 
#### WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT 

As this final set is "independent" and (sortmergedd) contains still all the 64 different mean - std features, **I decided to utilize for the final set just those features I consider to be basic features (the only which seem having supplied directly by the accelerometer)**. This also in order to make such final set of data more readable and manageable; of course, if wanted, the very same process can be iterated to all the 64 features.

	selected were therefore: tBodyAcc-mean()-X,tBodyAcc-mean()-Y,tBodyAcc-mean()-Z
					 tBodyAcc-std()-X,tBodyAcc-std()-Y,tBodyAcc-std()-Z
					 tGravityAcc-mean()-X,tGravityAcc-mean()-Y,tGravityAcc-mean()-Z
					 tGravityAcc-std()-X,tGravityAcc-std()-Y,tGravityAcc-std()-Z

Script goes on by dropping in (sortedmergedd) the features I considered not necessary, creating a new (final) data frame.

	final<- sortedmergedd [, (1:14)]
        
Script proceeds by CHANGING NAMES TO MORE COMPACT (but still meaningful) FORMAT: 

             BAccmX,BAccmY,BAccmZ
             BAccsX,BAccsY,BAccsZ
             GAccmX,GAccmY,GAccmZ
             GAccsX,GAccsY,GAccsZ

		cnames<- c("SUBJECT", "ACTIVITY","BAccmX","BAccmY","BAccmZ",
			   "BAccsX","BAccsY","BAccsZ",
			   "GAccmX","GAccmY","GAccmZ",
			   "GAccsX","GAccsY","GAccsZ" )
		colnames(final)<-cnames
		
Script proceeds as follows:
GROUP DATA BY SUBJECT, ACTIVITY and CALCULATE MEAN OF EACH FEATURE COLUMN
OBTAIN A FINAL DATA SET FOR THE ASSIGNMENT COMPLETION (Tfinal)
SAVE (Tfinal) as .txt file

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

	write.table(Tfinal, row.name=F, file="F:/JHU/2_GETTING AND CLEANING DATA/UCI HAR Dataset/Tfinal.txt")
	
--------------------------------------------------------------------------------------------------------------
	
###**FINAL NOTE**

I CONSIDER THIS DATA SET TIDY as:

1.	EACH VARIABLE FORMS A COLUMN
2.	EACH OBSERVATION FORMS A ROW BY SUBJECT (IN NUM. ORDER)
3.	SAME OBSERVATION TYPES (ACTIVITIES) ARE GROUPED by SUBJECT  

OF COURSE OTHER TYPE OF ARRANGEMENT ARE POSSIBLE

===============================================================================================================
EoF/by mario :)
