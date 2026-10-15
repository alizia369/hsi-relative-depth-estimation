function [ norldmap ] = smoothingdmap( norldmap )
%SMOOTHINGDMAP Summary of this function goes here
%   Detailed explanation goes here
[rl,cl]=find(norldmap>0);

pos=[rl,cl];

[nin,d]=knnsearch(pos,pos,'k',32);%original
%[nin,d]=knnsearch(pos,pos,'k',128);


for j=1:length(nin)
neighbours=nin(j,:);

pixind=pos(neighbours,:);

nrow=pixind(:,1);
ncol=pixind(:,2);

linindex=sub2ind(size(norldmap),nrow,ncol);

neighbourvalues=norldmap(linindex);

% nmean=mean(neighbourvalues);
% norldmap(linindex)=nmean;

nmedian=median(neighbourvalues);
norldmap(linindex)=nmedian;

% [sortedValues,sortIndex] = sort(neighbourvalues(:),'descend');
% topvalues=sortedValues(1:23);
% nmedian=median(topvalues);
% norldmap(linindex)=nmedian;

% values=neighbourvalues(neighbourvalues>0.3);
% if(isempty(values))
% nmedian=mean(neighbourvalues);
% else
% nmedian=median(values);
% end
% norldmap(linindex)=nmedian;

end

end

