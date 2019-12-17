function [s_as,Dn,TOW1,toe,M0,es,af0,af1,af2,toc,Tgd,O,Cus,Cuc,Crs,Crc,Cis,Cic,i0,idot,O_e,Odot] = param(data, preamble)

% ID check
ID_list = zeros(3,2);
for n = 0:300:1200
    x = preamble + 49 + n;
    %x = data(preamble + 49 + n: preamble + 51 + n);
    ID = twototen(data(x : x + 2));

    if (1 <= ID) && (ID <= 3)
        ID_list(ID, :) = [ID, x-49];
    end
end

for id = 1:3
   if id == 1
       p = ID_list(1, 2);
       sub = data(p : p+299);
       WN = twototen(sub(61:70));
       Tgd = hosuu(sub(197:204)) * 2 ^ (-31);
       toc = twototen(sub(219:234)) * 2 ^ 4;
       af2 = hosuu(sub(241:248)) * 2 ^(-55);
       af1 = hosuu(sub(249:264)) * 2 ^(-43);
       af0 = hosuu(sub(271:292)) * 2 ^(-31);
       IODE1 = twototen(sub(211:218));
       TOW1 = twototen(sub(31:47)) * 6 -6;
       
       
   end
   
   if id == 2
       p = ID_list(2, 2);
       sub = data(p : p+299);
       IODE2 = twototen(sub(61:68));
       Crs = hosuu(sub(69:84)) * 2^(-5);
       Dn = hosuu(sub(91:106)) * 2^(-43) * pi;
       M0 = (hosuu([sub(107:114);sub(121:144)])) * 2^(-31) * pi;
       Cuc = hosuu(sub(151:166)) * 2^(-29);
       es = (twototen([sub(167:174);sub(181:204)])) * 2^(-33);
       Cus = hosuu(sub(211:226)) * 2^(-29);
       s_as = (twototen([sub(227:234);sub(241:264)])) * 2^(-19);
       toe = twototen(sub(271:286)) * 2^4;
   end
   
   if id == 3
       p = ID_list(3, 2);
       sub = data(p : p+299);
       Cic = hosuu(sub(61:76)) * 2^(-29);
       O_e = (hosuu([sub(77:84);sub(91:114)])) * 2^(-31) * pi;
       Cis = hosuu(sub(121:136)) * 2^(-29);
       i0 = (hosuu([sub(137:144);sub(151:174)])) * 2^(-31) * pi;
       Crc = hosuu(sub(181:196)) * 2^(-5);
       O = (hosuu([sub(197:204);sub(211:234)])) * 2^(-31) * pi;
       Odot = hosuu(sub(241:264)) * 2^(-43) * pi;
       IODE3 = twototen(sub(271:278));
       idot = hosuu(sub(279:292)) * 2^(-43) * pi;
       
   end
end
