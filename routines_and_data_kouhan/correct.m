function output = correct(input, userp)

c = 2.99792458 * 10^8;
Oie = 7.2921151467 * 10 ^ (-5);
output = zeros(3, 4);

for k = 1:4
    x = input(k, 1);
    y = input(k, 2);
    z = input(k, 3);
    pr = input(k, 4);
    r = input(k, 5);
    i = input(k, 6);
    fai = input(k, 7);
    Oer = input(k, 8);
    
    % User
    xu = userp(1);
    yu = userp(2);
    zu = userp(3);
    
    e = 1;
    dr = 100;
    %while dr > 10
    %while e > 10^(-1)
    
        old_dr = dr;
        tt = (((x-xu)^2 + (y-yu)^2 + (z-zu)^2)^0.5 )/ c;
        Oer = Oer - Oie * tt;
        oldx = x;
        oldy = y;
        oldz = z;
        x = r * cos(Oer) * cos(fai) - r * sin(Oer) * cos(i) * sin(fai);
        y = r * sin(Oer) * cos(fai) + r * cos(Oer) * cos(i) * sin(fai);
        z = r * sin(i) * sin(fai);
        dr = ((x-oldx)^2 + (y-oldy)^2 + (z-oldz)^2)^0.5;
        e = abs(dr - old_dr);
    
    output(k, :) = [x y z pr];
end
 