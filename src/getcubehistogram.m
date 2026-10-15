function [ allcounts,r,c ] = getcubehistogram( normat,edgesum,datafolder )
%GETCUBEHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here

tic

if(datafolder(:,end)=='\')

else
datafolder=[datafolder '\'];
end

histfolder=[datafolder 'histogram\'];

if (exist(histfolder,'dir')==7)
        
    else
        mkdir(histfolder);
end


sz=size(normat);

ns=8;%neighbourhood size
histbins=15;% Number of Histogram bins

[r,c]=find(edgesum>=10); % 5 is fine as well

save([histfolder 'points' '.mat'],'r','c');

allcounts=zeros(length(r),15,sz(3));

for b = 1:sz(3)
    
    slice = normat(:,:,b);
    
   % edghist=zeros(sz(1),sz(2),15);
    histcount=[];
    tic
    for i=1:length(r)
        
        rmin=r(i)-ns;
        if(rmin<=0)
        rmin=1;
        end
        
        rmax=r(i)+ns;
        if(rmax>sz(1))
        rmax=sz(1);
        end
        
        cmin=c(i)-ns;
        if(cmin<=0)
        cmin=1;
        end        
        
        cmax=c(i)+ns;
        if(cmax>=sz(2))
           cmax=sz(2); 
        end
        
        
        npix=slice(rmin:rmax,cmin:cmax);%neighbourhood pixels
        
        [counts,centers] = hist(npix(:),histbins);
        
        histcount=[histcount;counts];

%         histinfo(i).histcount=counts;
%         histinfo(i).histcenters=centers;
%         histinfo(i).index=[r c];% row column
%         histinfo(i).rowindex=r;
%         histinfo(i).columnindex=c;
%        
        %edghist(r,c,:)=counts;

      %  i
    end
    
    
    %save([histfolder num2str(b) '-counts.mat'],'histcount');
    allcounts(:,:,b)=histcount;
    
    
    
    %datadescriptor(b).bandindex=b;
    %datadescriptor(b).bandname=
    %datadescriptor(b).histogram=histinfo;
    
    disp('Histogram');
    b
    toc
end

save([histfolder  'histogramPointscube.mat'],'allcounts');
toc

end

