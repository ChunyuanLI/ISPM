
%% 1. parameters

% eigen implementation
LB_PARAM = 'cot';
max_num_evecs = 200;

DescriptorType = 'SGWS';

% dictionary
CodingType = 'k_means'; % 'k_means' 'llc' 'ksvd' 'sc'
num_smp = 3e5; % number of sampled descriptors for dictionary learning

%VOCAB_SIZES            = [4 8 16 24 32 48 64];
VOCAB_SIZES            = 48;

% Training set size for kmeans 
VOCAB_TRAININGSET_SIZE = 3e5;
VOCAB_TRAIN_NITER      = 250;
VOCAB_TRAIN_REPEATS    = 5;
VOCAB_TRAIN_OUTLIERS   = 0.01;

% How to normalize the descriptor vector 
% Can be 'none', 'L1' or 'L2'
DESCRIPTOR_NORMALIZATION = 'L2';
SIGMA_SCALE              = 2;

pyramid = [1, 2, 4, 8, 16, 32, 64, 128];%, 256];  

AssignmentType = 'Soft';
SKIP_EXISTING = 1;


%% 2. load dir for data

%DATA_ROOT_DIR           = fullfile(pwd, '../../data/SHREC');

PROJECT_ROOT_DIR        = pwd;
DATA_ROOT_DIR           = fullfile(PROJECT_ROOT_DIR, '/data/');
%DATA_ROOT_DIR           = get_father_dic(DATA_ROOT_DIR,2);

% Relative data directories

MESH_DIR                = fullfile(DATA_ROOT_DIR, 'mesh');
EVECS_DIR               = fullfile(DATA_ROOT_DIR, ['evecs.' LB_PARAM]);
DESC_DIR                = fullfile(DATA_ROOT_DIR, ['descriptors.' LB_PARAM]);
VOCAB_DIR               = fullfile(DATA_ROOT_DIR, ['vocabs.' LB_PARAM]);
BOF_DIR                 = fullfile(DATA_ROOT_DIR, ['bofs.' LB_PARAM]);
DIST_DIR                = fullfile(DATA_ROOT_DIR, ['distance.' LB_PARAM]);

Specific_DESC_DIR       = fullfile(DESC_DIR, DescriptorType);
Hard_BOF_DIR            = fullfile(BOF_DIR, DescriptorType,'hard');
Soft_BOF_DIR            = fullfile(BOF_DIR, DescriptorType,'soft');


%% 3. load dir for code

% Root directory for code
CODE_ROOT_DIR        = fullfile(PROJECT_ROOT_DIR);

% Set path for auxilary code
addpath(CODE_ROOT_DIR);
addpath(fullfile(CODE_ROOT_DIR, 'meshcodes'));              % basic mesh processing code
addpath(fullfile(CODE_ROOT_DIR, 'utils'));                  % generic utilities
addpath(fullfile(CODE_ROOT_DIR, 'vq'));                     % vector quantization
addpath(fullfile(CODE_ROOT_DIR, 'experiments'));            % experiments
addpath(pwd);


Meshes = dir(fullfile(MESH_DIR, '*.mat'));
SHAPES = {Meshes.name};
