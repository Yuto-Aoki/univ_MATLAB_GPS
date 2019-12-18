function [x0, y0, z0] = user(pr1,pr2,pr3,pr4,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4)

% eiseiichi tokutei
x = [x1,x2,x3,x4];
y = [y1,y2,y3,y4];
z = [z1,z2,z3,z4];
r = [pr1,pr2,pr3,pr4];

% syokichi
x0 = 0;
y0 = 0;
z0 = 0;
s0 = 0;
dx = 1;
dy = 1;
dz = 1;
%ds = 10000;


while (dx > 10^(-6) || dy > 10^(-6) || dz > 10^(-6))
    % shokichi notokino kyori
    r1 = sqrt((x1-x0)^2 + (y1-y0)^2 + (z1-z0)^2) + s0;
    r2 = sqrt((x2-x0)^2 + (y2-y0)^2 + (z2-z0)^2) + s0;
    r3 = sqrt((x3-x0)^2 + (y3-y0)^2 + (z3-z0)^2) + s0;
    r4 = sqrt((x4-x0)^2 + (y4-y0)^2 + (z4-z0)^2) + s0;

    % zansa
    r_bec = [pr1-r1; pr2-r2; pr3-r3; pr4-r4];
    %x_bec = [dx; dy; dz; ds];
    
    % G
    G = zeros(4,4);
    for i = 1:4
        G(i, :) = [-(x(i)-x0)/(r(i)-s0), -(y(i)-y0)/(r(i)-s0), -(z(i)-z0)/(r(i)-s0), 1];
    end
    
    % x_bec keisann
    x_bec = inv(G) * r_bec;
    
    % shokizhi koushinn
    x0 = x0 + x_bec(1);
    y0 = y0 + x_bec(2);
    z0 = z0 + x_bec(3);
    s0 = s0 + x_bec(4);
    
    dx = x_bec(1);
    dy = x_bec(2);
    dz = x_bec(3);
end
    
    