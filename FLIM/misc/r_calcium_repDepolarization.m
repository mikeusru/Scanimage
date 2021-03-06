function r_calcium_repDepolarization
global state;
global gh;
        
        

if sum(state.files.fileCounter == 4:1:11)
    %putsample(state.yphys.init.phys_patch, 0/state.yphys.acq.commandSensV);
    sr = get(state.yphys.init.phys_patch, 'SampleRate');
    set(state.yphys.init.phys_patch, 'TriggerType', 'HwDigital');
    %depolarize at 128ms
    nF = state.acq.numberOfFrames;
    nLine = state.acq.linesPerFrame;
    a1 = zeros(4*2*nLine/1000*sr, 1); %Twoframes;
    a2 = ones(31*2*nLine/1000*sr, 1)*65/state.yphys.acq.commandSensV;
    a3 = zeros(5*2*nLine/1000*sr, 1);
    data1 = [a1; a2; a3];
    %data1(end) = 0;
    putdata(state.yphys.init.phys_patch, data1);
    start(state.yphys.init.phys_patch);
    %putsample(state.yphys.init.phys_patch, 65/state.yphys.acq.commandSensV);
%elseif state.files.fileCounter == 13
    %set(gh.spc.FLIMimage.Uncage, 'Value', 1);
    %state.spc.acq.uncageBox = 1;
elseif state.files.fileCounter == 26
    putsample(state.yphys.init.phys_patch, 0/state.yphys.acq.commandSensV);
    %set(gh.spc.FLIMimage.Uncage, 'Value', 0);
    %state.spc.acq.uncageBox = 0;
end