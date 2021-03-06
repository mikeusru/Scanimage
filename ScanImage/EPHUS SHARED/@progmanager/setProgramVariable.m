function setProgramVariable(obj, programId, variableName, variableValue)
% SETPROGRAMVARIABLE - @progmanager method that sets variables local to a specific program.
%
% SYNTAX
%     setProgramVariable(progmanager, programName, variableName, variableValue);
%     setProgramVariable(progmanager, hObject, variableName, variableValue);
%
% ARGUMENTS
%     progmanager - The progmanager object.
%     programName - The name of the program.
%     hObject - A progmanagerized graphics handle.
%     variableName - The variable to set.
%     variableValue - The value to which to set the variable
%            
% SEE ALSO setLocal, setGlobal, getProgramVariable
%
% Created: Timothy O'Connor 6/11/04
%
% Copyright - Cold Spring Harbor Laboratories/Howard Hughes Medical Institute 2004
global progmanagerglobal

if strcmpi(class(programId), 'char')
    programName = programId;
elseif ishandle(programId)
    uData = get(getParent(programId, 'figure'), 'UserData');
    if isempty(uData)
        error('@progmanager/setProgramVariable: user data not found in figure: %s', get(getParent(programId, 'figure'), 'Tag'));
    end

    programName = uData.progname;
else
    error('@progmanager/setProgramVariable: invalid program identifier.');
end

if ~isfield(progmanagerglobal.programs, programName)
    error('@progmanager/setProgramVariable: invalid program name - ''%s''.', programName);
end

progmanagerglobal.programs.(programName).variables.(variableName) = variableValue;

return;