# Place-Cell-Analysis-Hippocampus
Allows for the spike timing analysis and comparison across multiple Fall.mat output files from suite2p.

# Instructions for use
In order to use tosinglecell.mat, the script must be placed within the same folder containing the Fall.mat files for a specific animal. 

For example, if we have an animal called ID35, there should be a folder called ID35 that contains Fall1.mat, Fall2.mat,... each containing 1 session worth of data.

tosinglecell.mat will ask the user for the number of sessions conducted on the animal (i.e. number of Fall.mat files) search the current path for these Fall.mat files in order and then output the individual cell spike times files in a folder called Spiketimingsn where n corresponds to which Fallmatn.mat file the script was analysing.

At the end, if we had for example an animal with 2 sessions worth of data, the file pathway will appear as such:
ID35 -> Fall1.mat, Fall2.mat, tosinglecell.mat, Individual Cell Spike Times 1 -> cell0001.mat, cell0002.mat etc, Individual Cell Spike Times 2 -> cell0001.mat, cell0002.mat etc.
