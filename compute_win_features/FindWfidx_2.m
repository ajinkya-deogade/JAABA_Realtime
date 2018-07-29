function [wfidx] = FindWfidx_2(wfs, feature_names)

% wfs = fastPredict.wfs;

wfs_char = cellfun(@cell2str, wfs, 'UniformOutput', false);
feature_names_char = cellfun(@cell2str, feature_names, 'UniformOutput', false);
[ism, wfidx] = ismember(wfs_char, feature_names_char);
if ~all(ism),
    error('Error matching wfs for classifier with window features computed');
end
% 
% fastPredict.wfidx = wfidx;
% fastPredict.wfidx_valid = true;
end
