
clear all; 

%% ESTIMATION SCRIPT: 
% Estimation 
% Simulation 
% forecast of ARIMA with exogeneous covariates. 

%%
load('Data.mat');
ME = Monetary_Event; 
PC = Press_Conference; 
PR = Press_Release; 


%% Scatters Press Release vs Press Conference

t1 = 1; 
t2 = 198; % end
figure; 
subplot(1,2,1); 
scatter3(PR.ES2Y, PR.ES5Y, PC.ES2Y);
xlabel('Press Release ES2Y'); ylabel('Press Release ES5Y'); zlabel('Press Conference ES2Y'); 
title('Press Conference ES2Y')
subplot(1,2,2); 
scatter3(PR.DE10Y, PR.ES5Y, PC.ES10Y); 
xlabel('Press Release DE10Y'); ylabel('Press Release ES5Y'); zlabel('Press Conference ES10Y'); 
title('Press conference ES10Y')
%xlim([-4 4]); ylim([-10 10]); 


%% Dynamic Models Matlab: 
n  = 170; 
nf = 198-n; 
t = Press_Conference.date; 

XES2Y  = [PR.ES2Y,PR.ES5Y,PR.ES10Y,PR.DE10Y]; 
XES5Y  = [PR.ES2Y,PR.ES5Y,PR.ES10Y,PR.DE10Y]; 
XES10Y = [PR.ES2Y,PR.ES5Y,PR.ES10Y,PR.DE10Y];
model = arima('AR',0,'MA',0); 

% ES2Y
M_ES2Y    = estimate(model, [PC.ES2Y(1:n)] , 'X',[XES2Y(1:n,:)]); 
Fit1      = (M_ES2Y.Beta*XES2Y(1:n,:)')'; 
forecast1 = (M_ES2Y.Beta*XES2Y(n+1:end,:)')';

% ES5Y
M_ES5Y    = estimate(model, [PC.ES5Y(1:n)] , 'X',[XES5Y(1:n,:)]); 
Fit2      = (M_ES5Y.Beta*XES5Y(1:n,:)')';
Forecast2 = (M_ES5Y.Beta*XES5Y(n+1:end,:)')';
%ES10Y
M_ES10Y   = estimate(model, [PC.ES10Y(1:n)] , 'X',[XES10Y(1:n,:)]); 
Fit3      = (M_ES10Y.Beta*XES10Y(1:n,:)')';
Forecast3 = (M_ES10Y.Beta*XES10Y(n+1:end,:)')';

%% Plots: 
figure; 
subplot(1,2,1); 
plot(t(1:n),Fit1,'r', 'LineWidt', 2.5); hold on; 
plot(t(1:n), PC.ES2Y(1:n), 'b', 'LineWidt', 0.75);
title('Fit ES2Y Press Conference'); 
ylabel('ES2Y % change Press Conference'); 
legend('Fit ES2Y', 'ES2Y'); 
subplot(1,2,2); 
plot(t(n+1:end), forecast1,'r', 'LineWidt', 2.5); hold on; 
plot(t(n+1:end), PC.ES2Y(n+1:end), 'b', 'LineWidt', 0.75); 
title('Forecast ES2Y Press Conference');
legend('Forecast ES2Y', 'ES2Y'); 


figure; 
subplot(1,2,1); 
plot(t(1:n),Fit2,'r', 'LineWidt', 2.5); hold on; 
plot(t(1:n), PC.ES5Y(1:n), 'b', 'LineWidt', 0.75);
title('Fit ES5Y Press Conference'); 
ylabel('ES5Y % change Press Conference');
legend('Fit ES5Y', 'ES5Y');
subplot(1,2,2); 
plot(t(n+1:end), Forecast2,'r', 'LineWidt', 2.5); hold on; 
plot(t(n+1:end), PC.ES5Y(n+1:end), 'b', 'LineWidt', 0.75); 
title('Forecast ES5Y Press Conference'); 
legend('Forecast ES5Y', 'ES5Y'); 

figure; 
subplot(1,2,1); 
plot(t(1:n),Fit3,'r', 'LineWidt', 2.5); hold on; 
plot(t(1:n), PC.ES10Y(1:n), 'b', 'LineWidt', 0.75);
title('Fit ES10Y Press Conference'); 
ylabel('ES10Y % change Press Conference'); 
legend('Fit ES10Y', 'ES10Y'); 
subplot(1,2,2); 
plot(t(n+1:end), Forecast3,'r', 'LineWidt', 2.5); hold on; 
plot(t(n+1:end), PC.ES10Y(n+1:end), 'b', 'LineWidt', 0.75); 
title('Forecast ES10Y Press Conference'); 
legend('Forecast ES10Y', 'ES10Y'); 













