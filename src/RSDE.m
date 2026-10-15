function [ rsdesum,norrsdesum ] = RSDE( normat,datafolder )
%function [ rsdesum,norrsdesum ] = RSDE( localdepthcube,datafolder )
%RSDE Summary of this function goes here
%   Detailed explanation goes here
if(datafolder(:,end)=='\')
   
        
    else
        datafolder=[datafolder '\'];
end

rsdepath=[datafolder 'RSDE\'];

if (exist(rsdepath,'dir')==7)
        
    else
        mkdir(rsdepath);
end


sz=size(normat);
%sz=size(localdepthcube);


k=1;
%com=nchoosek(sz(3),2);
dissum=zeros(sz(1),sz(2));
alldis=[];

for i=1:sz(3)
   
    for j=i:sz(3)
       
        target=normat(:,:,i);
        source=normat(:,:,j);
        
        %target=localdepthcube(:,:,i);
        %source=localdepthcube(:,:,j);
        
        %nortarget=target./mean(target(:));
        %norsource=source./mean(source(:));
        
        nortarget=target;
        norsource=source;
        
        
        edis=sqrt((nortarget-norsource).^2);
        
        dissum=dissum+edis;
        
        alldis(:,:,k)=edis;
        
        k=k+1;
        
        %k
        
    end
    i
    save([rsdepath 'dis' num2str(i) '.mat'],'alldis');
    alldis=[];
    k=1;
end


%rsdp

% sz2=size(alldis);
% 
% sumdis=sum(alldis,3);
% 
% 
rsdesum=zeros(sz(1),sz(2));

for m=1:sz(3)
    
    val=load([rsdepath 'dis' num2str(m)  '.mat']);
    
    sz2=size(val.alldis);
    
    if length(sz2)>2
       loopend=sz2(3);
    else
        loopend=1;
    end
    
    for n=1:loopend
    
   
   
   crsdp=val.alldis(:,:,n)./dissum;
    
   crsdp(find(isnan(crsdp)))=0;
   
    rsdp(:,:,n)=crsdp;
    
    crsdp2=crsdp;
    
    ind=find(crsdp>0);
    crsdp2(ind)=crsdp(ind).*log(crsdp(ind));
    
    rsdesum=rsdesum + crsdp2;
    %rsdesum=rsdesum + ( rsdp(:,:,n).*log(rsdp(:,:,n)));
    end
    
    save([rsdepath 'rsdp' num2str(m) '.mat'],'rsdp');
    rsdp=[];
    m
    
end
 
 rsdesum=rsdesum.*-1;

% %rsde
% rsdesum=[];
% 
% for n=1:sz2(3)
% 
%   rsdesum=rsdesum +  rsdp(:,:,n).*log(rsdp(:,:,n));
%     
% end
% 
% 
% 
% 

indx=find(rsdesum==-Inf | rsdesum==Inf);


 rsdesum(indx)=0;
 
 
 
 
 figure,imagesc(rsdesum);
 
 
%normalise 
% rsdesum=rsdesum.^2;
% 
% norrsdesum=rsdesum;
% in=find(rsdesum~=0);
% 
% %vals=rsdesum(in);
% 
% 
% mapvalues=rsdesum(in);
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
% percenttoremove=0.1;%0.1
% removeval=round(szm(1)*percenttoremove/100);
% 
% cmpvalues=smvalues(1:(szm(1)-removeval));
% maxval_cmp=max(cmpvalues(:));
% 
% for i=1:szm(1)
%     
%   ind=find(cmpvalues==mapvalues2(i));
%   
%   if isempty(ind)
%    mapvalues2(i)=maxval_cmp;
%    
%   end
%   
%     
% end
% 
% trsdesum=rsdesum;
% 
% trsdesum(in)=mapvalues2;
% 
% vals=trsdesum(in);

% maxval_map=max(vals(:));
% minval_map=min(vals(:));
% norrsdesum(in)=(trsdesum(in)-minval_map)./(maxval_map - minval_map);  
%  
% figure,imagesc(norrsdesum);
%  

maxval_map=max(rsdesum(:));
minval_map=min(rsdesum(:));
norrsdesum=(rsdesum - minval_map)./(maxval_map - minval_map);  


figure,imagesc(norrsdesum);



end

