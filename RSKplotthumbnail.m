function RSKplotthumbnail(RSK)
% plot data - needs time axis sorting
numchannels = size(RSK.thumbnailData.values,2);

for n=1:numchannels
    subplot(numchannels,1,n)
    plot(RSK.thumbnailData.tstamp,RSK.thumbnailData.values(:,n),'-')
    title(RSK.channels(n).longName)
    datetick('x')
end
shg