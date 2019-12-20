function [L, l] = main(data1,data2,data3,data4)

[m, n] = size(data1);
if m < n
    data1 = data1.';
end
[m, n] = size(data2);
if m < n
    data2 = data2.';
end
[m, n] = size(data3);
if m < n
    data3 = data3.';
end
[m, n] = size(data4);
if m < n
    data4 = data4.';
end

p1 = Search(data1);
p2 = Search(data2);
p3 = Search(data3);
p4 = Search(data4);
% plist = [p1, p2, p3, p4];

cdata1 = Parity_check(data1, p1);
cdata2 = Parity_check(data2, p2);
cdata3 = Parity_check(data3, p3);
cdata4 = Parity_check(data4, p4);
% clist = [cdata1, cdata2, cdata3, cdata4];

load('dlay.mat')
dlist = [dlay_14,dlay_16,dlay_25,dlay_6];
% pr1 = dlay_14 * 2.99792458 * 10^8;
% pr2 = dlay_16 * 2.99792458 * 10^8;
% pr3 = dlay_25 * 2.99792458 * 10^8;
% pr4 = dlay_6 * 2.99792458 * 10^8;
% pr_list = [pr1,pr2,pr3,pr4];

% xyzr = zeros(4,4);
% for i = 1:4
%     [s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot] = param(clist(1,i), plist(1,i));
%     [xyzr(i,1),xyzr(i,2),xyzr(i,3),xyzr(i,4)] = cal_satell(s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot,pr_list(1,i));
% end

% Sat
[s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot] = param(cdata1, p1);
[x1,y1,z1,pr1,r1,i1,fai1,Oer1] = cal_satell(s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot,dlist(1));
[s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot] = param(cdata2, p2);
[x2,y2,z2,pr2,r2,i2,fai2,Oer2] = cal_satell(s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot,dlist(2));
[s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot] = param(cdata3, p3);
[x3,y3,z3,pr3,r3,i3,fai3,Oer3] = cal_satell(s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot,dlist(3));
[s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot] = param(cdata4, p4);
[x4,y4,z4,pr4,r4,i4,fai4,Oer4] = cal_satell(s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot,dlist(4));
% User
[x0, y0, z0] = user(pr1,pr2,pr3,pr4,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4);

for i = 1:10
input = [x1,y1,z1,pr1,r1,i1,fai1,Oer1;
        x2,y2,z2,pr2,r2,i2,fai2,Oer2;
        x3,y3,z3,pr3,r3,i3,fai3,Oer3;
        x4,y4,z4,pr4,r4,i4,fai4,Oer4;
    ];

userp = [x0, y0, z0];

xyzr = correct(input, userp);

x1 = xyzr(1,1);
y1 = xyzr(1,2);
z1 = xyzr(1,3);
pr1 = xyzr(1,4);
 
x2 = xyzr(2,1);
y2 = xyzr(2,2);
z2 = xyzr(2,3);
pr2 = xyzr(2,4);
 
x3 = xyzr(3,1);
y3 = xyzr(3,2);
z3 = xyzr(3,3);
pr3 = xyzr(3,4);

x4 = xyzr(4,1);
y4 = xyzr(4,2);
z4 = xyzr(4,3);
pr4 = xyzr(4,4);
[x0, y0, z0] = user(pr1,pr2,pr3,pr4,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4);
end
[L, l] = position(x0, y0, z0);
