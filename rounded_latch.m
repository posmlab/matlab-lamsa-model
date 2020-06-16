function latch = rounded_latch(R, m_L, coeff_fric, v_0)
if (nargin==2) %assume only input (R, m_L), assume v_0,coeff_fric=0
    latch.v_0=0;
    latch.coeff_fric = 0;
elseif (nargin==3)%assume only (R,m_L,coeff_fric)
    latch.coeff_fric = coeff_fric;
    latch.v_0=0;
else
    latch.coeff_fric = coeff_fric;
    latch.v_0=v_0;
end
latch.max_width=R;
latch.mass=m_L;
yL=@(x) latch.max_width*(1-sqrt(1-x^2/latch.max_width^2));
syms x;
yL_prime = diff(yL(x));
yL_doubleprime = diff(yL(x),2);
latch.y_L = {yL, matlabFunction(yL_prime), matlabFunction(yL_doubleprime)};

end 