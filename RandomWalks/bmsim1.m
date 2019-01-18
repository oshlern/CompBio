function [xhis,yhis] = bmsim1(mux,muy,sigx,sigy,steps,type)
%This function simulates random walks with drift.
%Typical application:
%
%[xhis,yhis] = bmsim1(0,0,1,1,1e3,1);
%

if type==1,
    x = 2*binornd(1,0.5,steps,1)-1;
    y = 2*binornd(1,0.5,steps,1)-1;
elseif type==2,
    x = 2*binornd(1,0.5,steps,1)-1;
    y = 2*binornd(1,0.5,steps,1)-1;
    z = binornd(1,0.5,steps,1);
    x = x.*z;
    y = y.*(1-z);
elseif type==3,
    x = binornd(2,0.5,steps,1)-1;
    y = binornd(2,0.5,steps,1)-1;
else end
xmax = 3*sqrt(steps)*sigx;
ymax = 3*sqrt(steps)*sigy;
figure(1);
axis([min(-xmax,-xmax+mux*steps),max(xmax,xmax+mux*steps),min(-ymax,-ymax+muy*steps),max(ymax,ymax+muy*steps)]);
hold on;
sx = 0;
sy = 0;
xhis = zeros(steps,1);
yhis = zeros(steps,1);
for i = 1:steps,
    sx0 = sx;
    sy0 = sy;
    sx = sx + sigx*x(i) + mux;
    sy = sy + sigy*y(i) + muy;
    xhis(i) = sx;
    yhis(i) = sy;
    plot([sx0;sx],[sy0;sy]);
    if rem(i,100)==0.
        i
    else end
    pause(0.01);
end

