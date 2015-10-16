useOdor = 14;
idxTrial = 5;
idxPair = 3;
% A(1,:) = zscore(squeeze(lfpThetaTrials(idxTrial,from*1000:to*1000,useOdor)));
% A(2,:) = zscore(downsample(squeeze(breath(idxTrial,from*20000:to*20000,useOdor)),20));

% z = spikeDensity(shankNowarp(4).cell(3).odor(useOdor).spikeMatrixNoWarp(idxTrial,:),0.02);


%A(1,:) = -(squeeze(lfpTrials(idxTrial,from*1000:to*1000,useOdor)));
A(1,:) = -downsample(squeeze(breath(idxTrial,from*20000:to*20000,useOdor)),20);
A(2,:) = spikesPSTHs{idxOdor}(idxPair,from*1000:to*1000,idxTrial);
%A(2,:) = z(from*1000:to*1000);


% function s=semblance(t,y1,y2,nscales)


y1 = A(1,:);
y2 = A(2,:);
t = 1:6001;
nscales=500;


y1(isnan(y1))=0; y2(isnan(y2))=0;
m1=mean(y1(:)); m2=mean(y2(:)); y1=y1-m1; y2=y2-m2; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 
c2=cwt(y2,1:nscales,'cmor1-1'); 
ctc=c1.*conj(c2);                  % Cross wavelet transform amplitude
spt=atan2(imag(ctc),real(ctc));
s=cos(spt);                        % Semblance

% Display results

figure;
currfig=get(0,'CurrentFigure'); set(currfig,'numbertitle','off');
set(gcf,'Position',[51 102 1277 703]);
set(currfig,'name','Wavelet Semblance Analysis'); 
y1=y1+m1; y2=y2+m2;
subplot(5,1,1); plot(t,y1); axis tight; title('Data 1'); 
subplot(5,1,2); imagesc(real(c1)); axis xy; axis tight; title('CWT'); ylabel('Wavelength'); ylim([70 nscales]);
subplot(5,1,3); plot(t,y2); axis tight; title('Data 2'); 
subplot(5,1,4); imagesc(real(c2)); axis xy; axis tight; title('CWT'); ylabel('Wavelength');ylim([70 nscales]);
subplot(5,1,5); imagesc(s,[-1 1]); axis xy; axis tight; title('Semblance'); ylabel('Wavelength'); ylim([70 nscales]);
%colormap(jet(256));
    