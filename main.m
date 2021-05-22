%%%%%%
% Practicum 2
% Ellisa Booker
%%%%%
%%
clear all;
close all;
%% Variables

N = 6000; %number of users
p = 0.02; %probility of activation
nloop = 1e5; %number of loops to compute relative freq
X(1:N+1)=0; %Declaring array X
x = 0:150; %Declaring range x to use for distribution calculations

%% Calculations

for iloop=1:nloop   
     val = sum(rand(N,1)<p);   % generating 6000 numbers (0 or 1)
     X(val+1) = X(val+1) + 1;  % Storing in X array
end

% Calculate the probability of failure by summing all values of X from 1-150
% and dividing by number of trials, nloop
% Subtract probability of failure from 1 to find probability of success for P(X>150)
probOfX = 1 - (sum(X(1:151)) ./  nloop)

% Calculate binomial distribution(N,p) for x = 0:150, and sum the results
% Subtract from 1 to find probability of success
y = binopdf(x,N,p);
binomialSum = sum(y);
binomialProb = 1 - binomialSum

% Calculate poisson distribution where alpha = N*p for x = 0:150, and sum the results
% Subtract from 1 to find probability of success
% Alpha is used because N >> 1 and P << 1
alpha = N*p;
g = poisspdf(x,alpha);
poissonSum = sum(g);
poissonProb = 1- poissonSum

%% Graphing

figure(1)
plot(x,y) %Plot binomial distribution PMF

hold on

plot(x,g) %Plot poisson distribution PMF
plot(0:N,X/nloop,'.') %Plot PMF

xlim([0 min(N, N*p*2)]) %Graph from 0 < x < 240
ylim([0,0.04]); %Graph from 0 < y < 0.04

xlabel('Number of active users,X') %Label axis
ylabel('Relative frequency')

hold off
