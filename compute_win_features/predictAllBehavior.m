function [all_pred, scores] = predictAllBehavior(rootdir)

% all_pred = [];
[perframedata, fastPredict, tStartAll, tEndAll] = loadParameters(rootdir);

%     window = 60;
%     tEndAll = 120;

%     for i = window+1:tEndAll
%         tEndAll_window = i+5000;
%         tStartAll_window = tEndAll_window-window;
tEndAll_window = tEndAll;
tStartAll_window = tStartAll;

% perframe_data_window = structfun(@(x) x(tStartAll_window:tEndAll_window), perframedata, 'UniformOutput', false);
perframe_data_window = perframedata;
% [pred, scores] = predictBehavior(tStartAll_window, tEndAll_window, perframe_data_window, fastPredict);
[all_pred, scores] = predictBehavior(tStartAll_window, tEndAll_window, perframe_data_window, fastPredict);
% all_pred(i) = pred;
%     end

end