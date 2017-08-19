%structure tensor for EPIs
function dst = stEPI(img,masksize,th1,th2) 
%DoG = difference_of_gaussian_kernels(maskSize);
%Ix = conv2(img, DoG.Gx,'same');
%Iy = conv2(img, DoG.Gy,'same');

Ga = double(fspecial('gaussian', masksize));
Gx = conv2(img,[-1,1],'same');
Gy = conv2(img,[-1;1],'same');

xx = conv2(Gx.^2,Ga,'same');
xy = conv2(Gx.*Gy,Ga,'same');
yy = conv2(Gy.^2,Ga,'same');


[rows,cols] = size(img);
dst = zeros(rows,cols);

%MI = [Ix*Ix, Ix*Iy;Ix*Iy, Iy*Iy];
for r = 1:rows
    for c = 1:cols
        MI = [xx(r,c),xy(r,c);xy(r,c),yy(r,c)];
        [e1,e2,l1,l2] = eigen_decomposition(MI);
        if(l2 - l1 > th1 && l1 < th2)
            dst(r,c) = 1;
        end
    end
end



end