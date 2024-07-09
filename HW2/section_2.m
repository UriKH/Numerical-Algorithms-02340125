clc; clear;

%% ======================= Parameters ===========================
N = 4000;

%%  ==================== Load MNIST dataset ======================
load('mnist.mat');

% ------- Little bit of  exploration to feel the data -------------
whos
disp(training); 
disp(size(training.images));
% ----------------------------------------------------------------

%%  ================== Instantiate classifiers (0 - 9) =======================
% create classiffier weight matrix
% (each column is the classifier for the index-1)
classifiers = zeros(785, 10);

%%  ================== Solve LS and create classifiers (0 - 9) =======================
figure;
sgtitle('Problemistic images for classifiers')

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
    
    % ===================== Check Performance ===========================
    disp(' ');
    disp(['===================== ' ...
        'classifing: ', num2str(digit), ' vs other ' ...
        '=====================']); 
    predC = sign(A_train*x); 
    trueC = b_train; 
    disp('Train Error:'); 
    acc=mean(predC == trueC)*100;
    disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']); 
    
    predC = sign(A_test*x); 
    trueC = b_test; 
    disp('Test Error:'); 
    acc=mean(predC == trueC)*100;
    disp(['Accuracy=',num2str(acc),'% (',num2str((1-acc/100)*N),' wrong examples)']);
    
    % ================= Show example of problematric image ====================
    error = find(predC~=trueC);
    subplot(5, 2, digit+1);
    imshow(reshape(A_test(error(1),1:28^2),[28,28]));
    colormap(gray(256))
    axis image; axis off; 
    title(['classifier of ',num2str(digit),' :',num2str(A_test(error(1),:)*x)]); 
end
