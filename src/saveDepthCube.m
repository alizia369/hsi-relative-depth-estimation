function [ output_args ] = saveDepthCube( dcube,bandName,datafolder,imgs )
%SAVEDEPTHCUBE Summary of this function goes here
%   Detailed explanation goes here

if(datafolder(:,end)=='\')
   
        
    else
        datafolder=[datafolder '\'];
end

dcubepath=[datafolder 'DepthCube\'];

if (exist(dcubepath,'dir')==7)
        
    else
        mkdir(dcubepath);
end


save([dcubepath 'dcube.mat'],'dcube','bandName');

if(imgs)
  
    himgspath=[dcubepath 'hyperimgs\'];
    
    if (exist(himgspath,'dir')==7)
        
    else
        mkdir(himgspath);
    end
    
    
    ind = strfind(datafolder, '\');
    fname=datafolder((ind(end-1)+1):end-1);
    
    sz=size(dcube);
 

for i = 1:sz(end)
    slice = dcube(:,:,i);
    
        wl = bandName(i);
    
   imgname=[fname '_'  num2str(wl) '.png'];
   imgname
    imwrite(slice,[himgspath  imgname]);    
    disp(i);
    
    imgagescname=['imagesc_' imgname];
figure, 
imagesc(slice),colormap(hot)
set(gca,'XTick',[]) % Remove the ticks in the x axis!
set(gca,'YTick',[]) % Remove the ticks in the y axis
set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
saveas(gcf,[himgspath imgagescname],'png');

close;
    
 end

    
    
    
    
    
end




end

