function RSKplotburstdata(RSK)
% plot burst data - needs time axis sorting

if isfield(RSK,'burstdata')==0
    disp('You must read a section of burst data in first!');
    disp('Use RSKreadburstdata...')
    return
end
numchannels = size(RSK.burstdata.values,2);

for n=1:numchannels
    subplot(numchannels,1,n)
    plot(RSK.burstdata.tstamp,RSK.burstdata.values(:,n),'-')
    title(RSK.channels(n).longName);
    ylabel(RSK.channels(n).units);
    ax(n)=gca;
    datetick('x')  % doesn't display the date if all data within one day :(
    
end
linkaxes(ax,'x')
shg