function demo_ISPM
% 
% Chunyuan Li

% 0. Settings
clc
clear

setting_up                 

% 1. compute ispm
compute_vq_codes    

% 2. load ispm and compute distance
load_vq_codes    
compute_distance

% 3. load distance, groundtruth and evaluate

% 3.1 load distance matrix
load(fullfile(DIST_DIR, ['distance_' num2str(VOCAB_SIZES) ...
                        '_coding_' CodingType ...
                        '_desc_' DescriptorType '.mat']), ...
                        'D_multi_level');

% 3.2 evaluate
evaluate_ispm;


end