
prefix = 'test'; %change to train or test depending on which dataset you want to use to extract dtf features
dataset = 'listsmall';

video_list=[];
splits_dir = '/home/oliver/Projects/DDTF/DTF_FV/data/UCF101/ucfTrainTestlist/';
dtf_dst_dir=fullfile('/media/DEF01B84F01B61D7/datasets/UCF101_DTF');
project_root_path = '/home/oliver/Projects/DDTF/DTF_FV';
video_dir = '/media/DEF01B84F01B61D7/datasets/UCF-101-videos/';
dtf_script_path = '/home/oliver/Projects/DDTF/dense_trajectory_release/release/';

splits_filename = [prefix dataset];
splits_file_path = [splits_dir splits_filename '.txt'];
fid=fopen(fullfile(splits_file_path));
tmp=textscan(fid,'%s%d');
video_list=[video_list;tmp{1}];
labels_list=[labels_list;tmp{2}];


if ~exist(dtf_dst_dir,'dir')
    mkdir(dtf_dst_dir);
end

for i=1:length(video_list)
    action=regexprep(video_list{i},'/v_(\w*)\.avi','');
    dtf_act_dir=fullfile(dtf_dst_dir,action);
    if ~exist(dtf_act_dir,'dir')
        mkdir(dtf_act_dir);
    end
    
    clip_name=regexprep(video_list{i},'\.avi$',''); 
    clip_name=regexprep(clip_name,'.*/','');
    
    zipped_dtf_file=fullfile(dtf_act_dir,[clip_name,'.dtf.gz']);
    video_path = fullfile(video_dir,video_list{i})
    command_line = [dtf_script_path 'DenseTrack ' video_path '| gzip >' zipped_dtf_file ]
    system(command_line);
    


end
