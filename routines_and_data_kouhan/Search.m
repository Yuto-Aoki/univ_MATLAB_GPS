function preamble = Search(data)
% preamble: Preambleの検索結果
% data: 入力データ

for i = 1:length(data)-8

    if data(i:i+7, :) == [1;0;0;0;1;0;1;1]
        if data(i+300:i+307, :) == [1;0;0;0;1;0;1;1]
            disp([num2str(i) 'にあります'])
            preamble = i;
            break
        end
        
    elseif data(i:i+7, :) == [0;1;1;1;0;1;0;0]
        if data(i+300:i+307, :) == [0;1;1;1;0;1;0;0]
            disp([num2str(i) 'にあります'])
            preamble = i;
            break
        end
    end
end