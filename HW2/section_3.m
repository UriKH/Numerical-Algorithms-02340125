clc; clear;
%% ====================== Prepare New Test Set ======================
load('mnist.mat');

num_images = test.count;
new_test_images = shiftdim(test.images, 2);
A_new_test = reshape(new_test_images,num_images,28*28);
A_new_test = [A_new_test, ones(num_images,1)];
true_labels = test.labels;

%%  ================== Instantiate classifiers (0 - 9) =======================
% create classiffier weight matrix
% (each column is the classifier for the index-1)
classifiers = zeros(785, 10);

%%  ================== Solve LS and create classifiers (0 - 9) =======================
N = 4000;

for digit=0:1:9
    imagesPerDigit = training.images(:,:,training.labels == digit);
    imagesPerOther = training.images(:,:,training.labels ~= digit);
    
    % ========================= Create A,B ==============================
    A_all = zeros(2*N,28^2);
    b_all = zeros(2*N,1);
    for i=1:N
        A_all(2*i-1,:) = reshape(imagesPerDigit(:,:,i),1,28*28);
        A_all(2*i,:)   = reshape(imagesPerOther(:,:,i),1,28*28);
        b_all(2*i-1)   = +1;
        b_all(2*i)     = -1;
    end
    A_all = [A_all, ones(2*N,1)];

    % ========================= Solve LS ==============================
    A_train = A_all(1:N,:);
    b_train = b_all(1:N); 
    
    x=pinv(A_train)*b_train;
    classifiers(:,digit+1) = x;
    
    A_test = A_all(N+1:2*N,:); 
    b_test = b_all(N+1:2*N);
end

%% ============================ Predict ==============================
UNCLASSIFIED = -1;
pred = UNCLASSIFIED * ones(num_images, 1);

results = zeros(num_images, 10);
for digit = 1:1:10
    results(:,digit) = abs((A_new_test*classifiers(:,digit))-1);
end

uncertain_cnt = 0;
for img_ind = 1:1:num_images    
    % even if uncertain choose the first best occurance
    [~,I] = min(results(img_ind,:));
    pred(img_ind) = I-1;
    
    % calculate uncertain cases - check if 2 classifiers got the same
    % answer
    uncertain_flag = false;
    for ind1 = 1:1:10
        if pred(img_ind)+1 == results(img_ind,ind1)
            for ind2 = 1:1:10
                if ind1 ~= ind2 && results(img_ind,ind1) == results(img_ind,ind2)
                    uncertain_flag = true;
                end
            end
        end
    end
    if uncertain_flag
        uncertain_cnt = uncertain_cnt + 1;
    end
end

disp(['Uncertain about ', num2str(uncertain_cnt), ' images'])

%% =========================== Evaluate ==============================
acc = mean(pred == true_labels)*100;
disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*num_images),' wrong examples)']); 

%% ================= Show example of problematric image ====================
error = find(pred ~= true_labels);
figure;
sgtitle('Problemistic images')

for k = 1:1:5
    subplot(2, 3, k);
    imshow(reshape(A_new_test(error(k),1:28^2),[28,28]));
    colormap(gray(256))
    title([num2str(true_labels(error(k))), ' classified as ', num2str(pred(error(k)))]);
end

subplot(2, 3, 6);
axis off; 
