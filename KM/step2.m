function [r_cov,c_cov,M,stepnum] = step2(P_cond)
  P_size = length(P_cond);
  r_cov = zeros(P_size,1);  
  c_cov = zeros(P_size,1);  
  M = zeros(P_size);        
  for ii = 1:P_size
    for jj = 1:P_size
      if P_cond(ii,jj) == 0 && r_cov(ii) == 0 && c_cov(jj) == 0
        M(ii,jj) = 1;
        r_cov(ii) = 1;
        c_cov(jj) = 1;
      end
    end
  end
  r_cov = zeros(P_size,1);  % A vector that shows if a row is covered
  c_cov = zeros(P_size,1);  % A vector that shows if a column is covered
  stepnum = 3;
