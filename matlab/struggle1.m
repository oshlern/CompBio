function [gvec,yvec,rvec,z] = struggle1(yinit,rinit)
%This function simulates the game "Struggle".  The color scheme is as
%follows: Empty=1 (light blue), Grass=2 (green), Rabbits=2.5 (yellow),
%Foxes=4 (red).  Typical application:
%
%[gvec,yvec,rvec,z] = struggle1([[[1:8]' ones(8,1)];[[1:8]' 2*ones(8,1)]],[5,5;5,6;6,5;6,6]);
%[gvec,yvec,rvec,z] = struggle1([[[1:8]' ones(8,1)];[[1:8]' 3*ones(8,1)]],[[[1:8]' 2*ones(8,1)];[[1:8]' 4*ones(8,1)]]);
%[gvec,yvec,rvec,z] = struggle1([2,3;2,4;3,3;3,4],[2,5;3,5;4,3;4,4]);
%

pausetime = 0.1;

figure(1);
clf;
n = 7;
x = [0:n+3]';
y = [0:n+3]';
z = ones(n+4,n+4);
z(:,n+3) = zeros(n+4,1);
z(n+3,:) = zeros(1,n+4);
z(:,1) = zeros(n+4,1);
z(1,:) = zeros(1,n+4);
z(n+3,n+3) = 4;

Nyinit = numel(yinit)/2;
Nrinit = numel(rinit)/2;
for i = 1:Nyinit,
    z(yinit(i,1)+1,yinit(i,2)+1) = 2.5;
end
for i = 1:Nrinit,
    z(rinit(i,1)+1,rinit(i,2)+1) = 4;
end
surf(x,y,z);axis([1,n+2,1,n+2,-n+1,n-1]);view(2);
colormap jet;

gvec = [0];
yvec = [Nyinit];
rvec = [Nrinit];
minyr = min(yvec(end),rvec(end));

pause;
figure(1);

while minyr>0,
    h = unidrnd(8,1,2);
    yh = h(1)+1;
    xh = h(2)+1;
    zh = z(yh,xh);
    neigh = [z(yh+1,xh) z(yh-1,xh) z(yh,xh+1) z(yh,xh-1)];
    if zh==1,
        z(yh,xh) = 2;
        gvec = [gvec;sum(sum(z==2))];
        yvec = [yvec;sum(sum(z==2.5))];
        rvec = [rvec;sum(sum(z==4))-1];
    elseif zh==2,
        if ~isempty(find(neigh==2.5)),
            z(yh,xh) = 2.5;        
            gvec = [gvec;sum(sum(z==2))];
            yvec = [yvec;sum(sum(z==2.5))];
            rvec = [rvec;sum(sum(z==4))-1];
        else end
    elseif zh==2.5,
        if ~isempty(find(neigh==2)),
            if ~isempty(find(neigh==4)),
                hh = binornd(1,0.5,1,1);
                if hh==1,
                    I = find(neigh==2);
                    if I==1,
                        z(yh+1,xh) = 2.5;
                    elseif I==2,
                        z(yh-1,xh) = 2.5;
                    elseif I==3,
                        z(yh,xh+1) = 2.5;
                    elseif I==4,
                        z(yh,xh-1) = 2.5;
                    else end
                    gvec = [gvec;sum(sum(z==2))];
                    yvec = [yvec;sum(sum(z==2.5))];
                    rvec = [rvec;sum(sum(z==4))-1];
                else
                    z(yh,xh) = 4;
                    gvec = [gvec;sum(sum(z==2))];
                    yvec = [yvec;sum(sum(z==2.5))];
                    rvec = [rvec;sum(sum(z==4))-1];
                end
            else
                I = find(neigh==2);
                if I==1,
                    z(yh+1,xh) = 2.5;
                elseif I==2,
                    z(yh-1,xh) = 2.5;
                elseif I==3,
                    z(yh,xh+1) = 2.5;
                elseif I==4,
                    z(yh,xh-1) = 2.5;
                else end
                gvec = [gvec;sum(sum(z==2))];
                yvec = [yvec;sum(sum(z==2.5))];
                rvec = [rvec;sum(sum(z==4))-1];
            end
        else
            if ~isempty(find(neigh==4)),
                z(yh,xh) = 4;
                gvec = [gvec;sum(sum(z==2))];
                yvec = [yvec;sum(sum(z==2.5))];
                rvec = [rvec;sum(sum(z==4))-1];
            else end
        end
    elseif zh==4,
        z(yh,xh) = 1;
        gvec = [gvec;sum(sum(z==2))];
        yvec = [yvec;sum(sum(z==2.5))];
        rvec = [rvec;sum(sum(z==4))-1];
    end
    surf(x,y,z);axis([1,n+2,1,n+2,-n+1,n-1]);view(2);
    pause(pausetime);
    minyr = min(yvec(end),rvec(end));
end

figure(2);
clf;
plot([1:numel(gvec)]',gvec,'g-',[1:numel(gvec)]',yvec,'y-',[1:numel(gvec)]',rvec,'r-');
grid;


    
        
