function [occ_his,prob_his] = mc4(steps,init,E,F)
%This function extends mc3 to track the individual histories of th evolving
%configurations of a set of molecules following a Markov chain based on 
%three energy levels.  Typical application:
%
%[occ_his,prob_his] = mc4(40,[3,3,4],[2,3,1],[4,5,4]);
%

h12 = exp(-(F(1)-E(1)));
h13 = exp(-(F(2)-E(1)));
S1 = h12+h13;
A11 = 1/(1+S1);
A12 = A11*h12;
A13 = A11*h13;
h21 = exp(-(F(1)-E(2)));
h23 = exp(-(F(3)-E(2)));
S2 = h21+h23;
A22 = 1/(1+S2);
A21 = A22*h21;
A23 = A22*h23;
h31 = exp(-(F(2)-E(3)));
h32 = exp(-(F(3)-E(3)));
S3 = h31+h32;
A33 = 1/(1+S3);
A31 = A33*h31;
A32 = A33*h32;
A = [A11,A12,A13;A21,A22,A23;A31,A32,A33];

mols = sum(init);
occ_his = zeros(steps,3);
prob_his = zeros(steps,1);
occ_his(1,:) = init;
prob_his(1) = factorial(mols)/(factorial(occ_his(1,1))*factorial(occ_his(1,2))*factorial(occ_his(1,3))*3^mols);
for i = 2:steps,
    occ_his(i,:) = sum(mnrnd(occ_his(i-1,:)',A));
    prob_his(i) = factorial(mols)/(factorial(occ_his(i-1,1))*factorial(occ_his(i-1,2))*factorial(occ_his(i-1,3))*3^mols);
end
figure(1);
clf;
subplot(2,1,1),plot(occ_his(100:end,:));grid;
subplot(2,1,2),semilogy(prob_his(100:end));grid;
figure(2);
clf;
hist(log10(prob_his(100:end)),50);
grid;
[y,I] = min(prob_his);
disp(y);
disp(I);





