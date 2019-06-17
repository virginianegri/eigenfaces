% Read input image
% Output the index of the image's class and the class's representative
function [class, outputImage] = classifyImage(inputImage)

%% Read all training set
[im1a, map1] = imread('eig/1a.bmp');
im1 = ind2rgb(im1a,map1);
im1 = rgb2gray(im1);
[im2a, map2] = imread('eig/2a.bmp');
im2 = ind2rgb(im2a,map2);
im2 = rgb2gray(im2);
[im3a, map3] = imread('eig/3A.BMP');
im3 = ind2rgb(im3a,map3);
im3 = rgb2gray(im3);
[im4a, map4] = imread('eig/4A.BMP');
im4 = ind2rgb(im4a,map4);
im4 = rgb2gray(im4);
[im5a, map5] = imread('eig/5A.BMP');
im5 = ind2rgb(im5a,map5);
im5 = rgb2gray(im5);
[im6a, map6] = imread('eig/6A.BMP');
im6 = ind2rgb(im6a,map6);
im6 = rgb2gray(im6);

%% Initialize variables
I = [im1,im2,im3,im4,im5,im6];
N = 6;
[rows cols]=size(im1);


%% Compute Average image
average_face = zeros(size(im1));
for i=1:6
    average_face = average_face + I(:,(i*128 -127):(i*128));
end
average_face = average_face/6;

%% Normalize training images
normalized_images = [];

for i=1:N
    norm_img = I(:,(i*128 -127):(i*128)) - average_face;
    normalized_images = [normalized_images, norm_img];
end

%% Reduce images to column vectors
D = [];
for i=1:N
    d = [];
    img = normalized_images(:,(i*128 -127):(i*128));
    for row=1:rows   
        d = [d,img(row,:)];
    end
    % Get normalized images as column vector
    d = transpose(d);
    D = [D,d];
end

%% Covariance matrix and SVD

%C = D*transpose(D);
C_prime = transpose(D)*D;

% U and V containg singular vectos
% S contains singular values
[U,S,V] = svd(D);


%% Calculate eigenvalues of C'
% Square of singular values = eigenvalues in first n rows/columns
eig_values_C_matrix = S*transpose(S);

% List of eigenvalues of C
eig_values_C = [];
for i=1:N
    eig_values_C = [eig_values_C,eig_values_C_matrix(i,i)];
end

%% Calculate eigenvectors of C
% List of eigenvectors of C
eigenvectors = [];

for i=1:6
    ui = (1/sqrt(eig_values_C(1,i)))*(D*V(:,i));
    % Add eigenface as column vector to matrix of eigenfaces
    eigenvectors = [eigenvectors,ui];
end

%% Show and store eigenfaces;
eigenfaces = [];

%figure;
%hold on;
%title('Eigenfaces','fontsize',18)
for i=1:size(eigenvectors,2)
    img=reshape(eigenvectors(:,i),cols,rows);
    img=img';
    img=histeq(img,255);
    %subplot(ceil(sqrt(N)),ceil(sqrt(N)),i)
    %imshow(img);
    %drawnow;
    %if i==3
        %title('Eigenfaces','fontsize',18)
    %end
    eigenfaces = [eigenfaces, img];
end
%hold off;

%% Load new image to classify
% The input image should already be in grayscale
imX = inputImage;

%% Normalize image as column vector and get average face column vector

% Subtract average face
imX = imX - average_face;

% Get column vector of normalized and average images
normalised_imgX = [];
average_face_vector = [];
for row=1:rows   
    normalised_imgX = [normalised_imgX,imX(row,:)];
    average_face_vector = [average_face_vector,average_face(row,:)];
end
normalised_imgX = transpose(normalised_imgX);
average_face_vector = transpose(average_face_vector);

%% Project input image onto eigenvector space
p = [];
eigs=size(eigenvectors,2);
for i = 1:eigs
    projection = dot(normalised_imgX,eigenvectors(:,i));
    p = [p; projection];
end

%% Reconstruct image
ReshapedImage = average_face_vector + eigenvectors(:,:)*p; %add average and    
ReshapedImage = reshape(ReshapedImage,cols,rows);
ReshapedImage = ReshapedImage';

%% Show the reconstructed image
%figure;
%hold on;
%imagesc(imrotate(ReshapedImage,180)); colormap('gray');
%title('Reconstructed image','fontsize',18)
%hold off;

%% Calculate distances and classify the input image

% Principal components of the training set
principal_components = transpose(eigenvectors)*D;
% Input image score
score = transpose(eigenvectors)*normalised_imgX;

% Distances of input image from principal components
distances = [];
minDist = 0;
minDistIndex = 1;
for i=1:N
    column = principal_components(:,i);
    d = 0;
    for j=1:N
        d = d + (column(j,1)-score(j,1))^2;
    end
    d = sqrt(d);
    distances = [distances, d];
    % Get class with minimum distance
    if(i==1)
        minDist = d;
    else
        if(d<minDist)
            minDist = d;
            minDistIndex = i;
        end
    end
end

class = minDistIndex;
outputImage = I(:,(class*128 -127):(class*128));

end