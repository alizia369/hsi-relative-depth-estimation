function [ finalnorldmap ] = normaliseandSmoothLDmap( localdepthmap)
%function [ finalnorldmap ] = normaliseandSmoothLDmap( localdepthmap,edgesum )
%NORMALISEANDSMOOTHLDMAP Summary of this function goes here
%   Detailed explanation goes here

% indx=find(localdepthmap>0);
% 
% mapvalues=localdepthmap(indx);
% 
% mapvalues2=mapvalues;
% 
% smvalues=sort(mapvalues2);
% 
% 
% szm=size(mapvalues2);
% 
% 
% %rmove overexposed data
% percenttoremove=0.1;
% removeval=round(szm(1)*percenttoremove/100);
% 
% cmpvalues=smvalues(1:(szm(1)-removeval));
% maxval_cmp=max(cmpvalues(:));
% 
% for i=1:szm(1)
%     
%   in=find(cmpvalues==mapvalues2(i));
%   
%   if isempty(in)
%    mapvalues2(i)=maxval_cmp;
%    
%   end
%   
%     
% end

% ormapvalues=removeoutliers(mapvalues2);
% 
% szm=size(mapvalues2);
% 
% for i=1:szm(1)
%     
%   in=find(ormapvalues==mapvalues2(i));
%   
%   if isempty(in)
%    mapvalues2(i)=0;
%    
%   end
%   
%     
% end

%localdepthmap(indx)= mapvalues2;

maxval_map=max(localdepthmap(:));
minval_map=min(localdepthmap(:));
norldmap=(localdepthmap-minval_map)./(maxval_map - minval_map);  % Normalise formula for values between 0 and 1  norval= (val-min)./(max-min)

%figure,imagesc(norldmap),title('without smoothing');


[ norldmap ] = smoothingdmap( norldmap );%my function


minval_normap=min(norldmap(:));
maxval_normap=max(norldmap(:));

finalnorldmap=(norldmap-minval_normap)./(maxval_normap - minval_normap);% Just making sure they are normalized and between 0 and 1



%figure,imagesc(norldmap);


% min_nor=min(norldmap(:));
% 
% tempmat=edgesum./norldmap;
% 
% index_temp=find(tempmat==Inf);
% 
% norldmap(index_temp)=min_nor;


%norldmap(norldmap<=0)=0.01;

%norlocalDmap=edgesum.*norldmap;



% norlocalDmap=edgesum.*norldmap;
% 
% [ norlocalDmap ] = smoothingdmap( norlocalDmap );
% 
% minval_normap=min(norlocalDmap(:));
% maxval_normap=max(norlocalDmap(:));
% 
% finalnorldmap=(norlocalDmap-minval_normap)./(maxval_normap - minval_normap);% Just making sure they are normalized and between 0 and 1

end

