# Place-Cell-Analysis-Hippocampus
Allows for the spike timing analysis and comparison across multiple Fall.mat output files from suite2p.

# Instructions for use
In order to use tosinglecell.mat, add Place-Cell-Analysis-Hippocampus directory to your matlab path.

The multiday tracking data must have been run previously on the datasets and stored in a folder called "Matches". Each animal should have its own match file with the name "ID_35". The multiday tracking code can be found at https://github.com/ransona/ROIMatchPub.

tosinglecell.mat will search the current directory in hippocampusNew for the folders containing the ID of the mouse and session and make use of the match file to associate similiar cells across sessions. For example, it can be run in the 13-15_month_APPxGCaMP folder.  

![image](https://user-images.githubusercontent.com/70510030/126143710-aed28dad-0a38-4a25-aac4-52fa6440d65f.png)

The code will loop through each folder, extract the spike times of each cell and save them in a new directory called "Individual spike timings" (inside the ID35_20210404 folder). 
