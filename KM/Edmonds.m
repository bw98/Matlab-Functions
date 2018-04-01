function [Matching,Cost] = Edmonds(a)
% Edmonds匈牙利算法
% 输入参数:
%    a    指派问题的系数矩阵    (矩阵)
% 输出参数:
%    Matching    与a的原问题具有相同最优指派的系数矩阵    (矩阵)
%    Cost    最优指派下的最优花费    (标量) 

Matching = zeros(size(a));
    num_y = sum(~isinf(a),1);
    num_x = sum(~isinf(a),2);
    x_con = find(num_x~=0);
    y_con = find(num_y~=0);
    P_size = max(length(x_con),length(y_con));
    P_cond = zeros(P_size);
    P_cond(1:length(x_con),1:length(y_con)) = a(x_con,y_con);
    if isempty(P_cond)
      Cost = 0;
      return
    end
      Edge = P_cond;
      Edge(P_cond~=Inf) = 0;
        cnum = min_line_cover(Edge);
         Pmax = max(max(P_cond(P_cond~=Inf)));
      P_size = length(P_cond)+cnum;
      P_cond = ones(P_size)*Pmax;
      P_cond(1:length(x_con),1:length(y_con)) = a(x_con,y_con);
  exit_flag = 1;
  stepnum = 1;
  while exit_flag
    switch stepnum
      case 1
        [P_cond,stepnum] = step1(P_cond);
      case 2
        [r_cov,c_cov,M,stepnum] = step2(P_cond);
      case 3
        [c_cov,stepnum] = step3(M,P_size);
      case 4
        [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(P_cond,r_cov,c_cov,M);
      case 5
        [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov);
      case 6
        [P_cond,stepnum] = step6(P_cond,r_cov,c_cov);
      case 7
        exit_flag = 0;
    end
  end
Matching(x_con,y_con) = M(1:length(x_con),1:length(y_con));
Cost = sum(sum(a(Matching==1)));
