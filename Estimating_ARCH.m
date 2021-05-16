

clear all; 

%% ESTIMATION SCRIPT: 
% This script contains estimation rountine for models in the Final Paper: 

%%
load('Data.mat'); 

%% De-meaning: Just a regularity
% Spain
Monetary_Event.ES2Y = Monetary_Event.ES2Y-mean(Monetary_Event.ES2Y); 
Monetary_Event.ES5Y = Monetary_Event.ES5Y-mean(Monetary_Event.ES5Y); 
Monetary_Event.ES10Y = Monetary_Event.ES10Y-mean(Monetary_Event.ES10Y); 

Press_Release.ES2Y = Press_Release.ES2Y-mean(Press_Release.ES2Y); 
Press_Release.ES5Y = Press_Release.ES5Y-mean(Press_Release.ES5Y); 
Press_Release.ES10Y = Press_Release.ES10Y-mean(Press_Release.ES10Y);

Press_Conference.ES2Y = Press_Conference.ES2Y-mean(Press_Conference.ES2Y); 
Press_Conference.ES5Y = Press_Conference.ES5Y-mean(Press_Conference.ES5Y); 
Press_Conference.ES10Y = Press_Conference.ES10Y-mean(Press_Conference.ES10Y);

% Germany
Monetary_Event.DE2Y = Monetary_Event.DE2Y-mean(Monetary_Event.DE2Y); 
Monetary_Event.DE5Y = Monetary_Event.DE5Y-mean(Monetary_Event.DE5Y); 
Monetary_Event.DE10Y = Monetary_Event.DE10Y-mean(Monetary_Event.DE10Y);

Press_Conference.DE2Y = Press_Conference.DE2Y-mean(Press_Conference.DE2Y); 
Press_Conference.DE5Y = Press_Conference.DE5Y-mean(Press_Conference.DE5Y); 
Press_Conference.DE10Y = Press_Conference.DE10Y-mean(Press_Conference.DE10Y);

% OIS_SW
Monetary_Event.OIS_SW = Monetary_Event.OIS_SW-mean(Monetary_Event.OIS_SW); 
Press_Conference.OIS_SW = Press_Conference.OIS_SW-mean(Press_Conference.OIS_SW); 

% STOXX50
Monetary_Event.STOXX50 = Monetary_Event.STOXX50-mean(Monetary_Event.STOXX50); 
Press_Conference.STOXX50 = Press_Conference.STOXX50-mean(Press_Conference.STOXX50); 

% EURUSD
Monetary_Event.EURUSD = Monetary_Event.EURUSD-mean(Monetary_Event.EURUSD); 
Press_Conference.EURUSD = Press_Conference.EURUSD-mean(Press_Conference.EURUSD);



%% ARCH TEST:
for i = 1:1:4
   % Press Conference: 
    [h,pES2,fStat,crit] = archtest(Press_Conference.ES2Y,'Lags',i);
    [h,pES5,fStat,crit] = archtest(Press_Conference.ES5Y,'Lags',i);
    [h,pES10,fStat,crit] = archtest(Press_Conference.ES10Y,'Lags',i);
    
    [h,pDE2,fStat,crit] = archtest(Press_Conference.DE2Y,'Lags',i);
    [h,pDE5,fStat,crit] = archtest(Press_Conference.DE5Y,'Lags',i);
    [h,pDE10,fStat,crit] = archtest(Press_Conference.DE10Y,'Lags',i);
    
    [h,pOIS,fStat,crit] = archtest(Press_Conference.OIS_SW,'Lags',i);
    [h,pSTOXX,fStat,crit] = archtest(Press_Conference.STOXX50,'Lags',i);
    [h,pEURUSD,fStat,crit] = archtest(Press_Conference.EURUSD,'Lags',i);
    
    p_valuePC(:,i) = [pES2 ; pES5; pES10; pDE2; pDE5; pDE10; pOIS; pSTOXX; pEURUSD ] ; 
    
    % Monetary Event: 
    [h,pES2,fStat,crit] = archtest(Monetary_Event.ES2Y,'Lags',i);
    [h,pES5,fStat,crit] = archtest(Monetary_Event.ES5Y,'Lags',i);
    [h,pES10,fStat,crit] = archtest(Monetary_Event.ES10Y,'Lags',i);
    
    [h,pDE2,fStat,crit] = archtest(Monetary_Event.DE2Y,'Lags',i);
    [h,pDE5,fStat,crit] = archtest(Monetary_Event.DE5Y,'Lags',i);
    [h,pDE10,fStat,crit] = archtest(Monetary_Event.DE10Y,'Lags',i);
    
    [h,pOIS,fStat,crit] = archtest(Monetary_Event.OIS_SW,'Lags',i);
    [h,pSTOXX,fStat,crit] = archtest(Monetary_Event.STOXX50,'Lags',i);
    [h,pEURUSD,fStat,crit] = archtest(Monetary_Event.EURUSD,'Lags',i);
    
    p_valueME(:,i) = [pES2 ; pES5; pES10; pDE2; pDE5; pDE10; pOIS; pSTOXX; pEURUSD ]; 
    
end 


%% Spanish 2-years Bonds Press Conference: 
rng default;          % Reproductability in simulations 
n = 198;              % Number of observation used %198-150 =  number of out-of-sample observations for forecast
npaths=50;            % Number of paths simulated
                      
t = Press_Conference.date(1:n);  % Periods


% ES2Y Press Conference GARCH(1,1)
ES2Ypr_garch01 = estimate(garch(0,1), [Press_Conference.ES2Y(1:n)]);

[V1,Y1] = simulate(ES2Ypr_garch01,n,'NumPaths',50); 

% Plot Simulated conditionalo variance and compare to original data: 
VES2Ybar = mean(V1,2);
VES2YCI  = quantile(V1,[0.025 0.975],2);
YES2Ybar = mean(Y1,2);
YES2YCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(1,2,1); 
h1 = plot(t, Press_Conference.ES2Y(1:n).^2,'color',0.8*ones(1,3), 'LineWidth',2); hold on; 
h2 = plot(t,VES2Ybar, 'k--','LineWidt',2); 
h3 = plot(t,VES2YCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Quantiles'); 
legend('\epsilon^2_t', 'Mean of simulated variances', 'Simulated quantiles 2.5 and 97.5%')

subplot(1,2,2); 
h1 = plot(t,Press_Conference.ES2Y(1:n),'color',0.8*ones(1,3), 'LineWidth',2); hold on; 
h2 = plot(t,YES2Ybar,'k--','LineWidth',2); 
h3 = plot(t,YES2YCI,'r--','LineWidth',2); 
title('Press Conference ES2Y vs simulated mean and Quantiles'); 
legend('\epsilon_t', 'Mean of simulated Deviations', 'Simulated Quantiles 2.5 and 97.5%')



%% Spanish 2-years Bonds Monetary Event: 

% ES2Y Press Conference GARCH(0,1)
ES2Yme_garch01 = estimate(garch(1,1), [Monetary_Event.ES2Y(1:n)]);

[V1,Y1] = simulate(ES2Yme_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VES2Ymebar = mean(V1,2);
VES2YmeCI  = quantile(V1,[0.025 0.975],2);
YES2Ymebar = mean(Y1,2);
YES2YmeCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Monetary_Event.ES2Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VES2Ymebar, 'k--','LineWidt',2); 
h3 = plot(t,VES2YmeCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Monetary_Event.ES2Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YES2Ymebar,'k--','LineWidth',2); 
h3 = plot(t,YES2YmeCI,'r--','LineWidth',2); 
title('Monetary Event ES2Y vs simulated mean and 95% Confidence Interval '); 

 
%% Spanish 5-years Bonds Press Conference: 

% ES2Y Press Conference GARCH(1,1)
ES5Ypc_garch01 = estimate(garch(1,1), [Press_Conference.ES5Y(1:n)]);

[V1,Y1] = simulate(ES5Ypc_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VES5Ypcbar = mean(V1,2);
VES5YpcCI  = quantile(V1,[0.025 0.975],2);
YES5Ypcbar = mean(Y1,2);
YES5YpcCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Press_Conference.ES5Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VES5Ypcbar, 'k--','LineWidt',2); 
h3 = plot(t,VES5YpcCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Press_Conference.ES5Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YES5Ypcbar,'k--','LineWidth',2); 
h3 = plot(t,YES5YpcCI,'r--','LineWidth',2); 
title('Press Conference ES5Y vs simulated mean and 95% Confidence Interval '); 

%% Spanish 5-years Bonds Monetary Event: 

% ES2Y Press Conference GARCH(1,1)
ES5Yme_garch01 = estimate(garch(1,1), [Monetary_Event.ES5Y(1:n)]);

[V1,Y1] = simulate(ES5Yme_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VES5Ymebar = mean(V1,2);
VES5YmeCI  = quantile(V1,[0.025 0.975],2);
YES5Ymebar = mean(Y1,2);
YES5YmeCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Monetary_Event.ES5Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VES5Ymebar, 'k--','LineWidt',2); 
h3 = plot(t,VES5YmeCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Monetary_Event.ES5Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YES5Ymebar,'k--','LineWidth',2); 
h3 = plot(t,YES5YmeCI,'r--','LineWidth',2); 
title('Press Conference ES5Y vs simulated mean and 95% Confidence Interval '); 

%% Spanish 10-years Bonds Press Conference: 

% ES2Y Press Conference GARCH(1,1)
ES10Ypc_garch01 = estimate(garch(1,1), [Press_Conference.ES10Y(1:n)]);

[V1,Y1] = simulate(ES10Ypc_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VES10Ypcbar = mean(V1,2);
VES10YpcCI  = quantile(V1,[0.025 0.975],2);
YES10Ypcbar = mean(Y1,2);
YES10YpcCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Press_Conference.ES10Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VES10Ypcbar, 'k--','LineWidt',2); 
h3 = plot(t,VES10YpcCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Press_Conference.ES10Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YES10Ypcbar,'k--','LineWidth',2); 
h3 = plot(t,YES10YpcCI,'r--','LineWidth',2); 
title('Press Conference ES10Y vs simulated mean and 95% Confidence Interval '); 

%% Spanish 10-years Bonds Monetary Event: 

% ES2Y Press Conference GARCH(1,1)
ES10Yme_garch01 = estimate(garch(1,1), [Monetary_Event.ES10Y(1:n)]);

[V1,Y1] = simulate(ES10Yme_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VES10Ymebar = mean(V1,2);
VES10YmeCI  = quantile(V1,[0.025 0.975],2);
YES10Ymebar = mean(Y1,2);
YES10YmeCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Monetary_Event.ES10Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VES10Ymebar, 'k--','LineWidt',2); 
h3 = plot(t,VES10YmeCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Monetary_Event.ES10Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YES10Ymebar,'k--','LineWidth',2); 
h3 = plot(t,YES10YmeCI,'r--','LineWidth',2); 
title('Monetary Event ES10Y vs simulated mean and 95% Confidence Interval '); 

%%  German 2-years Bonds Press Conference
DE2Ypr_garch01 = estimate(garch(1,1), [Press_Conference.DE2Y(1:n)]);

[V1,Y1] = simulate(DE2Ypr_garch01,n,'NumPaths',5); 

% Plot Simulated conditionalo variance and compare to original data: 
VDE2Ybar = mean(V1,2);
VDE2YCI  = quantile(V1,[0.025 0.975],2);
YDE2Ybar = mean(Y1,2);
YDE2YCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Press_Conference.DE2Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VDE2Ybar, 'k--','LineWidt',2); 
h3 = plot(t,VDE2YCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Press_Conference.DE2Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YDE2Ybar,'k--','LineWidth',2); 
h3 = plot(t,YDE2YCI,'r--','LineWidth',2); 
title('Press Conference DE2Y vs simulated mean and 95% Confidence Interval'); 




%% German 2-years Bonds Monetary Event: 

% ES2Y Press Conference GARCH(0,1)
DE2Yme_garch01 = estimate(garch(1,1), [Monetary_Event.DE2Y(1:n)]);

[V1,Y1] = simulate(DE2Yme_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VDE2Ymebar = mean(V1,2);
VDE2YmeCI  = quantile(V1,[0.025 0.975],2);
YDE2Ymebar = mean(Y1,2);
YDE2YmeCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Monetary_Event.DE2Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VDE2Ymebar, 'k--','LineWidt',2); 
h3 = plot(t,VDE2YmeCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Monetary_Event.DE2Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YDE2Ymebar,'k--','LineWidth',2); 
h3 = plot(t,YDE2YmeCI,'r--','LineWidth',2); 
title('Monetary Event DE2Y vs simulated mean and 95% Confidence Interval '); 

 
%%  German 5-years Bonds Press Conference
DE5Ypr_garch01 = estimate(garch(1,1), [Press_Conference.DE5Y(1:n)]);

[V1,Y1] = simulate(DE5Ypr_garch01,n,'NumPaths',5); 

% Plot Simulated conditionalo variance and compare to original data: 
VDE5Ybar = mean(V1,2);
VDE5YCI  = quantile(V1,[0.025 0.975],2);
YDE5Ybar = mean(Y1,2);
YDE5YCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Press_Conference.DE5Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VDE5Ybar, 'k--','LineWidt',2); 
h3 = plot(t,VDE5YCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Press_Conference.DE5Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YDE5Ybar,'k--','LineWidth',2); 
h3 = plot(t,YDE5YCI,'r--','LineWidth',2); 
title('Press Conference DE5Y vs simulated mean and 95% Confidence Interval'); 

%% German 5-years Bonds Monetary Event: 

% ES2Y Press Conference GARCH(0,1)
DE5Yme_garch01 = estimate(garch(1,1), [Monetary_Event.DE5Y(1:n)]);

[V1,Y1] = simulate(DE5Yme_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VDE5Ymebar = mean(V1,2);
VDE5YmeCI  = quantile(V1,[0.025 0.975],2);
YDE5Ymebar = mean(Y1,2);
YDE5YmeCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Monetary_Event.DE5Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VDE5Ymebar, 'k--','LineWidt',2); 
h3 = plot(t,VDE5YmeCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Monetary_Event.DE5Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YDE5Ymebar,'k--','LineWidth',2); 
h3 = plot(t,YDE5YmeCI,'r--','LineWidth',2); 
title('Monetary Event DE5Y vs simulated mean and 95% Confidence Interval '); 

%%  German 10-years Bonds Press Conference
DE10Ypr_garch01 = estimate(garch(1,1), [Press_Conference.DE10Y(1:n)]);

[V1,Y1] = simulate(DE10Ypr_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VDE10Ybar = mean(V1,2);
VDE10YCI  = quantile(V1,[0.025 0.975],2);
YDE10Ybar = mean(Y1,2);
YDE10YCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Press_Conference.DE10Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VDE10Ybar, 'k--','LineWidt',2); 
h3 = plot(t,VDE10YCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 


subplot(2,1,2); 
h1 = plot(t,Press_Conference.DE10Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YDE10Ybar,'k--','LineWidth',2); 
h3 = plot(t,YDE10YCI,'r--','LineWidth',2); 
title('Press Conference DE10Y vs simulated mean and 95% Confidence Interval'); 

%% German 10-years Bonds Monetary Event: 

% ES2Y Press Conference GARCH(0,1)
DE10Yme_garch01 = estimate(garch(1,1), [Monetary_Event.DE10Y(1:n)]);

[V1,Y1] = simulate(DE10Yme_garch01,n,'NumPaths',npaths); 

% Plot Simulated conditionalo variance and compare to original data: 
VDE10Ymebar = mean(V1,2);
VDE10YmeCI  = quantile(V1,[0.025 0.975],2);
YDE10Ymebar = mean(Y1,2);
YDE10YmeCI  = quantile(Y1, [0.025 0.975],2);


figure; 
subplot(2,1,1); 
h1 = plot(t,Monetary_Event.DE10Y(1:n).^2,'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,VDE10Ymebar, 'k--','LineWidt',2); 
h3 = plot(t,VDE10YmeCI,'r--','LineWidth',2); 
title('\epsilon^2 vs simulated mean and Confidence Interval'); 

subplot(2,1,2); 
h1 = plot(t,Monetary_Event.DE10Y(1:n),'color',0.8*ones(1,3)); hold on; 
h2 = plot(t,YDE10Ymebar,'k--','LineWidth',2); 
h3 = plot(t,YDE10YmeCI,'r--','LineWidth',2); 
title('Monetary Event DE5Y vs simulated mean and 95% Confidence Interval '); 







