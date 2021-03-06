%Finds the names of files and produces a dictionary linking animal name to
%the date. Returns a cell array ids containing the different IDs in the
%folder, and a cell array containing the corresponding session dates. Each
%ID in ids corresponds to a row in dates.

%for example 
% cellarray1 | Cell Array 2
% ID 35      | 20210507 ...
% ID 37      | 20210507 ...

list = dir;
numfiles = 0;
numanimals = 0; 
ids = {};


for i = 1:size(list,1)
    current_folder = list(i).name;
    if  current_folder(1) == 'I' && current_folder(2) == 'D'
        temp = strcat(current_folder(1), current_folder(2), current_folder(3), current_folder(4));
        
        if isempty(ids)
            numfiles = numfiles + 1;
            numanimals = numanimals + 1;
            ids{numanimals} = temp;
            
            
            dates{numanimals, numfiles} = current_folder(6:end); 
            
        else

                flag = 0;
                for i = 1:length(ids)
                    if temp == ids{i}
                        numfiles = numfiles + 1;
                        dates{i, end+1} = current_folder(6:end);
                        flag = 1;
                    end
                        
                end
                
                if flag == 0; %no match   
                    numfiles = 1;
                    numanimals = numanimals + 1;
                    ids{numanimals} = temp;
                    dates{numanimals, numfiles} = current_folder(6:end);

                end
            end
            
        end
        
    end





    