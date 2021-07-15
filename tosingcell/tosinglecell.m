%This program takes a completed folder for a specific animal i.e. ID35, where its
%data for each day/session is named as Fall1.mat, Fall2.mat...etc. and
%outputs a .mat file containing a cell array for each cell comprising of
%the cells x, y coordinate, spike timing. The index of each cell is aligned
%in each of the output files.

%From each session a cell array is produced with each cell containing a
%structure array with info about that cell. 

%cell array containing all known cell info and corresponding cell indexes.
cellMaster = {};

%cell array containing 
%cellSession = {};
%importing the cell information into the script. 
Numtrials = input('Input number of sessions this animal has completed: ');

for k = 1:Numtrials
    matfilename = sprintf('Fall%d.mat', k);
    if isfile(matfilename)
        load(matfilename);
        
        cellIndex = find(iscell(:,1)==1); %indexes of all cells.
        alldata = stat;
        cellData = cell(size(cellIndex,1), 1);
        spikes = spks(cellIndex, :);
        
        for i = 1:size(cellData, 1)
            cellData{i} = alldata{cellIndex(i)}; %celldata contains all the cell data that are cells
       
        end
        
        
        if k == 1 %if this is the first file
                cellMaster = cellData;
                spiketimes = spikes;
        else 
            %numCells = size(cellMaster, 1);
            
            originalnum = size(cellMaster, 1)
            size(cellData, 1)
            
            
            spiketimes = zeros(originalnum, 24884);
            
            
            for i = 1:size(cellData, 1)
                cellarray1 = cellData{i}; %accessing the structs holding coordinate data
                count = 0; %flag to indicate whether cell has already been recognised from previous sessions.
                j = 1;
                while count == 0 && j <= originalnum
                    cellarray2 = cellMaster{j}; 
                    
                    
                    
                    if ((cellarray1.med(1) < cellarray2.med(1)+5 && cellarray1.med(1) > cellarray2.med(1)-5) && (cellarray1.med(2) < cellarray2.med(2)+5 && cellarray1.med(2) > cellarray2.med(2)-5))
                        spiketimes(j,:) = spikes(i,:); 
                        count = 1;
                    
                    end
                    j = j+1;
                end
                if count == 0 && j == originalnum + 1
                    
                 
                    cellMaster{end+1} = cellarray1; %adds new cell to the end
                    spiketimes(end+1, :) = spikes(i, :);
                end
            end
        end
        
        
        mkdir(strcat('Individual Cell Spike Times ', string(k)));

        cd(strcat('Individual Cell Spike Times ', string(k)));
        size(spiketimes, 1)

        % cell is the iterator. cellspike temporarily stores row represnting a
        % particular cell.
        for cell = 1:size(spiketimes, 1)
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

        cd '..';   
        clearvars -except cellMaster;
        
        
        
        
        
    else
        fprintf('File %s does not exist. \n', matfilename);
    end 
end

