function sol = solve_direct_actuation(motor,load)
%Solve differential equation launching phase of direction of direct
%actuated motion usinf F=ma
%motor struct
    %motor.Force
    %motor.max_force
    %motor.r
%load_mass struct
    %load.mass


%% Ballistic phase:F motor only 
launch_opts=odeset('Events',@(t,y) direct_actuation_end(t,y,motor),'RelTol',1E-7,'AbsTol',1E-10);
ode=@(t,y) direct_actuation_ode(t,y,load,motor);


t_guess_v=(motor.max_velocity*load.mass)/motor.max_force;
t_guess_pos=sqrt((2*motor.range*load.mass)/motor.max_force);
if load.mass>=1E0
    t_guess_v=t_guess_v/100;
end
t_guess=max(t_guess_v,t_guess_pos);



tspan=linspace(0,t_guess,1000);
y0=[0,0];
[t,y]=ode45(ode,tspan,y0,launch_opts);
T=[t];
Y=[y];
for i = 1:size(T)
    fMotor(i) = motor.Force(T(i), [Y(i,:)]);
end
fMotor = fMotor';

sol=[T,Y,fMotor];