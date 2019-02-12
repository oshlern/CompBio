function [] = mc3(steps,init,E,F,wait)
%This function simulates the evolution of a Markov chain based on three
%energy levels.  The array E contains the three energy levels, [E1,E2,E3].
%The array F contains the three intermediate states [F12,F13,F23].  
%Typical application:
%
%mc3(20,[0,0,1],[2,3,1],[4,5,4],0.1);
%

A12 = exp(-(F(1)-E(1)));
A13 = exp(-(F(2)-E(1)));
A11 = 1-A12-A13;
A21 = exp(-(F(1)-E(2)));
A23 = exp(-(F(3)-E(2)));
A22 = 1-A21-A23;
A31 = exp(-(F(2)-E(3)));
A32 = exp(-(F(3)-E(3)));
A33 = 1-A31-A32;
A = [A11,A12,A13;A21,A22,A23;A31,A32,A33];
M = zeros(steps,3);
M(1,:) = init;
figure(1);
clf;
bar(M(1,:));
pause(wait);
for i = 2:steps,
    M(i,:) = M(i-1,:)*A;
    bar(M(i,:));
    pause(wait);
end
figure(2);
clf;
subplot(2,2,1),plot(M(:,1),M(:,2),'ro');
xlabel('R_1');
ylabel('R_2');
grid;
subplot(2,2,2),plot(M(:,1),M(:,3),'ro');
xlabel('R_1');
ylabel('R_3');
grid;
subplot(2,2,3),plot(M(:,2),M(:,3),'ro');
xlabel('R_2');
ylabel('R_3');
grid;
subplot(2,2,4),plot(M);
grid;

