A0 = [0 0.145 0; 0 -10.85 1; 0 0 -0.217];
B0 = [0;0;1];
C = [1 0 0];
H = [1 0 0];
sigF = 0.02;
delA = [0 0.055 0; 0 4.15 0; 0 0 0.083];
w = 3;
r = [0 1 0; 0 0 1; -w^3 -2*w^2 -2*w];
M = sylvester(-A0, r, -B0*H)
F0 = M*r*M^(-1)
ndelA = norm(delA)
nF0 = norm(F0)
sigF0 = norm(delA)/norm(F0)
K = H*M^(-1)
Kg = -(C*F0^(-1)*B0)^(-1)
a = poly(F0+delA)
b = poly(F0-delA)
check = true;
for i = 1:4
    if a(i) < 0 || b(i) < 0
        check = false;
        disp(-1)
    end
end
if sigF < sigF0
    disp(0)
    check = false;    
elseif max(a(1),b(1))*min(a(4),b(4)) > max(a(2),b(2))*min(a(3),b(3)) 
    disp(1)
    check = false;
elseif max(a(1),b(1))*max(a(4),b(4)) > min(a(2),b(2))*min(a(3),b(3))
    disp(2)
    check = false;
elseif min(a(1),b(1))*max(a(4),b(4)) > min(a(2),b(2))*max(a(3),b(3)) 
    disp(3)
    check = false;
elseif min(a(1),b(1))*min(a(4),b(4)) > max(a(2),b(2))*max(a(3),b(3))
    disp(4)
    check = false;
end
if check
    disp("Congratulations, chosen frequency meet all of the requirements!")
    w
else
    disp("Chosen frequency does not meet requirements, please choose another one")
end