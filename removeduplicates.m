%This script will take the match file outputted by ROImatchpub and remove
%duplicates in the ROI. Eg if we have a match of 13 0 35 and  0 68 35, this
%should simplify to 13 68 35.

data = roiMatchData.mapping;

nonzerosignal = all(data == 0, 2);
indexes = find(nonzerosignal(:,1)==0);
nonzero = data(indexes, :);
noduplicates = unique(nonzero, 'rows');
noduplicatesref = noduplicates;


for j = 1:size(noduplicates,2)
    i = 1;
    while i<=size(noduplicates,1)-1
        
        if noduplicates(i,j) ~= 0
                
            if noduplicates(i,j) == noduplicates(i+1,j)
               
                check1 = all(noduplicates(i,:)); %will only be 1 if all 3 are non-zero.
                check2 = all(noduplicates(i+1,:));

                if check1 == 0 && check2 == 1
                    noduplicates(i,:) = [];
                    i = i+1;
                elseif check1 == 1 && check2 == 0
                    noduplicates(i+1,:) = [];
                    i = i+1;
                elseif check1 == 0 && check2 ==0
                                
                    noduplicates(i,:) = [];
                    noduplicates(i,:) = [];
                    

                else
                    i = i+1;
                end
            else
                i = i+1;
            end
        else
            i = i+1;
        end

    end
    
    noduplicates = sortrows(noduplicates,j);
end
            
        
noduplicates = sortrows(noduplicates, 1);



