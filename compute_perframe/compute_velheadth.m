%compute head speed in the tail-head direction
function [trx]=compute_velheadth(trx,outputfolder)
inputfilenameth=[outputfolder,'tailheadang.mat'];
if ~exist(inputfilenameth,'file')
    [trx]=compute_tailheadang(trx,outputfolder);
end
load(inputfilenameth,'data')
tailheadang=data;
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
numlarvae=size(tailheadang,2);
velheadth=cell(1,numlarvae);
for i=1:numlarvae
    velheadth{1,i}=velmaghead{1,i}.*(cos(velanghead{1,i}).*cos(tailheadang{1,i}(1,1:end-1))+sin(velanghead{1,i}).*sin(tailheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velheadth;
filename=[outputfolder, 'velheadth.mat'];
save(filename, 'data', 'units')