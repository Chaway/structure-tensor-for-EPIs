clear
img = imread('circuit.tif');

img = im2double(img);
subplot(1,2,1)
imshow(img);

maskSize = 11;

%DoG = difference_of_gaussian_kernels(maskSize);
%Ix = conv2(img, DoG.Gx,'same');
%Iy = conv2(img, DoG.Gy,'same');

Ga = double(fspecial('gaussian', maskSize));
Gx = conv2(img,[-1,1],'same');
Gy = conv2(img,[-1;1],'same');

xx = conv2(Gx.^2,Ga,'same');
xy = conv2(Gx.*Gy,Ga,'same');
yy = conv2(Gy.^2,Ga,'same');


[rows,cols] = size(img);
result = zeros(rows,cols);

%MI = [Ix*Ix, Ix*Iy;Ix*Iy, Iy*Iy];
for r = 1:rows
    for c = 1:cols
        MI = [xx(r,c),xy(r,c);xy(r,c),yy(r,c)];
        [e1,e2,l1,l2] = eigen_decomposition(MI);
        if(l2 - l1 > 0.007 && l1 < 0.002)
            result(r,c) = 1;
        end
    end
end

subplot(1,2,2)
imshow(result)

