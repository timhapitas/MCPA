global constants;

constants.m = 9.11e-31; %kg%
constants.q = 1.602e-19; %C%

v_o = 0; %m/s%
x_o = 0; %m%
t_o = 0; %s%

E_field = 10; %V/m%
E_force = E_field * constants.q; %N%
a = E_force/constants.m; %N%

timeSteps = 1000;
dt = 1e-8; %s%

v_prev = v_o;
v = v_o;
x_prev = x_o;
x = x_o;

v_sum = 0;
v_drift = 0;

scatterProbability = 0.05;

for t = 1:timeSteps
    
    x_prev = x;
    v_prev = v;
    
    dv = (a*dt);
    v = v_prev + dv;
    
    dx = (v*dt);
    x = x_prev + dx;
    
    if (rand() <= scatterProbability)
       
        v = 0;
        
    end
    
    v_drift_prev = v_drift;
    
    v_sum = v_sum + v;
    v_drift = v_sum/t;
    
    subplot(2,1,1);
    xlabel('Time (s)');
    ylabel('Position (m)');
    plot([(t*dt - dt) ((t*dt))],[x_prev x], 'r');
    grid on;
    hold on;
    
    subplot(2,1,2);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    plot([(t*dt - dt) ((t*dt))],[v_prev v], 'g');
    plot([(t*dt - dt) ((t*dt))],[v_drift_prev v_drift], 'b');
    legend('Velocity', 'Drift Velocity');
    grid on;
    hold on;
    
    sgtitle('Electron Position and Velocity Vs Time (Drift Velocity = ' + string(v_drift) + ')')
    
    pause(0.001);
    
end

hold off;