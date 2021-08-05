%This program takes a completed folder of recordings of multiple animals ie the 13-15month_APPxGCaMP foler , 
%outputs a .mat file containing a cell array for each cell comprising of
%the cells x, y coordinate, spike timing. The index of each cell is aligned
%in each of the output files.

%From each session a cell array is produced with each cell containing a
%structure array with info about that cell. 

sortingdirectories
%cell array containing all known cell info and corresponding cell indexes.
cellMaster = {};

%importing the cell information into the script. 


for row = 1:size(dates, 1)
    %Fetching the matching data. The matching Github code file should be
    %stored in a folder called 'Matches' and named 'ID35'(Mouse's ID).
    cd 'Matches';
    load(ids{row});
    cd '..';
    removeduplicates
    matches = noduplicates;%the original indexes.
    matchescopy = noduplicates; %this will be amended with the new cell index.
    
    for column = 1:size(dates, 2)
    
        if ~isempty(dates{row, column})
            directory = strcat(ids{row}, '_', dates{row,column});
            cd(directory);

            load('Fall.mat');
            cellIndex = find(iscell(:,1)==1); %indexes of all cells.
            alldata = stat;
            cellData = cell(size(cellIndex,1), 1);
            spikes = spks(cellIndex, :);

            for i = 1:size(cellData, 1)
                cellData{i} = alldata{cellIndex(i)}; %celldata contains all the cell data that are cells

            end
            

            if column == 1 %if this is the first file
                    cellMaster = cellData;
                    spiketimes = spikes;
            else 
                

                originalnum = size(cellMaster, 1);
                size(cellData, 1);


                spiketimes = zeros(originalnum, 24884); %24884 is number of frames.

                
                for i = 1:size(cellData, 1)
                    
                    cellarray1 = cellData{i};
                    count = 0;%indicates if the current cell has a match in matches.
                    
                    
                    
                    [r, c] = find(matches == i);
                    
                    %getting the index of the row in matched the cell is
                    %located at. (stored in j)
                    index = find(c == column);
                    
                    if index
                        count = 1;
                        rowno = r(index);
                    end
                    
                    flag1 = 1; %to keep track if there are no matches to the left.
                    k = column - 1;
                    %if there is a match, rown will hold the index of the cell
                    %in matches whose column contains that match.
                    if count == 1
                    
                        while (k >= 1) & (matchescopy(rowno(1),k)==0)  
                            k = k - 1;
                            flag1 = flag1 + 1;
                        end 
                        
                        if flag1 ~= column
                            
                            spiketimes(matchescopy(rowno(1),k), :) = spikes(matchescopy(rowno(1),column),:);

                            matchescopy(rowno(1),column) = matchescopy(rowno(1),k); %to keep track of the cells. 
                        end
                    end
                    
                    %if no matches are found or this is the start of the
                    %match, i.e. if  we have 3 sessions, the loop is in the
                    %second session and the matches are in session 2 and 3.
                    if count == 0 | flag1 == column


                        cellMaster{end+1} = cellarray1; %adds new cell to the end
                        spiketimes(end+1, :) = spikes(i, :);
                        if flag1 == column
                            for a = 1:length(rowno)
                                matchescopy(rowno(a), column) = size(cellMaster, 1); %if this is the start of a match, we put the new cell index inside the matches array.
                            end
                        end
                        
                        
                    end
                end
                end
            end
       


        mkdir('Individual Cell Spike Times ');

        cd('Individual Cell Spike Times ');
        
        %storesindexes of all inactive cells currently in spiketimes
        inactive_cellindex = all(spiketimes == 0, 2);
        
        % cell is the iterator. cellspike temporarily stores row represnting a
        % particular cell.
        for cell = 1:size(spiketimes, 1)
            
            if inactive_cellindex(cell) == 0
                indi_cellspike = spiketimes(cell,:);
                if cell < 10
                    save(strcat('Cell000', string(cell)), 'indi_cellspike');
                elseif cell < 100 & cell >= 10 
                    save(strcat('Cell00', string(cell)), 'indi_cellspike');
                elseif cell < 1000 & cell >= 100
                    save(strcat('Cell0', string(cell)), 'indi_cellspike');
                elseif cell >= 1000 
                    save(strcat('Cell', string(cell)), 'indi_cellspike');
                end 
            end
        end

        cd '..';  
        cd '..';
        clearvars -except cellMaster dates ids row column matches matchescopy;

        end
    end
    

        
        
    