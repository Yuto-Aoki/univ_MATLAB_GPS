function [x,y,z,pr,r,i,fai,Oer] = cal_satell(s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot,dl)
%[x,y,z,pr]
n = sqrt(3986005/s_as^(6)*10^(8)) + Dn;
tc = TOW1 - dl;

if (tc - toe) > 302400
    tc = tc - 604800;
elseif (tc - toe) < -302400
    tc = tc + 604800;
end

M = M0 + n*(tc - toe);

de = 1;
E = M;
while abs(de) > 10^(-6)
    old_E = E;
    E = M + es * sin(E);
    de = E - old_E;
end

dtr = -4.442807633*10^(-10) * es * s_as * sin(E);
dt = af0 + af1 * (tc - toc) + af2*(tc - toc)^(2) + dtr - Tgd;
t = tc - dt;
pr = dl * 2.99792458 * 10^8 + 2.99792458 * 10^8 * dt;

v1 = acos((cos(E) - es) / (1 - es * cos(E)));
v2 = asin((sqrt(1-es^2) * sin(E)) / (1 - es * cos(E)));
v = v1 * sign(v2);

fai = v + O;

dfai = Cus * sin(2*fai) + Cuc * cos(2*fai);
dr = Crs * sin(2*fai) + Crc * cos(2*fai);
di = Cis * sin(2*fai) + Cic * cos(2*fai);

fai = fai + dfai;
r = s_as^(2) * (1 - es * cos(E)) + dr;
i = i0 + di + idot * (t - toe);

Oie = 7.2921151467 * 10 ^ (-5);
Oer = O_e + Odot * (t - toe) - Oie * t;
% 
% oldx = 0;
% oldy = 0;
% oldz = 0;
x = r * cos(Oer) * cos(fai) - r * sin(Oer) * cos(i) * sin(fai);
y = r * sin(Oer) * cos(fai) + r * cos(Oer) * cos(i) * sin(fai);
z = r * sin(i) * sin(fai);
% for i = 1:10
%     x = r * cos(Oer) * cos(fai) - r * sin(Oer) * cos(i) * sin(fai);
%     y = r * sin(Oer) * cos(fai) + r * cos(Oer) * cos(i) * sin(fai);
%     z = r * sin(i) * sin(fai);
% %     ro = 
% %     Oer = 
% end