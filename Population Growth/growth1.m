function pop = growth1(T,graph_opt)
%This function simulates the growth of three populations with randomly
%assigned growth rates in a limited resource environment.  Typical
%application:
%
%
%
max_pop = 1000;
t = [0:0.01:T]';
nt = numel(t);
type = unidrnd(3,3,1);
r = zeros(1,3);
pop = zeros(nt,3);
for i = 1:3,
    if type(i)==1,
        r(i) = unifrnd(2e-2,5e-2);
        pop(:,i) = 1+t*r(i);
    elseif type(i)==2,
        r(i) = unifrnd(1e-3,1e-2);
        pop(:,i) = exp(t*r(i));
    elseif type(i)==3,
        r(i) = unifrnd(1e-4,1e-3);
        pop(:,i) = exp(r(i)*t.^(1.5+(1e-3-r(i))/1e-3));
    else end
end
tot_pop = sum(pop')';
pop(:,1) = max_pop*pop(:,1)./tot_pop;
pop(:,2) = max_pop*pop(:,2)./tot_pop;
pop(:,3) = max_pop*pop(:,3)./tot_pop;
figure(1);
clf;
hold on;
if graph_opt==1,
    plot(t,pop(:,1),'b-');
    plot(t,pop(:,2),'r-');
    plot(t,pop(:,3),'k-');
elseif graph_opt==2,
    semilogy(t,pop(:,1),'b-');
    semilogy(t,pop(:,2),'r-');
    semilogy(t,pop(:,3),'k-');
elseif graph_opt==3,
    loglog(t,pop(:,1),'b-');
    loglog(t,pop(:,2),'r-');
    loglog(t,pop(:,3),'k-');
else end
grid;
hold off;
th = t([1:max_pop:end]');
poph = pop([1:max_pop:end]',:);
disp([th(2:end) poph(2:end,:) diff(poph)]);
type


        

