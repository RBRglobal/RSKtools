function RSKplotprofiles(RSK, profileNum, field, direction)

% RSKprofiles - 
%
% Syntax:  RSK = RSKplotprofiles(RSK, direction, field, profileNum)
% 
% Plots profiles from automatically detected casts. If called with one
% argument, will default to plotting downcasts of temperature for all
% profiles in the structure.
%
% Inputs: 
%    RSK - Structure containing the logger data read
%          from the RSK file.
% 
%    profileNum - optional profile number to plot. Default plots all
%          detected profiles
%
%    field - named field to plot (e.g. temperature, salinity, etc)
%
%    direction - `up` for upcast, `down` for downcast, or `both` for
%          all. Default is `both
%
% See also: RSKextractprofiles, RSKreaddata, RSKreadevents
%
% Author: RBR Global Inc. Ottawa ON, Canada
% email: support@rbr-global.com
% Website: http://www.rbr-global.com
% Last revision: 2015-10-05

if nargin == 1
    profileNum = 1:min([length(RSK.profiles.upcast) length(RSK.profiles.downcast)]);
    field = 'temperature';
    direction = 'downcast';
elseif nargin == 2
    field = 'temperature';
    direction = 'downcast';
elseif nargin == 3
    direction = 'downcast';
end
if isempty(direction) direction = 'downcast'; end
if isempty(field) field = 'temperature'; end
if isempty(profileNum) profileNum = 1:min([length(RSK.profiles.upcast) length(RSK.profiles.downcast)]); end

% find column number of field
pcol = find(strncmp('pressure', lower({RSK.channels.longName}), 6));
col = find(strncmp(field, lower({RSK.channels.longName}), 6));

clf
hold on
pmax = 0;
if strcmp(direction, 'upcast') | strcmp(direction, 'both')
    for i=profileNum
        p = RSK.profiles.upcast(i).values(:, pcol) - 10.1325; % FIXME: should read pAtm from rskfile
        plot(RSK.profiles.upcast(i).values(:, col), p)
        pmax = max([pmax; p]);
    end
end
if strcmp(direction, 'downcast') | strcmp(direction, 'both')
    for i=profileNum
        p = RSK.profiles.downcast(i).values(:, pcol) - 10.1325; % FIXME: should read pAtm from rskfile
        plot(RSK.profiles.downcast(i).values(:, col), p)
        pmax = max([pmax; p]);
    end
end
hold off
grid

xlab = [RSK.channels(col).longName ' [' RSK.channels(col).units, ']'];
ylim([0 pmax])
set(gca, 'ydir', 'reverse')
ylabel('Sea pressure [dbar]')
xlabel(xlab)