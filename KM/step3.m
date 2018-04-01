function [c_cov,stepnum] = step3(M,P_size)
  c_cov = sum(M,1);
  if sum(c_cov) == P_size
    stepnum = 7;
  else
    stepnum = 4;
  end

