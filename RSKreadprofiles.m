function RSK = RSKreadprofiles(RSK, profileNum, direction)

% RSKreadprofiles - Read individual profiles (e.g. upcast and
%                   downcast) from an rsk file.
%
% Syntax:  RSK = RSKreadprofiles(RSK, profileNum, direction)
% 
% Reads profiles, including up and down casts, from the events
% contained in an rsk file. The profiles are written as fields in a
% structure array, divided into upcast and downcast fields, which can
% be indexed individually.
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
%    profileNum - vector identifying the profile numbers to read. This
%          can be used to read only a subset of all the profiles.
%
%    direction - `up` for upcast, `down` for downcast, or `both` for
%          all. Default is `down`.
%
% Outputs:
%    RSK - RSK structure containing individual profiles
%
% Examples:
%
%    
%
% See also: RSKreaddata, RSKreadevents
%
% Author: RBR Global Inc. Ottawa ON, Canada
% email: support@rbr-global.com
% Website: http://www.rbr-global.com
% Last revision: 2015-10-05

if nargin == 1
    profileNum = 1:length(RSK.profiles.downcast.tstart); % default read all profiles
    direction = 'down'; % default read downcasts
elseif nargin == 2
    direction = 'down';
end
if isempty(profileNum) profileNum = 1:length(RSK.profiles.downcast.tstart); end
if isempty(direction) type = 'down'; end

nup = length(profileNum);
ndown = length(profileNum);
    
% initialize upcast and downcast structures
downcast.data(ndown).tstamp = [];
downcast.data(ndown).values = [];
downcast.istart = RSK.profiles.downcast.istart;
downcast.iend = RSK.profiles.downcast.iend;
downcast.tstart = RSK.profiles.downcast.tstart;
downcast.tend = RSK.profiles.downcast.tend;
upcast.data(nup).tstamp = [];
upcast.data(nup).values = [];
upcast.istart = RSK.profiles.upcast.istart;
upcast.iend = RSK.profiles.upcast.iend;
upcast.tstart = RSK.profiles.upcast.tstart;
upcast.tend = RSK.profiles.upcast.tend;

% loop through downcasts
ii = 1;
for i=profileNum
    tstart = RSK.profiles.downcast.tstart(i);
    tend = RSK.profiles.downcast.tend(i);
    tmp = RSKreaddata(RSK, tstart, tend);
    downcast.data(ii).tstamp = tmp.data.tstamp;
    downcast.data(ii).values = tmp.data.values;
    ii = ii + 1;
end

% loop through upcasts
ii = 1;
for i=profileNum
    tstart = RSK.profiles.upcast.tstart(i);
    tend = RSK.profiles.upcast.tend(i);
    tmp = RSKreaddata(RSK, tstart, tend);
    upcast.data(ii).tstamp = tmp.data.tstamp;
    upcast.data(ii).values = tmp.data.values;
    ii = ii + 1;
end

if strcmp(direction, 'both')
    RSK.profiles.upcast = upcast;
    RSK.profiles.downcast = downcast;
elseif strcmp(direction, 'down')
    RSK.profiles.downcast = downcast;
elseif strcmp(direction, 'up')
    RSK.profiles.upcast = upcast;
end
