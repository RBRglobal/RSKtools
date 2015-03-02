function [RSK, dbid] = RSKopen(fname)

% RSKopen - Opens an RBR RSK file and reads metadata and thumbnails.
%
% Syntax:  [RSK, dbid] = RSKopen(fname)
% 
% RSKopen makes a connection to an RSK (sqlite format) database as
% obtained from an RBR logger and reads in the instrument metadata as
% well as a thumbnail of the stored data. RSKopen assumes only a
% single instrument deployment is contained in the RSK file. The
% thumbnail usually contains about 4000 points, and thus avoids
% reading large amounts of data that can be contained in the
% database. Each time value has a maximum and a minimum data value so
% that all spikes are visible even though the dataset is down-sampled.
%
% RSKopen requires a working mksqlite library. We have included a
% couple of versions here for Windows (32/64 bit), Linux (64 bit) and
% Mac (64 bit), but you might need to compile another version.  The
% mksqlite-src directory contains everything you need and some
% instructions from the original author.  You can also find the source
% through Google.
%
% Inputs:
%    fname - filename of the RSK file
%
% Outputs:
%    RSK - Structure containing the logger metadata and thumbnails
%    dbid - database id returned from mksqlite
%
% Example: 
%    RSK=RSKopen('sample.rsk');  
%
% See also: RSKplotthumbnail, RSKreaddata, RSKreadevents, RSKreadburstdata
%
% Author: RBR Global Inc. Ottawa ON, Canada
% email: support@rbr-global.com
% Website: http://www.rbr-global.com
% Last revision: 2015-02-27

if nargin==0
    fname=uigetfile({'*.rsk','*.RSK'},'Choose an RSK file');
end
if ~exist(fname,'file')
    disp('File cannot be found')
    RSK=[];dbid=[];
    return
end
dbid = mksqlite('open',fname);

RSK.dbInfo = mksqlite('select version from dbInfo');

RSK.datasets = mksqlite('select * from datasets');
RSK.datasetDeployments = mksqlite('select * from datasetDeployments');

try
    RSK.calibrations = mksqlite('select * from calibrations');
catch % ignore if there is an error, rsk files from an easyparse logger  do not contain calibrations
end

RSK.instruments = mksqlite('select * from instruments');
try
    RSK.instrumentChannels = mksqlite('select * from instrumentChannels');
catch
end
try
    RSK.instrumentSensors = mksqlite('select * from instrumentSensors');
catch % ignore if there is an error, rsk files from an easyparse logger do not contain instrument sensors table
end

RSK.channels = mksqlite('select longName,units from channels');

RSK.epochs = mksqlite('select deploymentID,startTime/1.0 as startTime, endTime/1.0 as endTime from epochs');
RSK.epochs.startTime = RSKtime2datenum(RSK.epochs.startTime);
RSK.epochs.endTime = RSKtime2datenum(RSK.epochs.endTime);

RSK.schedules = mksqlite('select * from schedules');


try
    RSK.appSettings = mksqlite('select * from appSettings');
catch
end
RSK.deployments = mksqlite('select * from deployments');

RSK.thumbnailData = RSKreadthumbnail;
