%Plots

close all
%training time and training error
aux_vec_percentages = 10:10:100;

%Including all sequences; hard to see ...
figure, plot(aux_vec_percentages,trainTime,'-o'), grid
hXLabel = xlabel('% training frames');
 hYLabel=  ylabel('Time (s)');
 hTitle = title('Training time');
 

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

figure, plot(aux_vec_percentages,BackgroundCompTr.SSIM,'-d'), grid

 hYLabel=  ylabel('SSIM');
 hTitle = title('Structural Similarity');
 

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

%... thus choosing some sequences
%Training time
figure, plot(aux_vec_percentages,trainTime(1,:),'-d','LineWidth',1.5)
 grid, hold on
 plot(aux_vec_percentages,trainTime(3,:),'-^','LineWidth',1.5)
 plot(aux_vec_percentages,trainTime(5,:),'-o','LineWidth',1.5)
 plot(aux_vec_percentages,trainTime(7,:),'-x','LineWidth',1.5)
  plot(aux_vec_percentages,trainTime(9,:),'-s','LineWidth',1.5)
hXLabel = xlabel('% training frames');
 hYLabel=  ylabel('Time (s)');
 hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
 hTitle = title('Training time');
 
set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

saveas(gcf,'TTime','epsc')

aux_vec = floor(0.01*0.8*aux_vec_percentages*300);
figure, plot(aux_vec,trainTime(1,:),'-d','LineWidth',1.5)
 grid, hold on

aux_vec = floor(0.01*0.8*aux_vec_percentages*525);
plot(aux_vec,trainTime(3,:),'-^','LineWidth',1.5)

aux_vec = floor(0.01*0.8*aux_vec_percentages*250);

plot(aux_vec,trainTime(5,:),'-o','LineWidth',1.5)

aux_vec = floor(0.01*0.8*aux_vec*300);

 plot(aux_vec,trainTime(7,:),'-x','LineWidth',1.5)

aux_vec = floor(0.01*0.8*aux_vec_percentages*450);
plot(aux_vec,trainTime(9,:),'-s','LineWidth',1.5)

hXLabel = xlabel('Number of frames');
 hYLabel=  ylabel('Time (s)');
 hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
 hTitle = title('Training time');
 
set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

saveas(gcf,'TTime2','epsc')


percentAux = 10:10:100;

figure, plot(percentAux,BackgroundCompTr.SSIM(1,:),'-d','LineWidth',1.5)
grid, hold on
plot(percentAux,BackgroundCompTr.SSIM(3,:),'-^','LineWidth',1.5)
plot(percentAux,BackgroundCompTr.SSIM(5,:),'-o','LineWidth',1.5)
plot(percentAux,BackgroundCompTr.SSIM(7,:),'-x','LineWidth',1.5)
plot(percentAux,BackgroundCompTr.SSIM(9,:),'-s','LineWidth',1.5)
hXLabel = xlabel('% training frames');
hYLabel=  ylabel('Structural Similarity Index (SSIM)');
%hLegend = legend('Simple Sequence','Camouflage','Illumination changes',...
%    'Moving background','Moving camera');
 hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
hTitle = title('SSIM');

set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );
saveas(gcf,'TrSSIM2','epsc')
 figure, plot(percentAux,BackgroundCompTr.PeakSNR(1,:),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,BackgroundCompTr.PeakSNR(3,:),'-^','LineWidth',1.5)
 plot(percentAux,BackgroundCompTr.PeakSNR(5,:),'-o','LineWidth',1.5)
 plot(percentAux,BackgroundCompTr.PeakSNR(7,:),'-x','LineWidth',1.5)
  plot(percentAux,BackgroundCompTr.PeakSNR(9,:),'-s','LineWidth',1.5)
 hXLabel = xlabel('% training frames');
 hYLabel=  ylabel('Peak Signal-to-Noise Ratio');
  hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
 hTitle = title('Peak SNR');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel,hTitle]  , ...
    'FontSize'   , 10          );
saveas(gcf,'TPSNR2','epsc')

 figure, plot(percentAux,BackgroundCompTr.MSE(1,:),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,BackgroundCompTr.MSE(3,:),'-^','LineWidth',1.5)
 plot(percentAux,BackgroundCompTr.MSE(5,:),'-o','LineWidth',1.5)
 plot(percentAux,BackgroundCompTr.MSE(7,:),'-x','LineWidth',1.5)
  plot(percentAux,BackgroundCompTr.MSE(9,:),'-s','LineWidth',1.5)
 hXLabel = xlabel('% training frames');
 hYLabel=  ylabel('Mean Squared Error');
  hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
 hTitle = title('MSE');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

saveas(gcf,'TMSE2','epsc')

%Moving and 'clean' frames
percentAux = 1:15;

SSIMMtx = [BackgroundComp.SSIM, BackgroundCompSNS.SSIM];
PSNRMtx = [BackgroundComp.PeakSNR, BackgroundCompSNS.PeakSNR];
MSEMtx = [BackgroundComp.MSE, BackgroundCompSNS.MSE];

figure, plot(percentAux,SSIMMtx(1,1:15),'-d','LineWidth',1.5)
grid, hold on
plot(percentAux,SSIMMtx(3,1:15),'-^','LineWidth',1.5)
plot(percentAux,SSIMMtx(5,1:15),'-o','LineWidth',1.5)
plot(percentAux,SSIMMtx(7,1:15),'-x','LineWidth',1.5)
plot(percentAux,SSIMMtx(9,1:15),'-s','LineWidth',1.5)
xticks([5 10]);
xticklabels({'Moving frames (50%)',' Adding clean frames'});
hXLabel = xlabel('Moving and clean frames');
hYLabel=  ylabel('Structural Similarity Index (SSIM)');
hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
hTitle = title('SSIM');

set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );
saveas(gcf,'SNS_SSIM','epsc')

 figure, plot(percentAux,PSNRMtx(1,1:15),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,PSNRMtx(3,1:15),'-^','LineWidth',1.5)
 plot(percentAux,PSNRMtx(5,1:15),'-o','LineWidth',1.5)
 plot(percentAux,PSNRMtx(7,1:15),'-x','LineWidth',1.5)
  plot(percentAux,PSNRMtx(9,1:15),'-s','LineWidth',1.5)
xticks([5 10]);
xticklabels({'Moving frames (50%)',' Adding clean frames'});
hXLabel = xlabel('Moving and clean frames');
hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
 hTitle = title('Peak SNR');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel,hTitle]  , ...
    'FontSize'   , 10          );
saveas(gcf,'SNS_PSNR','epsc')

 figure, plot(percentAux,MSEMtx(1,1:15),'-d','LineWidth',1.5)
 grid, hold on
 plot(percentAux,MSEMtx(3,1:15),'-^','LineWidth',1.5)
 plot(percentAux,MSEMtx(5,1:15),'-o','LineWidth',1.5)
 plot(percentAux,MSEMtx(7,1:15),'-x','LineWidth',1.5)
  plot(percentAux,MSEMtx(9,1:15),'-s','LineWidth',1.5)
 xticks([5 10]);
xticklabels({'Moving frames (50%)',' Adding clean frames'});
hXLabel = xlabel('Moving and clean frames');
 hYLabel=  ylabel('Mean Squared Error');
hLegend = legend('Simple Sequence 1','Camouflage 1','Occlusion 1',...
     'Illumination changes 1','Moving background 1');
 hTitle = title('MSE');
 
 set([hLegend, gca]             , ...
    'FontSize'   , 8           );

set([hXLabel, hYLabel, hTitle]  , ...
    'FontSize'   , 10          );

saveas(gcf,'SNS_MSE','epsc')

AuxTableVideoMeasures = [VideoCompTr.AvgLoss(:,end)';
    VideoCompTr.TNRVec(:,end)';
    VideoCompTr.RecallVec(:,end)';
    VideoCompTr.PrecisionVec(:,end)';
    VideoCompTr.F1Vec(:,end)'];

precision = 3;

AuxTableLatex = latex(vpa(sym(AuxTableVideoMeasures),precision));

AuxTestVideoMeasures = [VideoCompTt.AvgLoss(:,end)';
    VideoCompTt.TNRVec(:,end)';
    VideoCompTt.RecallVec(:,end)';
    VideoCompTt.PrecisionVec(:,end)';
    VideoCompTt.F1Vec(:,end)'];

AuxTableTest = latex(vpa(sym(AuxTestVideoMeasures),precision))

BSSIMTable = BackgroundComp.SSIM';

AuxTableSSIM = latex(vpa(sym(BSSIMTable),precision))

BSNRTable = BackgroundComp.PeakSNR';

AuxTableSNR = latex(vpa(sym(BSNRTable),precision))

BMSETable = BackgroundComp.MSE';

AuxTableMSE = latex(vpa(sym(BMSETable),precision))





