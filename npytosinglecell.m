%Converts the output spks.npy file into 1D .mat files in a new folder
%called 'Individual Cell Spike Times' . Must have directory npy-matlab by
%kwikteam (GitHub) added to matlab path.

spikes_raw =  double(readNPY('spks.npy'));

mkdir('Individual Cell Spike Times');

cd 'Individual Cell Spike Times';


% cell is the iterator. cellspike temporarily stores row represnting a
% particular cell.
for cell = 1:size(spikes_raw, 1)
    cellspike = spikes_raw(cell,:);
    if cell < 10
        save(strcat('Cell000', string(cell)), 'cellspike');
    elseif cell < 100 & cell >= 10 
        save(strcat('Cell00', string(cell)), 'cellspike');
    elseif cell < 1000 & cell >= 100
        save(strcat('Cell0', string(cell)), 'cellspike');
    elseif cell >= 1000 
        save(strcat('Cell', string(cell)), 'cellspike');
    end 
end 
        
    