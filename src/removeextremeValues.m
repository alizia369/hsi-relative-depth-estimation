function [ outdmap ] = removeextremeValues( dmap )
%REMOVEEXTREMEVALUES Summary of this function goes here
%   Detailed explanation goes here


indx=find(dmap>0);
mapvalues=dmap(indx);
szm=size(mapvalues);

percenttoremove=0.1;
removeval=round(szm(1)*percenttoremove/100);

%%%remove uper values
[sortedValues,sortIndex] = sort(dmap(:),'descend');

outdmap=dmap;

newmaxval=max(outdmap(sortIndex(removeval:end)));

outdmap(sortIndex(1:removeval))=newmaxval;


%%%%remove lower values

% sortedValues2 = unique(dmap(:));          %# Unique sorted values
% minValues = sortedValues2(2:(removeval+2));  %# Get the min values without zero
% minIndex = ismember(dmap,minValues);           %# Get a logical index of all values equal to the n smallest values
% 
% outdmap(minIndex)=minValues(end);



end

