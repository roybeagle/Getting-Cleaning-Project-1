fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=fileUrl,destfile = "exdata-data-household_power_consumption.zip")  
unzip("exdata-data-household_power_consumption.zip")
df<-read.table("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors = FALSE)

df$strpdate<-strptime(df$Date,"%d/%m/%Y")
feb2<-subset(df,(strpdate=="2007-02-01") | (strpdate==("2007-02-02")) )
dim(feb2)
feb2$DateTime <- strptime(paste(feb2$Date, feb2$Time), "%d/%m/%Y %H:%M:%S") 
for (x in 3:9){feb2[names(df)[x]]<-as.numeric(feb2[,x])}

library(reshape)
febsub<-feb2[,c(11,7,8,9)]
feb<-melt(febsub, id=c("DateTime"))

#png(filename="plot3.png")
#three<-ggplot(feb)+geom_line(aes(x=DateTime,y=value,colour=variable))+
#  scale_colour_manual(values=c("black","red","blue"))+xlab("")+ylab("Energy sub metering")

#three+theme(legend.title=element_blank(),legend.position = c(0.94,.94),
#                   panel.background = element_rect(fill = 'white', colour = 'black'))
#dev.off()

png(file="plot3.png", width=480, height=480)
plot(feb2$DateTime, d$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering")
lines(d$DateTime, d$Sub_metering_2, col="#ff0000")
lines(d$DateTime, d$Sub_metering_3, col="#0000ff")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),border="black",
       col=c("black","red","blue"),lwd=c(2.5,2.5,2.5))
dev.off()