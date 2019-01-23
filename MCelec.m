function [] = MCelec(electric_field)
    % clear all
    
    %clearvars
    %clearvars -GLOBAL
    %close all
    
    % set(0,'DefaultFigureWindowStyle','docked')
    global C

    addpath ../geom2d/geom2d

    C.q_0 = 1.60217653e-19;             % electron charge
    C.hb = 1.054571596e-34;             % Dirac constant
    C.h = C.hb * 2 * pi;                    % Planck constant
    C.m_0 = 9.10938215e-31;             % electron mass
    C.kb = 1.3806504e-23;               % Boltzmann constant
    C.eps_0 = 8.854187817e-12;          % vacuum permittivity
    C.mu_0 = 1.2566370614e-6;           % vacuum permeability
    C.c = 299792458;                    % speed of light
    C.g = 9.80665; %metres (32.1740 ft) per s²

    nTime = 100;
    %nTraj = 10;
    nSims = 100;
    
    
    num_of_eletr = 5;
    Initial_V = 0;
    Initial_X = 0;
    points_num = 100;
    
    
    
    accel = electric_field*C.q_0/C.m_0;        % m/s^2 constant due to constant force
    
    deltaT = 0.5;               % seconds time interval
    drift_velocity = zeros(num_of_eletr, points_num);
    x = zeros(num_of_eletr,points_num);
    y = randi([0,20],num_of_eletr,1);
    
    
    for q = 1:num_of_eletr
        velocity = 0;               % initial velocity in m/s
        position = 0;               % initial x position in m
        for p = 1:points_num
            prob = randi([1,20],1,1);
            if prob == 1
                velocity_2 = 0;
            else
                velocity_2 = velocity_next(velocity,accel,deltaT);
            end
            position = position + ((velocity + velocity_2)/2)*deltaT;
            velocity = velocity_2;
            
            x(q,p) = position;
            drift_velocity (q,p) = position/(p*deltaT);
        end
    end
    for k = 1: points_num
        pause (0.2)
        plot(x(:,k),y,'o')
        xlim([0,50e12])
        xlabel('Position (m)')
        ylabel('Position (m)')
        legend(num2str(drift_velocity(1,k)),num2str(drift_velocity(2,k)),num2str(drift_velocity(3,k)),num2str(drift_velocity(4,k)),num2str(drift_velocity(5,k)))
        grid on
        hold on 
    end

end
function [v_next] = velocity_next(vel, accel, deltaT)
    v_next = vel + accel*deltaT;
end
