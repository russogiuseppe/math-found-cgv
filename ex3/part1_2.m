%% EXERCISE 3 - PART 1-2
clc
close all
clear all

% paths
addpath(genpath('files/TASK1'))
addpath('functions')

% parameters
x_min = -2;     % x_min <= -2
x_max = 2;      % x_max >= 2
y_min = -2;     % y_min <= -1
y_max = 2;      % y_max >= 1

delta_x = 0.01;
delta_y = 0.01;

datasets = [1, 2, 3];
sigmas = [1, 0.1, 0.01, 0.001];

% visualization
compare_dataset = true;
compare_sigma_data = true;

% debug
debug = false;

%% PART 1-2
disp('===================================================================')
disp('PART 1-2')

for data_idx = 1:size(datasets, 2)
    %% DATA LOAD
    dataset = datasets(data_idx);
    
    disp('-------------------------------------------------------------------')
    disp(['data loading: curve_data', num2str(dataset)])
        
    % nix, niy, xi, yi
    load(['curve_data', num2str(dataset), '.mat']);
    
    %% C0 MATRIX
    disp('calculate C0 matrix')
    
    % domain range
    x_range = x_min:delta_x:x_max;
    y_range = y_min:delta_y:y_max;
    
    % calculate F(x) = C0(x) array
    F_array = zeros(size(y_range, 2), size(x_range, 2), size(datasets, 2), size(sigmas, 2));
    
    for i=1:size(sigmas, 2)
        sigma = sigmas(i);
        disp(['for sigma = ', num2str(sigma)])
        
        F_array(:,:,data_idx,i) = Fx2D(xi, yi, nix, niy, x_range, y_range, sigma, debug);
        
        %% VISUALIZATION
        if compare_sigma_data
            disp('plot implicit mls surface')
            
            figure(data_idx)
            subplot(2, 2, i)
            
            % c0 (implicit surface)
            imagesc(x_range, y_range, F_array(:,:,data_idx,i))
            axis xy
            hold on
            
            % curve
            plot(xi, yi, 'r-')
            
            % normal vectors
            quiver(xi, yi, nix, niy)
            hold off 
        end
        
    end
end