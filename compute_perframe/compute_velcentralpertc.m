%compute central speed in the direction perpendicular to the tail-central direction
function [trx]=compute_velcentralpertc(trx,outputfolder)
inputfilenametc=[outputfolder,'centralheadang.mat'];
if ~exist(inputfilenametc,'file')
    [trx]=compute_tailcentralang(trx,outputfolder);
end
load(inputfilenametc,'data')
tailcentralang=data;
inputfilenameang=[outputfolder,'velangcentral.mat'];
if ~exist(inputfilenameang,'file')
    [trx]=compute_velangcentral(trx,outputfolder);
end
load(inputfilenameang, 'data')
velangcentral=data;
inputfilenamemag=[outputfolder,'velmagcentral.mat'];
if ~exist(inputfilenamemag,'file')
    [trx]=compute_velmagcentral(trx,outputfolder);
end
load(inputfilenamemag, 'data')
velmagcentral=data;
numlarvae=size(tailcentralang,2);
velcentralpertc=cell(1,numlarvae);
tailcentralangperp=cell(1,numlarvae);
for i=1:numlarvae
    tailcentralangperp{1,i}=tailcentralang{1,i}-pi/2;
    velcentralpertc{1,i}=velmagcentral{1,i}.*(cos(velangcentral{1,i}).*cos(tailcentralangperp{1,i}(1,1:end-1))+sin(velangcentral{1,i}).*sin(tailcentralangperp{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velcentralpertc;
filename=[outputfolder, 'velcentralpertc.mat'];
save(filename, 'data', 'units')