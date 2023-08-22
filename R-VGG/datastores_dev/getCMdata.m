function getCMdata()
%GETCMDATA Local save of ChildMind (CM) dataset 
% Downloads data into nx1 cell array, where n is the number of files found.
% If file is detected to exist in path, it will not download. 
% 
% Seeks to only download training, validation, and testing files from 
% following AWS S3:
%   - bucket: s3://childmind/matlab
%   - foldes: /test, /val, and /train
%
% These are public and do not require AWS credentials.
%
% Alex Estrada 8/19/2023 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Folders and Info
% Initial folder location
test_folder = 's3://childmind/matlab/test/';
val_folder = 's3://childmind/matlab/val/';
train_folder = 's3://childmind/matlab/train/';

% Get info
test_info = dir(test_folder);
val_info = dir(val_folder);
train_info = dir(train_folder);

%% Test
if ~isfile('test_data_cell.mat')
    test_data = cell(numel(test_info),1);
    for i = 1:numel(test_info)
        temp = load([test_folder, test_info(i).name]);
        test_data{i} = temp.sample;
    end
    save('test_data_cell.mat', 'test_data');
    clear test_data
    disp('Testing files downloaded... continuing')
else
    disp('Test files detected.')
end

%% val
if ~isfile('val_data_cell.mat')
    val_data = cell(numel(val_info),1);
    for i = 1:numel(val_info)
        temp = load([val_folder, val_info(i).name]);
        val_data{i} = temp.sample;
    end
    save('val_data_cell.mat', 'val_data');
    clear val_data
    disp('Validation files downloaded... continuing')
else
    disp('Validation files detected.')
end

%% Train
if ~isfile('train_data_cell.mat')
    train_data = cell(numel(train_info),1);
    for i = 1:numel(train_info)
        temp = load([train_folder, train_info(i).name]);
        train_data{i} = temp.sample;
    end
    save('train_data_cell.mat', 'train_data');
    clear train_data
    disp('Training files downloaded.')
else
    disp('Training files detected.')
end

%%
disp("Downloading files complete.")
end

