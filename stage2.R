#Calculate the product of 31 and 78
31*78
#Divide 697 by 41
697/41
#Add 314 and 654
314 + 654
#Subtract 23 from 56765
56765-23
#Assign 39 to x
x<-39
x
#Assign 14 to y
y<-14
y
#Make z the value of x - y
z = x-y
z
#Calculate the square root of 2345, and perform a log2 transformation on the result
log2(sqrt(2345))
#Create a vector called vec1 containing the numbers 2,5,8,12 and 16
c(2,5,8,12,16) -> vec1
vec1
#Use seq() to make a vector of 100 values starting at 2 and increasing by 3 each time and store it in a new variable
seq(from=2,by=3,length.out=100) -> number.series
number.series
#Extract the values at positions 5,10,15 and 20 in the vector of 100 values you made
number.series[c(5,10,15,20)]
#Extract the values at positions 10 to 30 in the vector of 100 values you made
number.series[10:30]
#Enter the following into a vector with the name mouse_colour. Remember to surround each piece of text with quotes: purple, red, yellow, brown
c("purple","red","yellow","brown") -> mouse.colour
mouse.colour 
#Enter the following into a vector with the name mouse_weight: 23, 21, 18, 16
c(23,21,18,26) -> mouse.weight
mouse.weight
#Join the 2 vectors together using the data.frame function to make a data frame named mouse_info with 2 columns and 4 rows. Call the first column ‘color’ and the second one ‘weight’
data.frame(colour=mouse.colour, weight=mouse.weight) -> mouse.info
mouse.info
#Read the file ‘small_file.txt’ [https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/small_file.txt] into a new data structure using read.table() OR read.delim(). Remember to assign a name to the data that you read in using the assignment operator
read.delim("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/small_file.txt") -> small.file
small.file
#Read the file ‘Child_Variants.csv’ [https://github.com/HackBio-Internship/public_datasets/blob/main/R/Child_Variants.csv?raw=true] into a new data. This is a comma-separated file so you should use read.csv(). Again, remember to assign a name to the data when you import it
read.csv("https://github.com/HackBio-Internship/public_datasets/blob/main/R/Child_Variants.csv?raw=true") -> child.variants
#Use head and View to look at the data set to check that it has imported correctly.
head(child.variants)
#Calculate the mean of the column named MutantReadPercent. Think about how you are going to access a single column first (probably by using the $ notation or [] notation), then once you can access the data pass it to the mean function
mean(child.variants$MutantReadPercent)
#Create a filtered version of the child variants dataset that only includes rows where the MutantReadPercent is >=70 using subset() function or the [] notation
head(child.variants$MutantReadPercent, n=100)
head(child.variants$MutantReadPercent >= 70, n=100)
child.variants[child.variants$MutantReadPercent >= 70,] -> child.variants.filtered
nrow(child.variants)
nrow(child.variants.filtered)