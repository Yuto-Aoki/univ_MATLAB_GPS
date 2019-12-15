function check_data = Parity_check(data, preamble)
% data: 入力データ

for i = 1:length(data)
    if data(i, :) == 0
        data(i, :) = 1;
    elseif data(i, :) == 1
        data(i, :) = -1;
    end
end

%check_data = data;
if preamble <= 2
    D29 = data(preamble+28, :);
    D30 = data(preamble+29, :);
else
    D29 = data(preamble-2, :);
    D30 = data(preamble-1, :);
end

d = data(preamble: preamble+1499);

x = preamble-1;
for i = 1:1500
    if mod(i, 30) == 0
        d(i) = D29*d(i-27)*d(i-25)*d(i-24)*d(i-22)*d(i-21)*d(i-20)*d(i-19)*d(i-17)*d(i-15)*d(i-11)*d(i-8)*d(i-7)*d(i-6);
        x = x + 30;
        D29 = data(x-1);
        D30 = data(x);
    elseif 1 <= mod(i, 30) && mod(i, 30) <= 24
        d(i) = d(i) * D30;
    elseif mod(i, 30) == 25
        d(i) = D29*d(i-24)*d(i-23)*d(i-22)*d(i-20)*d(i-19)*d(i-15)*d(i-14)*d(i-13)*d(i-12)*d(i-11)*d(i-8)*d(i-7)*d(i-5)*d(i-2);
    elseif mod(i, 30) == 26
        d(i) = D30*d(i-24)*d(i-23)*d(i-22)*d(i-20)*d(i-19)*d(i-15)*d(i-14)*d(i-13)*d(i-12)*d(i-11)*d(i-8)*d(i-7)*d(i-5)*d(i-2);
    elseif mod(i, 30) == 27
        d(i) = D29*d(i-26)*d(i-24)*d(i-23)*d(i-22)*d(i-20)*d(i-19)*d(i-15)*d(i-14)*d(i-13)*d(i-12)*d(i-11)*d(i-8)*d(i-7)*d(i-5);
    elseif mod(i, 30) == 28
        d(i) = D30*d(i-26)*d(i-24)*d(i-23)*d(i-22)*d(i-20)*d(i-19)*d(i-15)*d(i-14)*d(i-13)*d(i-12)*d(i-11)*d(i-8)*d(i-7)*d(i-5);
    elseif mod(i, 30) == 29
        d(i) = D30*d(i-28)*d(i-26)*d(i-24)*d(i-23)*d(i-22)*d(i-20)*d(i-19)*d(i-15)*d(i-14)*d(i-13)*d(i-12)*d(i-11)*d(i-8)*d(i-7)*d(i-5);
    %elseif mod(i, 30) == 30
     %   d(i) = D29*d(i-27)*d(i-25)*d(i-24)*d(i-22)*d(i-21)*d(i-20)*d(i-19)*d(i-17)*d(i-15)*d(i-11)*d(i-8)*d(i-7)*d(i-6);
    end
end

% check
x = preamble + 29;
y = 30;
z = 0;
while y ~= 1500
    if data(x-5)==d(y-5) && data(x-4)==d(y-4) && data(x-3)==d(y-3) && data(x-2)==d(y-2) && data(x-1)==d(y-1) && data(x)==d(y)
        z = z + 1;
        
    else
        disp('Bad')
    end
    x = x + 30;
    y = y + 30;
end

data(preamble: preamble+1499) = d;
for i = 1:length(data)
    if data(i, :) == 1
        data(i, :) = 0;
    elseif data(i, :) == -1
        data(i, :) = 1;
    end
end

check_data = data;