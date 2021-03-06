function [foot] = Pass_river_3b_3s( b_num, s_num,  capacity)
% DP求解商人与随从问题
% b_num    此岸的商人数   标量
% s_num    此岸的随从数   标量
% foot  保存了每一次渡河的商人数与随从数   矩阵

%%%%%%%%%%%%%%%%%%%%%%    程序开始需要知道商人数，仆人数，船的最大容量
%n=input('输入商人数目:');
%nn=input('输入仆人数目:');
%nnn=input('输入船的最大容量:');

n = b_num;
nn = s_num;
nnn = capacity;
if nn>n
    n = input('输入商人数目:');
    nn = input('输入仆人数目:');
    nnn = input('输入船的最大容量:');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    决策生成
jc = 1; % 决策向量存放在矩阵“d”中，jc为插入新元素的行标初始为1
for i = 0:nnn
    for j = 0:nnn
        if(i+j <= nnn) & (i+j>0) % 满足条件  D={(u,v)|1<=u+v<=nnn,u,v=0,1,2} 
            d(jc,1:3) = [i,j 1 ]; %生成一个决策向量后立刻将他扩充为三维（再末尾加“1”）
            d(jc+1,1:3) = [-i,-j,-1]; %  同时生成他的负向量
            jc = jc+2; %  由于一气生成两个决策向量,jc指标需要往下移动两个单位
        end
    end
    j = 0;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     状态数组生成

kx = 1; % 状态数组存放在矩阵“A”中，生成方法同决策生成
for i = n:-1:0
    for j = nn:-1:0
        if((i>=j)&((n-i)>=(nn-j)))|((i==0)|(i==n))
        %   (i>=j)&((n-i)>=(nn-j)))|((i==0)|(i==n))为可以存在的状态的约束条件
            A(kx,1:3) = [i,j,1]; % 生成状态数组集合D`
            A(kx+1,1:3) = [i,j,0];
            kx = kx+2;
        end
    end
    j = nn;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  将状态数组生成抽象矩阵     

k = (1/2)*size(A,1);
CX = zeros(2*k,2*k);
a = size(d,1);
for i = 1:2*k
    for j = 1:a
        c = A(i,:)+d(j,:);
        x = find((A(:,1)==c(1))&(A(:,2)==c(2))&(A(:,3)==c(3)));
        v(i,x) = 1;% x为空不会改变v的值
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% dijstra方法
x = 1; y = size(A,1);
m = size(v,1);
T = zeros(m,1);
T = T.^-1;
lmd = T;
P = T;
S = zeros(m,1);
S(x) = 1;
P(x) = 0; lmd(x) = 0;
k = x;

while(1)
    a = find(S==0);
    aa = find(S==1);
    if size(aa,1) == m
        break;
    end
    for j = 1:size(a,1)
        pp = a(j,1);
        if v(k,pp) ~= 0
            if T(pp) >(P(k)+v(k,pp))
                T(pp) = (P(k)+v(k,pp));
                lmd(pp) = k;
            end
        end
    end
    mi = min(T(a));
    if mi == inf
        break;
    else
        d = find(T==mi);
        d = d(1);
        P(d) = mi;
        T(d) = inf;
        k=d;
        S(d)=1;
    end
end
if lmd(y) == inf
    foot='can not reach';
    return;
end

foot(1) = y;
g = 2; h = y;
while(1)
    if h == x
        break;
    end
    foot(g) = lmd(h);
    g = g + 1;
    h = lmd(h);
end

foot = A(foot,:);
foot(:,3) = [];
