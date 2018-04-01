function [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov)
  zflag = 1;
  ii = 1;
  while zflag 
     rindex = find(M(:,Z_c(ii))==1);
    if rindex > 0
          ii = ii+1;
       Z_r(ii,1) = rindex;
        Z_c(ii,1) = Z_c(ii-1);
    else
      zflag = 0;
    end
      if zflag == 1;
         cindex = find(M(Z_r(ii),:)==2);
      ii = ii+1;
      Z_r(ii,1) = Z_r(ii-1);
      Z_c(ii,1) = cindex;    
    end    
  end
   for ii = 1:length(Z_r)
    if M(Z_r(ii),Z_c(ii)) == 1
      M(Z_r(ii),Z_c(ii)) = 0;
    else
      M(Z_r(ii),Z_c(ii)) = 1;
    end
  end 
   r_cov = r_cov.*0;
  c_cov = c_cov.*0;
  M(M==2) = 0;
stepnum = 3;
