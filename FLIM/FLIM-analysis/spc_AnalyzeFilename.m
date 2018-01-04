function [filepath, basename, filenumber, max1, spc1] = spc_AnalyzeFilename(filename)
spc1 = 1;
filename_length = length(filename);
i = filename_length - 7;


if ~isempty(strfind(filename, '\')) || ~isempty(strfind(filename, '/'))
    while (filename(i) ~= '\' && filename(i) ~= '/') && i >= 1;
        i = i - 1;
    end

    if i <= 0
        error ('Not a valid filename')
    end

    filepath = filename(1:i);
else
    filepath = [pwd, filesep];
    i = 0;
end

if strcmp(filename(end-7:end-4), '_max')
    max1 = 1;
    filenumber = str2num(filename(end-10:end-8));
    basename = filename(i+1:end-11);
elseif strcmp(filename(end-6:end-4), 'max')
    max1 = 1;
    filenumber = str2num(filename(end-9:end-7));
    basename = filename(i+1:end-10);
    spc1 = 0;
else 
    max1 = 0;
    filenumber = str2num(filename(end-6:end-4));
    basename = filename(i+1:end-7);
end

if isempty(findstr(filepath, 'spc'))
    spc1 = 0;
end