function yphys_recoverRoi
global gh
try
    hroi = gh.yphys.figure.yphys_roi(1);
    set(hroi, 'visible', 'off');
    set(hroi, 'visible', 'on');
end
for i = 2:4
    try
        hroi = gh.yphys.figure.yphys_roi2(1, i);
        set(hroi, 'visible', 'off');
        set(hroi, 'visible', 'on');
    end
end