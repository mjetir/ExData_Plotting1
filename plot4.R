#Set the working directory so that RStudio will read from the proper directory.
workingDirectory<-"~/coursera/ExploratoryDataAnalysis/CourseProject1"
setwd(workingDirectory)

#Set the locale to POSIX so that the x tick labels in figures will be written in English. 
Sys.setlocale("LC_TIME", "POSIX") 

#Read the data.
dataName<-"./data/household_power_consumption.txt"
data<-read.table(dataName,sep=";",header=TRUE
                 ,colClasses=c("character","character","numeric","numeric","numeric",
                               "numeric","numeric","numeric","numeric"),
                 na.strings=c("?"))
#Select the rows in which the Date variable has the given values.
subData<-data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"),]

##If the above takes too much time, the data can be loaded into R by using MySQL:
#library("RMySQL")
#myPassword<-"myPassword"
#dbName<-"myDatabaseName"
#hostName<-"localhost"
#db<-dbConnect(MySQL(),db=dbName,host=hostName,password=myPassword)
##Read the rows in which the field Date equals to given dates from a table called householdPowerConsumption. 
#subData<-dbGetQuery(db,"select * from householdPowerConsumption where (Date='1/2/2007' or Date='2/2/2007')")

png("plot4.png",width=480,height=480)

#Merge dates and times, and read them as date-time class objects.
time<-as.POSIXct(paste(subData$Date,subData$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

#Make separate plots of global active power, energy sub-meterings, voltage and
#global reactive power with respect to time.
par(mfcol=c(2,2))
with(subData,{
  plot(subData$Global_active_power ~ time, type="l",
       xlab="",ylab="Global Active Power")
  
  plot(subData[,7] ~ time, type="l",
       xlab="",ylab="Energy sub metering")
  lines(subData[,8] ~ time, type="l",col="red")
  lines(subData[,9] ~ time, type="l",col="blue")
  legend("topright",bty="n",lwd=1,col=c("black","red","blue"),
         names(subData[,7:9]))
  
  plot(Voltage ~ time, type="l",xlab="datetime")
  
  plot(Global_reactive_power ~ time, type="l",xlab="datetime")
})
dev.off()
