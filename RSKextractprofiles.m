function RSK = RSKextractprofiles(RSK)

% RSKextractprofiles - Extract individual profiles (e.g. upcast and
%                   downcast) from an rsk file.
%
% Syntax:  RSK = RSKextractprofiles(RSK)
% 
% Extracts profiles, including up and down casts, from the events
% contained in an rsk file. The profiles are written as fields in a
% structure array, divided into upcast and downcast fields, which can
% be indexed individually.
%
% For the casts to be extracted, RSKreadevents must have been called
% to read the events table into the RSK structure.
% 
% The profile events are parsed from the events table using the following types:
%   33 - Begin upcast
%   34 - Begin downcast
%   35 - End of profile cast
%
% Currently the function assumes that upcasts and downcasts come in
% pairs, as would be recorded by a continuously recording
% logger. Future versions may be better at parsing more complicated
% deployments, such as thresholds or scheduled profiles.
% 
% Inputs: 
%    RSK - Structure containing the logger data read
%                     from the RSK file.
%
% Outputs:
%    RSK - RSK structure containing individual profiles
%
% See also: RSKreaddata, RSKreadevents
%
% Author: RBR Global Inc. Ottawa ON, Canada
% email: support@rbr-global.com
% Website: http://www.rbr-global.com
% Last revision: 2015-10-05

nup = length(find(RSK.events.values(:,2) == 33));
ndown = length(find(RSK.events.values(:,2) == 34));

iup = find(RSK.events.values(:,2) == 33);
idown = find(RSK.events.values(:,2) == 34);
iend = find(RSK.events.values(:,2) == 35);

% which is first?
if (idown < iup) 
    idownend = iend(1:2:end);
    iupend = iend(2:2:end);
else
    idownend = iend(2:2:end);
    iupend = iend(1:2:end);
end

% initialize upcast and downcast structures
downcast(ndown).tstamp = [];
downcast(ndown).values = [];
upcast(nup).tstamp = [];
upcast(nup).values = [];

% loop through downcasts
for i=1:ndown
    istart = RSK.events.values(idown(i), 3);
    iend = RSK.events.values(idownend(i), 3);
    downcast(i).tstamp = RSK.data.tstamp(istart:iend);
    downcast(i).values = RSK.data.values(istart:iend,:);
end

% loop through upcasts
for i=1:nup
    istart = RSK.events.values(iup(i), 3);
    iend = RSK.events.values(iupend(i), 3);
    upcast(i).tstamp = RSK.data.tstamp(istart:iend);
    upcast(i).values = RSK.data.values(istart:iend,:);
end

RSK.profiles.upcast = upcast;
RSK.profiles.downcast = downcast;