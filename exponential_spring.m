function spring = exponential_spring(k_0, characteristic_length, m_s, F_spring_max)
   spring.mass=m_s;
   spring.Time_independent=false;
   if (nargin==3) % only k_0, m_s, characteristic_length passed in, assume F_spring_max = inf, return function handle
    spring.Force = @(t,x)-k_0*x(1)*exp(x(1)/characteristic_length);
   elseif (nargin==4) %return function handle
    spring.Force = @(t,x)-k_0*x(1)*exp(x(1)/characteristic_length).*(abs(k_0*x(1))<F_spring_max);
   else
    error('Exponential spring needs three or four arguments');
   end
end
%spring.Force @(t,x)characteristic_length*k_0(exp(x(1)/characteristic length)-1)

   