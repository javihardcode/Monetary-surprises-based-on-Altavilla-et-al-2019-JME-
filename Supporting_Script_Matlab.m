
clear all;


%% Supporting Matlab Script for Econometrics II
%
% This script is intended to provide software support to the Final Paper
% for econometrics II. Matlab helps drawing figures and maybe estimating
% some models that are dificult to write in R. 


%% Load data: 
load('DATA.mat'); 

%% Figure 2 Paper:
% Figure: Press Release vs Press Conference on the same figure: 
% Vars  : 2, 5, and 10 years spanish bonds

figure; 
subplot(1,3,1);
plot(Press_Release.date,Press_Release.ES2Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.ES2Y, 'b' ); hold off; 
title('2 Years Spanish Bonds');
ylim([-15 30]); 

subplot(1,3,2);
plot(Press_Release.date,Press_Release.ES5Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.ES5Y, 'b' ); hold off;
title('5 Years Spanish Bonds');
ylim([-15 30]); 

subplot(1,3,3);
plot(Press_Release.date,Press_Release.ES10Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.ES10Y, 'b' ); 
title('10 Years Spanish Bonds');
ylim([-15 30]); 
legend('Press Release', 'Press Conference')


%% Does Figure 2 hold true for other variables? 
close all; 

% Doesnt hold for the stockxx50
plot(Press_Release.date,Press_Release.STOXX50); hold on; 
plot(Press_Conference.date,Press_Conference.STOXX50); 
legend('release', 'Conference')

close all;
% Holds for the exchange rate Euro-Dollar
plot(Press_Release.date,Press_Release.EURUSD); hold on; 
plot(Press_Conference.date,Press_Conference.EURUSD); 
legend('release', 'Conference')

close all; 
% Holds for France
figure; 
subplot(1,3,1);
plot(Press_Release.date,Press_Release.FR2Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.FR2Y, 'b' ); hold off; 
ylim([-15 30]); 

subplot(1,3,2);
plot(Press_Release.date,Press_Release.FR5Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.FR5Y, 'b' ); hold off;

ylim([-15 30]); 

subplot(1,3,3);
plot(Press_Release.date,Press_Release.FR10Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.FR10Y, 'b' ); 

ylim([-15 30]); 
legend('Press Release', 'Press Conference')

close all; 

% Holds for Italy but Press Release information is more volatile than for
% other countries. 
figure; 
subplot(1,3,1);
plot(Press_Release.date,Press_Release.IT2Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.IT2Y, 'b' ); hold off; 
ylim([-15 30]); 

subplot(1,3,2);
plot(Press_Release.date,Press_Release.IT5Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.IT5Y, 'b' ); hold off;

ylim([-15 30]); 

subplot(1,3,3);
plot(Press_Release.date,Press_Release.IT10Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.IT10Y, 'b' ); 

ylim([-15 30]); 
legend('Press Release', 'Press Conference'); 


close all; 
% Holds for Germany. This country has their higuer fluctuations before
% 2008. 
figure; 
subplot(1,3,1);
plot(Press_Release.date,Press_Release.DE2Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.DE2Y, 'b' ); hold off; 
ylim([-15 30]); 

subplot(1,3,2);
plot(Press_Release.date,Press_Release.DE5Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.DE5Y, 'b' ); hold off;

ylim([-15 30]); 

subplot(1,3,3);
plot(Press_Release.date,Press_Release.DE10Y, 'r'); hold on; 
plot(Press_Conference.date,Press_Conference.DE10Y, 'b' ); 

ylim([-15 30]); 
legend('Press Release', 'Press Conference')



%% Statistical Analysis: 
% 1) ACF & PACF ES 2, 5 and 10 years, three windows: 
% 2) ACF & PACF 0IS_5W, STOXXX50 and EURUSD, three windows:
% 3) ECF & PACF ES_2 years Press Conference, Figure 3 in the paper. 
%% 1) ACF & PACF ES 2, 5 and 10 years, three windows:   
figure; 
subplot(2,3,1); 
autocorr(Press_Release.ES2Y); 
title('Spanish 2 years Bonds'); 
subplot(2,3,2); 
autocorr(Press_Release.ES5Y);
title('Spanish 5 years Bonds'); 
subplot(2,3,3); 
autocorr(Press_Release.ES10Y);
title('Spanish 10 years Bonds'); 

subplot(2,3,4); 
parcorr(Press_Release.ES2Y); title(''); 
subplot(2,3,5); 
parcorr(Press_Release.ES5Y); title(''); 
subplot(2,3,6); 
parcorr(Press_Release.ES10Y); title(''); 


% ACF & PACF Conference: ES2Y, ES5Y ES10Y: 
figure; 
subplot(2,3,1); 
autocorr(Press_Conference.ES2Y); 
title('Spanish 2 years Bonds'); 
subplot(2,3,2); 
autocorr(Press_Conference.ES5Y);
title('Spanish 5 years Bonds'); 
subplot(2,3,3); 
autocorr(Press_Conference.ES10Y);
title('Spanish 10 years Bonds'); 

subplot(2,3,4); 
parcorr(Press_Conference.ES2Y); title(''); 
subplot(2,3,5); 
parcorr(Press_Conference.ES5Y); title(''); 
subplot(2,3,6); 
parcorr(Press_Conference.ES10Y); title(''); 


% ACF & PACF Monetary Event: ES2Y, ES5Y ES10Y: 
figure; 
subplot(2,3,1); 
autocorr(Monetary_Event.ES2Y); 
title('Spanish 2 years Bonds'); 
subplot(2,3,2); 
autocorr(Monetary_Event.ES5Y);
title('Spanish 5 years Bonds'); 
subplot(2,3,3); 
autocorr(Monetary_Event.ES10Y);
title('Spanish 10 years Bonds'); 

subplot(2,3,4); 
parcorr(Monetary_Event.ES2Y); title(''); 
subplot(2,3,5); 
parcorr(Monetary_Event.ES5Y); title(''); 
subplot(2,3,6); 
parcorr(Monetary_Event.ES10Y); title(''); 


%% 2) ACF & PACF 0IS_5W, STOXXX50 and EURUSD, three windows: 
close all; 

% Press Release:  
figure; 
subplot(2,3,1); 
autocorr(Press_Release.OIS_SW); 
title('Week OIS '); 
subplot(2,3,2); 
autocorr(Press_Release.STOXX50);
title('STOXX 50 Index'); 
subplot(2,3,3); 
autocorr(Press_Release.EURUSD);
title('Euro-Dollar Exchange rate'); 

subplot(2,3,4); 
parcorr(Press_Release.OIS_SW); title(''); 
subplot(2,3,5); 
parcorr(Press_Release.STOXX50); title(''); 
subplot(2,3,6); 
parcorr(Press_Release.EURUSD); title(''); 

% Press Conference: 
figure; 
subplot(2,3,1); 
autocorr(Press_Conference.OIS_SW); 
title('Week OIS '); 
subplot(2,3,2); 
autocorr(Press_Conference.STOXX50);
title('STOXX 50 Index'); 
subplot(2,3,3); 
autocorr(Press_Conference.EURUSD);
title('Euro-Dollar Exchange rate'); 

subplot(2,3,4); 
parcorr(Press_Conference.OIS_SW); title(''); 
subplot(2,3,5); 
parcorr(Press_Conference.STOXX50); title(''); 
subplot(2,3,6); 
parcorr(Press_Conference.EURUSD); title(''); 

% Monetary Event: 
figure; 
subplot(2,3,1); 
autocorr(Monetary_Event.OIS_SW); 
title('Week OIS '); 
subplot(2,3,2); 
autocorr(Monetary_Event.STOXX50);
title('STOXX 50 Index'); 
subplot(2,3,3); 
autocorr(Monetary_Event.EURUSD);
title('Euro-Dollar Exchange rate'); 

subplot(2,3,4); 
parcorr(Monetary_Event.OIS_SW); title(''); 
subplot(2,3,5); 
parcorr(Monetary_Event.STOXX50); title(''); 
subplot(2,3,6); 
parcorr(Monetary_Event.EURUSD); title(''); 


%% 3) ECF & PACF ES_2 years Press Conference, Figure 3 in the paper. 
close all; 
figure; 
subplot(1,2,1); 
autocorr(Press_Conference.ES2Y); title('Spanish 2 Years Bonds'); 

subplot(1,2,2); 
parcorr(Press_Conference.ES2Y); title('Spanish 2 Years Bonds'); 


%% Kernel Density
% This section estimates Kernel Densities in at leas two ways: 
% 1) PR vs PC : shows differences in volatility across each anouncement
% window for a given variable
% 2) Time: shows how obe variable have changes kn volatility over time. 

%% 1) PR VS PC ES 2, 5 10: 
% ES2Y
[f1,x1]=ksdensity(Press_Release.ES2Y);  
[f2,x2]=ksdensity(Press_Conference.ES2Y);

% ES5Y
[f3,x3]=ksdensity(Press_Release.ES5Y);  
[f4,x4]=ksdensity(Press_Conference.ES5Y);

% ES10Y: 
[f5,x5]=ksdensity(Press_Release.ES10Y);  
[f6,x6]=ksdensity(Press_Conference.ES10Y);


% Subplot: 
figure; 
subplot(1,3,1); 
plot(x1,f1, 'r', 'LineWidth', 3); hold on; 
plot(x2,f2, 'b', 'LineWidth', 3); 
legend('Press Release', 'Press Conference'); 
title('Kernel Density ES2Y Release vs Conference'); 
hold off; 

subplot(1,3,2); 
plot(x3,f3, 'r', 'LineWidth', 3); hold on; 
plot(x4,f4, 'b', 'LineWidth', 3)
legend('Press Release', 'Press Conference'); 
title('Kernel Density ES5Y Release vs Conference'); 
hold off; 

subplot(1,3,3); 
plot(x5,f5, 'r', 'LineWidth', 3); hold on; 
plot(x6,f6, 'b', 'LineWidth', 3)
legend('Press Release', 'Press Conference'); 
title('Kernel Density ES10Y Release vs Conference'); 
hold off; 
clearvars x1 x2 x3 x4 x5 x5 x6 f1 f2 f3 f4 f5 f6 ; 

%% Kdensity period 2000-2008 vs 2008-2020: Press Conference
% ES2Y
[f1,x1] = ksdensity(Press_Conference.ES2Y(1:71)); 
[f2,x2] = ksdensity(Press_Conference.ES2Y(72:end)); 

% ES5Y
[f3,x3] = ksdensity(Press_Conference.ES5Y(1:71)); 
[f4,x4] = ksdensity(Press_Conference.ES5Y(72:end)); 

% ES10Y
[f5,x5] = ksdensity(Press_Conference.ES10Y(1:71)); 
[f6,x6] = ksdensity(Press_Conference.ES10Y(72:end)); 

% Subplot
figure; 
subplot(1,3,1); 
plot(x1,f1, 'b', 'LineWidth', 3); hold on; 
plot(x2,f2, 'r', 'LineWidth', 3); hold off; 
legend('2002-2008', '2008-2020'); 
title('Kernel Density ES2Y'); 

subplot(1,3,2); 
plot(x3,f3, 'b', 'LineWidth', 3); hold on; 
plot(x4,f4, 'r', 'LineWidth', 3); hold off; 
legend('2002-2008', '2008-2020'); 
title('Kernel Density ES10Y'); 

subplot(1,3,3); 
plot(x5,f5, 'b', 'LineWidth', 3); hold on; 
plot(x6,f6, 'r', 'LineWidth', 3); hold off; 
legend('2002-2008', '2008-2020'); 
title('Kernel Density ES10Y'); 

clearvars x1 x2 x3 x4 x5 x5 x6 f1 f2 f3 f4 f5 f6 ;


%% ACF and PACF square ES2Y PC: 
close all; 
% Demeaning: 
Press_Conference.ES2Y = Press_Conference.ES2Y-mean(Press_Conference.ES2Y);
Press_Conference.ES5Y = Press_Conference.ES5Y-mean(Press_Conference.ES5Y);
Press_Conference.ES10Y = Press_Conference.ES10Y-mean(Press_Conference.ES10Y);

Press_Release.ES2Y = Press_Release.ES2Y-mean(Press_Release.ES2Y);
Press_Release.ES5Y = Press_Release.ES5Y-mean(Press_Release.ES5Y);
Press_Release.ES10Y = Press_Release.ES10Y-mean(Press_Release.ES10Y);
figure; 
subplot(1,2,1); 
autocorr((Press_Conference.ES2Y).^2); title('ACF ES2Y Bonds Press Conference');
subplot(1,2,2); 
parcorr((Press_Conference.ES2Y).^2); title('PACF ES2Y Bonds Press Conference'); 

%%%% FOR THE APPENDIX:
figure; 
subplot(2,4,1);
autocorr((Press_Release.ES5Y).^2); title('ES5Y Press Release'); 
subplot(2,4,2);
autocorr((Press_Conference.ES5Y).^2); title('ES5Y Press Conference');
subplot(2,4,3);
autocorr((Press_Release.ES10Y).^2); title('ES10Y Press Release'); 
subplot(2,4,4);
autocorr((Press_Conference.ES10Y).^2); title('ES10Y Press Conference');

subplot(2,4,5);
parcorr((Press_Release.ES5Y).^2); title('ES5Y Press Release'); 
subplot(2,4,6);
parcorr((Press_Conference.ES5Y).^2); title('ES5Y Press Conference');
subplot(2,4,7);
parcorr((Press_Release.ES10Y).^2); title('ES10Y Press Release'); 
subplot(2,4,8);
parcorr((Press_Conference.ES10Y).^2); title('ES10Y Press Conference');


%% Fitting some models: 
close all; 

% ES2Y: 
% GARCH(1,1) 
model1 = estimate(garch(1,1),[Press_Release.ES5Y]); 
V1 = simulate(model1,198,'NumPaths',500); 

% ARIMA(1,0,1)
model2 = estimate(arima(4,0,4),[Press_Release.ES5Y] ); 




%model2 = estimate(garch(1,1),[Press_Release.ES5Y]);
%model2 = estimate(garch(1,1),[Press_Release.ES10Y]);

%summarize(model1); 




% VAR: 
%model22 = estimate(varm(2,3),[Press_Release.ES2Y, Press_Conference.ES2Y]); 
%summarize(model22); 












