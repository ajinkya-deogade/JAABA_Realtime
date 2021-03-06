%compute head speed in the direction perpendicular to the tail-central direction
function [trx]=compute_velheadpertc(trx,outputfolder)
inputfilenametc=[outputfolder,'tailcentralang.mat'];
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
inputfilenameang=[outputfolder,'velanghead.mat'];
if ~exist(inputfilenameang,'file')
    [trx]=compute_velanghead(trx,outputfolder);
end
load(inputfilenameang, 'data')
velanghead=data;
inputfilenamemag=[outputfolder,'velmaghead.mat'];
if ~exist(inputfilenamemag,'file')
    [trx]=compute_velmaghead(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmaghead=data;
numlarvae=size(tailcentralang,2);
velheadpertc=cell(1,numlarvae);
tailcentralangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailcentralangperp{1,i}=tailcentralang{1,i}-pi/2;
    velheadpertc{1,i}=velmaghead{1,i}.*(cos(velanghead{1,i}).*cos(tailcentralangperp{1,i}(1,1:end-1))+sin(velanghead{1,i}).*sin(tailcentralangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velheadpertc;
filename=[outputfolder, 'velheadpertc.mat'];
save(filename, 'data', 'units')