function [ spmapsdiff ] = SumofDifference( normat,edgesum )
%SUMOFDIFFERENCE Summary of this function goes here
%   Detailed explanation goes here
sz=size(normat);

ns=8;%neighbourhood size
histbins=15;% Number of Histogram bins

[r,c]=find(edgesum>=5); % 5 is fine as well

%save([histfolder 'points' '.mat'],'r','c');

%allcounts=zeros(length(r),15,sz(3));

spmap=zeros(sz(1),sz(2));
spmapent=zeros(sz(1),sz(2));
spmapsum=zeros(sz(1),sz(2));

spmapsdiff=zeros(sz(1),sz(2));
%for b = 1:sz(3)
    
    slice = normat(:,:,1);
    
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
        
        
        %nsz=size(npix(:));
        allerr=[];
        alllog=[];
        alldiff=[];
        for j=rmin:rmax
           
            for k=cmin:cmax
                    
                avec=squeeze(normat(r(i),c(i),:));
                bvec=squeeze(normat(r(j),c(k),:));
                %size(avec)
                %size(bvec)
                
%                errRadians = hyperSam(avec, bvec);
%                
%                allerr=[allerr;errRadians];
%                
%                logerr=log(errRadians);
%                alllog=[alllog;logerr];
%             
               diffab=((avec-bvec).^2);
               sumdiff=sum(diffab(:));
               alldiff=[alldiff;diffab];
               
               
            end
        end
        
        
        varrad=var(allerr(:));
        spmap(r(i),c(i))=varrad;
        %[counts,centers] = hist(npix(:),histbins);
        
        %histcount=[histcount;counts];
        proerr=allerr.*alllog;
        
        spmapent(r(i),c(i))=-1.*(sum(proerr(:)));
        spmapsum(r(i),c(i))=sum(allerr(:));
        
        spmapsdiff(r(i),c(i))=sum(alldiff(:));
        %[U,mu,vars] = pca(alldiff);
        %spmapsdiff(r(i),c(i))=sum(vars(:));

        %i
    end
    
%     figure,imagesc(spmap);
%     figure,imagesc(spmapent);
%     figure,imagesc(spmapsum);
    
    
%figure,imagesc(spmapsdiff);

end

