function [filePath] = addDateToFilename(fileDir, fileName, fileString)
    
    formatOut = 'yyyy/mm/dd';
    dat = datestr(clock,formatOut);
    dateName =  strrep(strrep(strrep(dat,'/',''),':',''),' ','_');
%     fileDir  = [fileDir, filesep, dateName];
    fileName = [dateName, fileString];
    filePath = fullfile(fileDir, fileName);
    
end