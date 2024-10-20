function  [index1,index2,h3,theta1,imp1,S] = get_parameters(xh,yh)
% Author: Guo Long
% Date: 2024-10-20
% Location: Lee Shaukee Buliding, Tsinghua university,Beijing, China.
% contact me: guol22@mails.tsinghua.edu.cn
% Description:
% This function calculates several key parameters based on a legged mechanism's trajectory

%...find index1 and index2
    Yg = yh; Xg = xh;
    Yg_L(1,1:180) = Yg(1,181:360); 
    Yg_L(1,181:360) = Yg(1,1:180); 
    DeltaY = abs(Yg_L-Yg);         
    index = find(DeltaY == min(min(DeltaY)));
    if xh(index(1)) > xh(index(2))
        index1 = index(1);
        index2 = index(2);
    else
        index1 = index(2);
        index2 = index(1);
    end
    if index1 <= 180 && index1 >2
        xh_ground = xh(index1:index2);
        yh_ground = yh(index1:index2);
    else        
        xh_ground = xh([index1:360,1:index2]);
        yh_ground = yh([index1:360,1:index2]);
    end
%...h3 and S
    h3 = max(yh_ground) - min(yh_ground);
    S = h3/300;
%...I(imp1)
    AB = [xh(index1) - xh(index1+1), yh(index1) - yh(index1+1)];
    AX = [1,0];
    theta1 = acos(dot(AB,AX)/(norm(AB)*norm(AX)));
    T = 2;
    imp1 = (abs(yh(index1) - yh(index1+1)))/(T/360);  
end
        