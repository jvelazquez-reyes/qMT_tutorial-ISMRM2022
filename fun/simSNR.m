function [dataSim_SNR, dataRaw_SNR] = simSNR(SNR)
% Define qMT Model
Model = qmt_spgr;

% Input parameters
x = struct;
x.F = 0.16;
x.kr = 30;
x.R1f = 1;
x.R1r = 1;
x.T2f = 0.03;
x.T2r = 1.3e-05;

% Set simulation options
Opt.SNR = 50;
Opt.Method = 'Analytical equation';
Opt.ResetMz = false;

%% Vary SNR

for i=1:length(SNR)
     Opt.SNR = SNR(i);
     Smodel = equation(Model, x, Opt);
     data.MTdata = addNoise(Smodel, Opt.SNR, 'mt');
     [SimCurveResults,Protocol,data] = getSimResults(Model, x, Opt, data);
     dataSim_SNR(:,1,i) = SimCurveResults.Offsets;
     dataSim_SNR(:,2,i) = SimCurveResults.curve(:,1);
     dataSim_SNR(:,3,i) = SimCurveResults.curve(:,2);
     dataRaw_SNR(:,1,i) = Protocol.Offsets;
     dataRaw_SNR(:,2,i) = data.MTdata;
 end
 end