% compute_distance


% load settings
setting_up;
skip_coding = 0;

% load dictionary
load(fullfile(VOCAB_DIR, ['dict_' num2str(VOCAB_SIZES) '_desc_' DescriptorType '.mat']), 'dict', 'sigma');
[nBases, dimDesc] = size(dict);
dimFea = sum(nBases*pyramid);
codes_Size = dimFea;


Specific_DESC_DIR = fullfile(DESC_DIR, DescriptorType);
Hard_BOF_DIR  = fullfile(BOF_DIR, DescriptorType,'hard');
Soft_BOF_DIR  = fullfile(BOF_DIR, DescriptorType,'soft');


warning off;
mkdir(Hard_BOF_DIR);
mkdir(Soft_BOF_DIR);
warning on;   

Meshes = dir(fullfile(MESH_DIR, '*.mat'));
SHAPES = {Meshes.name};



fprintf('Compute the ISPM codes of the mesh...\n');

for s =  1:length(SHAPES), 
    
    shapename = SHAPES{s};

    % Load eigens
    load(fullfile(EVECS_DIR, shapename), 'evecs', 'evals');

    % Load descriptor
    load(fullfile(Specific_DESC_DIR, shapename), 'desc');
    % Normalize descriptors
    desc = double(desc);
    desc = normalize(desc, DESCRIPTOR_NORMALIZATION, 2);
    
    % coding with spectral descriptors via ISPM
    [beta1,beta2] = average_pooling_hard(evecs, desc, dict, pyramid);    
    % Save result
    save(fullfile(Hard_BOF_DIR, shapename), 'beta1','beta2');
    
    % coding with spectral descriptors via ISPM
    [beta1,beta2] = average_pooling_soft(evecs, desc, dict, pyramid,sigma*SIGMA_SCALE); 
    
    % Save result
    save(fullfile(Soft_BOF_DIR, shapename), 'beta1','beta2');

    str = fprintf('VQ codes of %s is extracted.\n', shapename);

end






