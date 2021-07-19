%Finds the names of files and produces a dictionary linking animal name to
%the date. Returns a cell array ids containing the different IDs in the
%folder, and a cell array containing the corresponding session dates. Each
%ID in ids corresponds to a row in dates.

%for example 
% cellarray1 | Cell Array 2
% ID 35      | 20210507 ...
% ID 37      | 20210507 ...

list = ls
numfiles = 0;
numanimals = 0; 
ids = {};


for char = 1:length(list)-1
    if list(char) == 'I' && list(char+1) == 'D'
        temp = strcat(list(char), list(char+1), list(char+2), list(char+3));
        
        if isempty(ids)
            numfiles = numfiles + 1;
            numanimals = numanimals + 1;
            ids{numanimals} = temp;
            dates{numanimals, numfiles} = strcat(list(char+5), list(char+6), list(char+7), list(char+8), list(char+9), list(char+10), list(char+11), list(char+12));
            
        else

%             if temp == ids{numanimals} %if animal already exists.
%                 numfiles = numfiles + 1;
%                 
%                 dates{numanimals,numfiles} = strcat(list(char+5), list(char+6), list(char+7), list(char+8), list(char+9), list(char+10), list(char+11), list(char+12));
%                
%             else% if animal doesn't already exist
                flag = 0;
                for i = 1:length(ids)
                    if temp == ids{i}
                        numfiles = numfiles + 1;
                        dates{i, end+1} = strcat(list(char+5), list(char+6), list(char+7), list(char+8), list(char+9), list(char+10), list(char+11), list(char+12));
                        flag = 1;
                    end
                        
                end
                
                if flag == 0; %no match   
                    numfiles = 1;
                    numanimals = numanimals + 1;
                    ids{numanimals} = temp;
                    dates{numanimals, numfiles} = strcat(list(char+5), list(char+6), list(char+7), list(char+8), list(char+9), list(char+10), list(char+11), list(char+12));

                end
            end
            
        end
        
    end





    