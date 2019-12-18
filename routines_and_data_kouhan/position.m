function [L, l] = position(x0, y0, z0)

% ido keido hennkann
ep = 1 / 298.257222101;
r = sqrt(x0^2 + y0^2 + z0^2);

Lc = atan2(z0 ,sqrt(x0^2 + y0^2));
l = atan2(y0, x0) * 180 / pi;

dl = 1;
L = Lc;
while abs(dl) > 10^(-6)
    old_L = L;
    L = Lc + ep * sin(2 * L);
    dl = L - old_L;
end

L = L * 180 / pi;