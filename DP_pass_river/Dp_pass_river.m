function [ res ] = Dp_pass_river( x, y )
% DP求解商人与随从问题
% x    此岸的商人数   标量
% y    此岸的随从数   标量
% res  保存了每一次渡河的商人数与随从数   矩阵
res = [];
T = x + y; % T是最大阶段数
dp_x = []; % dp_x,dp_y 对应的索引存储的是第k个状态 Sk=(x, y)
dp_y = [];
for i = 1:T+1
    dp_x(i) = -1;
    dp_y(i) = -1;
dp_x(1) = 3;
dp_y(1) = 3;
end

k = 1; % k计算总阶段
while dp_x(k) ~= 0 && dp_y(k) ~= 0
    % 共有5种有效决策
    % u = 0, v = 1
    % u = 1, v = 0
    % u = 1, v = 1
    % u = 2, v = 0
    % u = 0, v = 2
    % res = [res;x,y];  将坐标点加入res
    
    k = k + 1;
end 

end

