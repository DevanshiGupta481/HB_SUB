# 
# Welcome to GDB Online.
# GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
# C#, OCaml, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
# Code, Compile, Run and Debug online from anywhere in world.

# installation of software(fastqc,samtools,qualimap)
sudo apt-get install fastqc
sudo apt-get install samtools
sudo apt-get install qualimap

#Downloads some sample datasets
wget https://github.com/josoga2/yt-dataset/tree/main/dataset/raw_reads

#Create a folder called output
mkdir output
 
#Implement the fastqc and send output to the output folder
fastqc raw_reads/ACBarrie_R1.fastq.gz -o output/

#Implement samtools
wget https://github.com/josoga2/yt-dataset/tree/main/dataset/alignment_map
cd alignment_map
samtools
#compare file size
ls -lh
#converting sam-files to bam-files
samtools view -s -b ACBarrie.sam > sample_ACBarrie.bam
samtools view sample_ACBarrie.bam | less
#remove unnecessary file
rm*.sam
#sorting bam files
samtools view sample_ACBarrie.bam | head
samtools sort sample_ACBarrie.bam -o sample_ACBarrie.sorted.bam

#Implement the qualimap
wget https://github.com/josoga2/yt-dataset/tree/main/dataset
qualimap bamqc -bam /home/dataset/alignment_map/ACBarrie.bam -o output/

