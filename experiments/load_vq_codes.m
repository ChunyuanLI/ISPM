
% load settings
setting_up;


Hard_BOF_DIR  = fullfile(BOF_DIR, DescriptorType,'hard');
Soft_BOF_DIR  = fullfile(BOF_DIR, DescriptorType,'soft');

num_shapes = length(SHAPES);


fprintf(1, 'Load the ISPM codes of the mesh...\n');

feature1 = [];
feature2 = [];


for s = 1:length(SHAPES), 

    shapename = SHAPES{s};  
    
    % Load codes
    load(fullfile(Soft_BOF_DIR, shapename), 'beta1','beta2');
    feature1 = [feature1, beta1]; 
    feature2 = [feature2, beta2];
end    
