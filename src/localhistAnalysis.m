function [ localdepthcube ] = localhistAnalysis( allcounts,r,c,edgesum )
%LOCALHISTANALYSIS Summary of this function goes here
%   Detailed explanation goes here

sz=size(allcounts);

edsz=size(edgesum);


localdepthcube=zeros(edsz(1),edsz(2),sz(3));

size(localdepthcube)

for i=1:sz(3)
    
   slice=allcounts(:,:,i);
   
   slsz=size(slice);
   
   img=zeros(edsz(1),edsz(2));
   
   for j=1:slsz(1)
      
       edhist=slice(j,:);
       
       varhist=var(edhist);
       
       img(r(j),c(j))=varhist;
      
       
   end
    
   %size(localdepthcube)
   
   %size(img)
   
   localdepthcube(:,:,i)=img;
   
   
%    if(rem(i,6)==0)
%       
%        figure,imagesc(img);
%        
%    end
   
   i
   
end



end

