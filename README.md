# Place-Cell-Analysis-Hippocampus
Allows for the spike timing analysis and comparison across multiple Fall.mat output files from suite2p.

# Instructions for use
In order to use tosinglecell.mat, add Place-Cell-Analysis-Hippocampus directory to you matlab path. 

tosinglecell.mat will search the current directory in hippocampusNew for the folders containing the ID of the mouse and session. For example, it can be run in the 13-15_month_APPxGCaMP folder.  

![image](https://user-images.githubusercontent.com/70510030/126143710-aed28dad-0a38-4a25-aac4-52fa6440d65f.png)

The code will loop through each folder, extract the spike times of each cell and save them in a new directory called "Individual spike timings" (inside the ID35_20210404 folder). 
