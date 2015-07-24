#Project Codebook

This codebook is here to explain the basics of the data to the user. The data is all normalized between [-1,1] meaning units are not important.

##Variables
subject - one of 30 people observed in the study. (1-30)
activity - subject's means of activity that is monitored. (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING)

NOTE: The next 79 variables are not listed (for obvious reasons) but they are all different observations of recorded means and standard deviations in the X,Y, and Z axes.

##Final Notes

This data is a wide version of a much larger data set, in which each subject has multiple observations for each activity. The script will collapse all of those observations by averaging out multiple observations of the same activity.
