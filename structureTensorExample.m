clear
img = imread('circuit.tif');

img = im2double(img);
subplot(1,2,1)
imshow(img);

maskSize = 11;

DoG = difference_of_gaussian_kernels(maskSize);
Ix = conv2(img, DoG.Gx,'same');
Iy = conv2(img, DoG.Gy,'same');


[rows,cols] = size(img);
result = zeros(rows,cols);

%MI = [Ix*Ix, Ix*Iy;Ix*Iy, Iy*Iy];
for r = 1:rows
    for c = 1:cols
        MI = [Ix(r,c)^2,Ix(r,c)*Iy(r,c);Ix(r,c)*Iy(r,c),Iy(r,c)^2];
        [e1,e2,l1,l2] = eigen_decomposition(MI);
        if(l2 - l1 > 0.007 && l1 < 1e-17)
            result(r,c) = 1;
        end
    end
end

subplot(1,2,2)
imshow(result)

