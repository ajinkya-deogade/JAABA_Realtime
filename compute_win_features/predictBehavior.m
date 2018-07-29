function [pred, scores] = predictBehavior(tStartAll, tEndAll, perframe_data_curr, fastPredict)

[pred, scores] = PredictWholeMovie_2(tStartAll, tEndAll, perframe_data_curr, fastPredict);