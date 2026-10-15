function [ output_args ] = focusAnalysis( localdepthcube )
%FOCUSANALYSIS Summary of this function goes here
%   Detailed explanation goes here

sz=size(localdepthcube);

for i=1:sz(3)
    img=localdepthcube(:,:,i);
    szt=size(img);
    ind=find(img>0);
    
    %val=min(img(ind));
    [val,in1]=max(img(ind));
     
    [Ir,Jc] = ind2sub(szt,ind(in1));
    if(i==1)
    RGB = repmat(img,[1,1,3]);
    end
    if(rem(i,3)==0)
    RGB(Ir-8:Ir+8,Jc-8:Jc+8,1)=255;
    elseif(rem(i,3)==1)
    RGB(Ir-8:Ir+8,Jc-8:Jc+8,2)=255;   
    else
    RGB(Ir-8:Ir+8,Jc-8:Jc+8,3)=255;
    end
    %i
    %ind(in)
end

figure,imshow(RGB);

end

