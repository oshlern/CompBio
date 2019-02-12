function [Nhis,P] = branch4(m,s,p,gens,p_mut,q_mut)
%This function adds mutations to branch3.  p_mut is the probability of
%mutation and q_mut is the probability that it is detrimental.  
%Typical application:
%
%[Nhis,P] = branch4(0,1,0.1,20,0.05,0.9);
%

figure(1);
clf;
P = [0,0];
Nhis = zeros(gens,1);
Nhis(1) = 1;
for i = 2:gens,
    Phold = P;
    mut = binornd(1,p_mut,1,1);
    good_mut = binornd(1,1-q_mut,1,1);
%    if mut==1 & good_mut==1,
%        p = 2*p;
%    elseif mut==1 & good_mut==0,
%        p = p/2;
%    else end;
%    X = binornd(Nhis(i-1),p,1,1);
    if mut==1 & good_mut==1,
        X = binornd(Nhis(i-1),2*p,1,1);
    elseif mut==1 & good_mut==0,
        X = binornd(Nhis(i-1),p/2,1,1);
    else
        X = binornd(Nhis(i-1),p,1,1);
    end
    Phh = normrnd(m,s,2*X,2);
    if X>0,
        Ph = Phh+[Phold(1:X,:);Phold(1:X,:)];
        P = [Ph;Phold(X+1:end,:)];
    elseif X==0,
        P = Phold;
    end    
    Nhis(i) = Nhis(i-1)+X;
    plot(P(:,1),P(:,2),'b.');
    pause(0.1);
end
grid;
figure(2);
clf;
subplot(1,2,1),hist(P(:,1),100);
subplot(1,2,2),hist(P(:,2),100);
[pop,dum] = size(P);
[dum,imax1] = max(P(:,1));
[dum,imin1] = min(P(:,1));
[dum,imax2] = max(P(:,2));
[dum,imin2] = min(P(:,2));
d1 = norm(P(imax1,:)-P(imin1,:));
d2 = norm(P(imax2,:)-P(imin2,:));
A = pi*max(d1,d2)^2;
disp(pop); 
disp(pop/A);
disp([mean(P);P(imax1,:);P(imin1,:);P(imax2,:);P(imin2,:)]);