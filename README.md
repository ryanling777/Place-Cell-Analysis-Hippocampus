# Place-Cell-Analysis-Hippocampus
This program loops through the session folders of an animal and uses the fall.mat output files from Suite2p to extract individual cell spike timings from allowing for the spike timing analysis and comparison across sessions. The indexes of each output cell are consistent over all sessions (i.e. cell0001 in session 1 is the cell0001 in session 4).

# Instructions for use
In order to run the program, add Place-Cell-Analysis-Hippocampus directory to your matlab path. The only script that needs to be run is tosinglecell.m.

The multiday tracking data must have been run previously on the datasets and stored in a folder called "Matches". Each animal should have its own match file with the name "IDXX" where XX is the mouse number. The multiday tracking code can be found at https://github.com/ransona/ROIMatchPub. It is very important to name the matching .mat file as such. While it is possible to add-on new sessions to the current list of match files, this is not advisable as the previous matches have been found to change. As such it is recommended to finish all sessions before running the roiMatchPub code to identify matches.

sortingdirectories.m is used to scan the current path and identify how many different animals are present and how many sessions each animal is present, while removeduplicates.m takes the roiMatchPub output file and stores all the non-duplicated matches. Both of these are called in the main tosinglecell.m file. 

tosinglecell.mat will search the current directory in hippocampusNew for the folders containing the ID of the mouse and session and make use of the match file to associate similiar cells across sessions. For example, it can be run in the 13-15_month_APPxGCaMP folder. A important point to note is that each session must be named in the following format - "IDXX_YYYYMMDD", files that are not a session should not be of this format and should not start with "IDXX".

![image](https://user-images.githubusercontent.com/70510030/126143710-aed28dad-0a38-4a25-aac4-52fa6440d65f.png)

The code will loop through each folder, extract the spike times of each cell and save them in a new directory called "Individual spike timings" (inside the ID35_20210404 folder). Inside the "Individual spike timings" folder folders of individual cells will be produced i.e. "Cell0001". The spiketiming data can be found inside "Cell0001" and is called "spiketrain.mat". 

The individual cell spike train folder will only appear if that same cell has been active in a specific session. All indexes are consistent across all sessions. For example, if in session 1 cell 0001 is active, the file "cell0001" will appear in the "Individual spike timings" folder with "spiketrain.mat" included. If this same cell is not active in session 2, the folder "cell0001" will not appear in  the "Individual spike timings folder" in session 2. If cell0001 is active in session 3 the opposite will happen, and a folder of "cell0001" will appear in the "individual spike timings" folder in session 3.

At the end of runtime, the program will output a IDXX_tracking.mat file which is a 2D array that stores all associated cells in their respective sessions (column no.) against the cell index system the program produced (row number). The numbers in this array correspond to the nth cell and NOT ROI number.

It is possible to run tosinglecell.m in a path that contains multiple animals. ie. the program will work as per normal if the path contains ID45 and ID39 animals.


