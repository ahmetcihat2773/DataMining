function [trainData,validData] = sampling(data, percentage, type)
    % This function returns train and validation datasets  
    % data is a struct : 
    %    data.x  :: matrix or column vector. Each column represents one
    %    feature
    %    data.y  :: labels
    %    data.header  :: Dimention names or feature names. 
    % percentage : Percentage of train data by validation data like : 0.7
    % type :: this can be "random" or "stratified"
        % random mode :  samples are chosen randomly without keeping the ratio of labels.
        % stratified mode : samples are chosen randomly but keeping also
        % the class ratio in traind and validData

    % returns :: train and validation data with the same structure as data
    % has.

    samples = data.x;
    labels = data.y;
    data_size = length(data.y)
    trainData.header = data.header;
    validData.header = data.header;
    
    if strcmp(type,"random")      

        random_index = randperm(data_size)';
        samples= samples(random_index,:);
        labels = labels(random_index,:);
        train_data_size = percentage*data_size;
        trainData.x = samples(1:train_data_size,:);
        trainData.y = labels(1:train_data_size);
        trainData.header = data.header;
        validData.x = samples(train_data_size+1:end,:);
        validData.y = labels(train_data_size+1:end);
        validData.header = data.header;

    elseif strcmp(type,"stratified") 
        % 1- Find the number of each class
        % 2- Find percentage of each class
        % 3- Find the necessary points that should be chosen according to the
        % trainvalid split rate and class rate. 

         num_zero = sum(data.y == labels(1));
         num_one = sum(data.y == labels(2));
         % Total number of sample points for each class.
         num_zero_percentage = num_zero/data_size;
         num_one_percentage = num_one/data_size;
         % Number of data in each training and validation dataset.
         select_one_training = round(num_one_percentage*percentage*data_size);
         % 105
         select_zero_training = round(num_zero_percentage*percentage*data_size);
         
         one_samples = data.x(data.y==labels(2),:);
         one_samples_train = one_samples(1:select_one_training,:);
         zero_samples = data.x(data.y==labels(1),:);
         zero_samples_train = zero_samples(1:select_zero_training,:);


         one_label = data.y(data.y == labels(2));
         zero_label = data.y(data.y == labels(1));
         zero_label_train = zero_label(1:select_zero_training);
         one_label_train = one_label(1:select_one_training,:);

        trainData.x = [one_samples_train;zero_samples_train];
        trainData.y = [one_label_train;zero_label_train];

        tot_num_training = length(trainData.y);
        final_index = randperm(tot_num_training)';
        trainData.x = trainData.x(final_index,:);
        trainData.y = trainData.y(final_index,:);

        % Take first n sample for x values which are labeled as 1.      
        one_samples_valid = one_samples(select_one_training+1:end,:);
        zero_samples_valid = zero_samples(select_zero_training+1:end,:);
        
        zero_label_valid = zero_label(select_zero_training+1:end);
        one_label_valid = one_label(1+select_one_training:end);

      
       
        validData.x = [one_samples_valid;zero_samples_valid];        
        validData.y = [one_label_valid ;zero_label_valid ];
        validData_len = randperm(length(validData.y))';
        % Mix the data points randomly. 
        validData.x = validData.x(validData_len,:);
        validData.y = validData.y(validData_len,1); 


        
    
    end

end
