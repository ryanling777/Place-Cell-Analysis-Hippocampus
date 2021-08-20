%This program takes a completed folder of recordings of multiple animals ie the 13-15month_APPxGCaMP foler , 
%outputs a .mat file containing a cell array for each cell comprising of
%the cell's spike timing. The index of each cell is aligned
%in each of the output files. 


%At the end of runtime, a celltracking.matfile is produced containing a
%record of the cell indexing. As a guide, the row number corresponds to the
%cell index and each digit corresponds to the the nth cell (Not ROI no.)

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
                    trackingdata = zeros(size(cellData, 1), size(dates, 2)); 
                    for i = 1:size(trackingdata,1)
                        trackingdata(i,1) = i; %because first file sets precedent.
                    end
            else 
                

                originalnum = size(cellMaster, 1);
                

                spiketimes = zeros(originalnum, size(spikes,2)); 

                
                for i = 1:size(cellData, 1)
                    
                    cellarray1 = cellData{i};
                    count = 0;%indicates if the current cell has a match in matches.
                    
                    
                    
                    [r, c] = find(matches == i);
                    
                    %getting the index of the row in matched the cell is
                    %located at. (specific to session)
                    index = find(c == column);
                    
                    if index
                        count = 1;
                        rowno = r(index);
                    end
                    
                    flag1 = 1; %to keep track if there are no matches to the left.
                    k = column - 1;
                    %if there is a match, rown0 will hold the index of the cell
                    %in matches whose column contains that match.
                    if count == 1
                    
                        while (k >= 1) & (matchescopy(rowno(1),k)==0)  
                            k = k - 1;
                            flag1 = flag1 + 1;
                        end 
                        
                        if flag1 ~= column
                            
                            spiketimes(matchescopy(rowno(1),k), :) = spikes(matchescopy(rowno(1),column),:);
                            trackingdata(matchescopy(rowno(1),k),column) = i;

                            matchescopy(rowno(1),column) = matchescopy(rowno(1),k); %to keep track of the cells. 
                        end
                    end
                    
                    %if no matches are found or this is the start of the
                    %match, i.e. if  we have 3 sessions, the loop is in the
                    %second session and the matches are in session 2 and 3
                    %etc.
                    if count == 0 | flag1 == column


                        cellMaster{end+1} = cellarray1; %adds new cell to the end
                        trackingdata(size(cellMaster, 1),column) = i;
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
                    mkdir(strcat('Cell000', string(cell)));
                    cd(strcat('Cell000', string(cell)));
                    save('spiketrain', 'indi_cellspike');
                    cd '..';
                elseif cell < 100 & cell >= 10 
                    mkdir(strcat('Cell00', string(cell)));
                    cd(strcat('Cell00', string(cell)));
                    save('spiketrain', 'indi_cellspike');
                    cd '..';
                elseif cell < 1000 & cell >= 100
                    mkdir(strcat('Cell0', string(cell)));
                    cd(strcat('Cell0', string(cell)));
                    save('spiketrain', 'indi_cellspike');
                    cd '..';
                elseif cell >= 1000 
                    mkdir(strcat('Cell', string(cell)));
                    cd(strcat('Cell', string(cell)));
                    save('spiketrain', 'indi_cellspike');
                    cd '..';
                end 
            end
        end

        cd '..';  
        cd '..';
        clearvars -except cellMaster dates ids row column matches matchescopy trackingdata;
        size(cellMaster,1)
    end
        save(strcat('CellTracking_', ids{row}), 'trackingdata');
    end
    

        
        
    