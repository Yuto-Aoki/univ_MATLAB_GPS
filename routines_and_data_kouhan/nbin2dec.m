function [x]=nbin2dec(binstring)
% 符号付整数を2進数から10進数に変換 (負の数は2の補数で表現)
% binstring：2進数で表現された文字列
% x        ：10進数

n = length(binstring);
x = bin2dec(binstring);

if x >= 2^(n-1) 
    x=x-2^n;
end