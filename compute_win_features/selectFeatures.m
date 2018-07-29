function fastPredict = selectFeatures(featureList, fastPredict)
% clear

% window_feature_params.velmagtail = {'mean_params',{'windows', [30,-30; 12,-12],'trans_types',{'relative'}},'min_params',{'windows', [15,-15],'trans_types',{'none'}}}; 
% window_feature_params.centralheadmag = {'min_params',{'windows', [15,-15;30,-30],'trans_types',{'none'}}}; 
% featureList = {{'velmagtail', 'stat', 'mean', 'trans', 'relative', 'radius', 30,'offset', -30},
%     {'velmagtail', 'stat', 'mean', 'trans', 'relative', 'radius', 12,'offset', -12},
%     {'velmagtail', 'stat', 'min', 'trans', 'none', 'radius', 15,'offset', -15},
%     {'centralheadmag', 'stat', 'min', 'trans', 'none', 'radius', 15,'offset', -15},
%     {'centralheadmag', 'stat', 'min', 'trans', 'none', 'radius', 30,'offset', -30}};

wfs = {};
for j = 1:numel(featureList),
    wfidxcurr = find(WindowFeatureNameCompare(featureList{j}, wfs),1);
    if isempty(wfidxcurr),
        wfidxcurr = numel(wfs)+1;
        wfs{wfidxcurr} = featureList{j}; %#ok<AGROW>
    end
end

wf2pff = cellfun(@(x)x{1},wfs,'UniformOutput',false);
[pffs,~,wf2pffidx] = unique(wf2pff);

windowfeaturescellparams = struct;
for pfi = 1:numel(pffs),
    pf = pffs{pfi};
    wfidx_cur = wf2pffidx==pfi;
    windowfeaturescellparams.(pf) = WindowFeatureName2Params(wfs(wfidx_cur));
end

fastPredict.selectFeatureList = featureList;
fastPredict.select_windowfeaturescellparams = windowfeaturescellparams;

% fastPredict = FindWfidx_3(fastPredict, featureList);


% feature_list_with_window_params = {
%     'velmagtail_mean_relative_radius_30_offset_-30',
%     'velmagtail_mean_relative_radius_12_offset_-12',
%     'centralheadmag_min_relative_radius_30_offset_-30',
%     'velmagtail_min_none_radius_15_offset_-15',
%     'centralheadmag_min_none_radius_15_offset_-15'};
