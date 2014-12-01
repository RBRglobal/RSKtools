function RSKplotdata(RSK)
% plot data - needs time axis sorting

if isfield(RSK,'data')==0
    disp('You must read a section of data in first!');
    disp('Use RSKreaddata...')
    return
end
numchannels = size(RSK.data.values,2);

for n=1:numchannels
    subplot(numchannels,1,n)
    plot(RSK.data.tstamp,RSK.data.values(:,n),'-')
    title(RSK.channels(n).longName);
    ylabel(RSK.channels(n).units);
    ax(n)=gca;
    datetick('x')  % doesn't display the date if all data within one day :(
    
end
linkaxes(ax,'x')
shg