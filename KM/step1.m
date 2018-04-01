function [P_cond,stepnum] = step1(P_cond)
  P_size = length(P_cond);  
  for ii = 1:P_size
    rmin = min(P_cond(ii,:));
    P_cond(ii,:) = P_cond(ii,:)-rmin;
  end
  stepnum = 2;
