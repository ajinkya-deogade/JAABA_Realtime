%compute central speed in the central-head direction
function [trx]=compute_velcentralch(trx,outputfolder)
inputfilenamech=[outputfolder,'centralheadang.mat'];
if ~exist(inputfilenamech,'file')
    [trx]=compute_centralheadang(trx,outputfolder);
end
load(inputfilenamech,'data')
centralheadang=data;
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
numlarvae=size(centralheadang,2);
velcentralch=cell(1,numlarvae);
for i=1:numlarvae
    velcentralch{1,i}=velmagcentral{1,i}.*(cos(velangcentral{1,i}).*cos(centralheadang{1,i}(1,1:end-1))+sin(velangcentral{1,i}).*sin(centralheadang{1,i}(1,1:end-1)));
end

units=struct('num','mm','den','s');
data=velcentralch;
filename=[outputfolder, 'velcentralch.mat'];
save(filename, 'data', 'units')