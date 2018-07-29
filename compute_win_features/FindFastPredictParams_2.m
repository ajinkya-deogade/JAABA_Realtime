%% Working
function fastPredict = FindFastPredictParams_2(classifier, featureList)

feature_names = classifier.featureNames;

% which features are actually used
dims = [classifier.params.dim];
feature_names = feature_names(dims);

% put these in with the rest of the classifiers' window features
wfs = {};
for j = 1:numel(feature_names),
    wfidxcurr = find(WindowFeatureNameCompare(feature_names{j}, wfs),1);
    if isempty(wfidxcurr),
        wfidxcurr = numel(wfs)+1;
        wfs{wfidxcurr} = feature_names{j}; %#ok<AGROW>
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

classifiers_indexed = classifier.params;
for j = 1:numel(classifiers_indexed),
    classifiers_indexed(j).dim = j;
end

fastPredict.classifier = classifiers_indexed;
fastPredict.windowfeaturescellparams = windowfeaturescellparams;
fastPredict.wfs = feature_names;
fastPredict.pffs = pffs;
fastPredict.ts = classifier.timeStamp;
fastPredict.wfidx_valid = false;
fastPredict.allperframefns = classifier.sublexiconPFNames;

%% For Selected Features
fastPredict = selectFeatures(featureList, fastPredict);
wfs = fastPredict.wfs;

wfs_char = cellfun(@cell2str, wfs, 'UniformOutput', false);
feature_names_char = cellfun(@cell2str, fastPredict.selectFeatureList, 'UniformOutput', false);

[ism, wfidx] = ismember(wfs_char, feature_names_char);

fastPredict.select_classifier = fastPredict.classifier(ism);
fastPredict.select_wfs = feature_names(ism);

classifiers_indexed = fastPredict.select_classifier;
for j = 1:numel(classifiers_indexed),
    classifiers_indexed(j).dim = j;
end
fastPredict.select_classifier = classifiers_indexed;

%% Find Index
[wfidx] = FindWfidx_2(fastPredict.select_wfs, fastPredict.selectFeatureList);
fastPredict.select_wfidx = wfidx;
end