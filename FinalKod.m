clc;clear all
close all;
imge = imread("100.JPG");

% Imgeyi RGB'den HSI'a Çevir.
HSI = rgb2hsv(imge);
H = HSI(:,:,1);
S = HSI(:,:,2);
I = HSI(:,:,3);
figure;
subplot(1,2,1);
imshow(imge),title("RGB Imge");
subplot(1,2,2);
imshow(HSI),title("HSI Imge");

% Saturasyon(Doygunluk) kanalına Segmentasyonlu Üstel İyileştirme
Sp=zeros(size(S));
[m,n]= size(S);
for i = 1:m
    for j = 1:n
        if S(i,j) <= 0.3
            Sp(i,j) = 1.3*(exp(S(i,j))-1);
        elseif (0.3 <= S(i,j)) && (S(i,j) <= 0.7)
            Sp(i,j) = exp(S(i,j))-1;
        else 
            Sp(i,j) = 0.7*(exp(S(i,j))-1);
        end
    end
end   
figure;
subplot(1,2,1);
imshow(S),title("Orijinal Doygunluk");
subplot(1,2,2);
imshow(Sp),title("Iyilestirilmis Doygunluk");

% Intensity kanalında Histogram Eşitlemesi
hist_imge = histeq(I);

% Wavelet Dönüşümü
n=2; % Kaç Level Dönüşüm Yapacağımızı Belirliyoruz.
[C,S] = wavedec2(hist_imge,n,'haar');
[cH,cV,cD] = detcoef2('all', C, S, n);  % Yüksek Frekans Bileşenlerini Tanımlıyoruz
cA = appcoef2(C, S, 'haar', n); % Düşük Frekans Bileşenlerini Tanımlıyoruz

% Retinex Algoritması
aydinlatma = imgaussfilt(cA,15);
logcA = log(double(cA)+1);
retinex = logcA - log(aydinlatma);
figure;
subplot(1,2,1);
imshow(cA),title("Orijinal Düşük Frekans");
subplot(1,2,2);
imshow(retinex),title("Retinex İyilestirilmesi");
cA = retinex;

% Aşağıda Tanımlanan Fuzzy Algoritmasının Yüksek Frekans Bileşenlerine Uygulanması
cH1 = Fuzzification(cH);
cV1 = Fuzzification(cV);
cD1 = Fuzzification(cD);
figure;
subplot(2,3,1);
imshow(cH),title("Horizontal");
subplot(2,3,2);
imshow(cV),title("Vertical");
subplot(2,3,3);
imshow(cD),title("Diagonal");
subplot(2,3,4);
imshow(cH1);
subplot(2,3,5);
imshow(cV1);
subplot(2,3,6);
imshow(cD1);


% Ters Wavelet Dönüşümü ile İyileştirilmiş Intensity Kanalının Elde Edilmesi
imgr = waverec2(C, S, 'haar');
figure;
subplot(1,2,1);
imshow(I);
subplot(1,2,2);
imshow(imgr);


% Elde Edilen İyileştirilmiş S ve V Kanallarını, Eski H Kanalı İle Birleştirerek Yeni İyileştirilmiş Görüntünün Eldesi
enhanced_imge = H;
enhanced_imge(:,:,2)= Sp;
enhanced_imge(:,:,3) = imgr;
% RGB'e Geri Dönüş
RGB = hsv2rgb(enhanced_imge);

% İyileştirilmiş İmgenin Orijinali İle Kıyaslaması
figure;
subplot(1,2,1);
imshow(imge);
title('Orijinal Imge');
subplot(1,2,2),
imshow(RGB);
title('Iyilestirilmis Imge');
imwrite(RGB,'sonuc.png');

% Fuzzy Algoritması
function enhancedImge = Fuzzification(altband)
xmax = max(altband(:));
xmin = min(altband(:));
[row,col] = size(altband);
Fuzzy = zeros(size(altband));
FuzzyImge = zeros(size(altband));
enhancedImge = zeros(size(altband));

for i = 1:row
    for j = 1:col
        Fuzzy(i,j) = (altband(i,j) - xmin) ./ (xmax - xmin);
        FuzzyImge(i,j) = 0.5 + abs((Fuzzy(i,j) - 0.5).^0.33);
        enhancedImge(i,j) = (FuzzyImge(i,j) .* (xmax - xmin)) + xmin;
    end
end
end