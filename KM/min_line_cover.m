function cnum = min_line_cover(Edge)
    [r_cov,c_cov,M,stepnum] = step2(Edge);
     [c_cov,stepnum] = step3(M,length(Edge));
     [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(Edge,r_cov,c_cov,M);
     cnum = length(Edge)-sum(r_cov)-sum(c_cov);
