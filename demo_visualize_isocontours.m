function demo_visualize_isocontours
% 
% Chunyuan Li


% 0. Settings
close all
clc
clear

setting_up                 

% number of isocontours in visualization
Nlines = 50; 

for s = 1:length(SHAPES), 
    
    % 1. load mesh and its eigens
    shapename = SHAPES{s};
    load(fullfile(MESH_DIR, shapename), 'vertices', 'faces');    
    load(fullfile(EVECS_DIR, shapename), 'evecs', 'evals');

    % 2. visualize 2nd eigenfucntion and its isocontours

    % 2.1 visualize 2nd eigenfucntion
    color = evecs(:,2);
    plotMesh0(vertices,faces,color);
    
    % 2.2 visualize the isocontours of the 2nd eigenfucntion
    draw_isolines(faces,vertices,color,Nlines);
end  

end