clear all
close all %figure 창 닫기
clc

Res = [3072, 3072];

addpath('C:\Users\user\Desktop\실전연구문제단\Rawlmage_14') %작업하는 파일에 저장하지 않고도 사용가능하게 만듬

Files=dir('C:\Users\user\Desktop\실전연구문제단\Rawlmage_14');

for k=15
    File = Files(k).name;
    I = ReadRawImage( File, 'uint16', Res(1), Res(2) ); 
    I = single(I); %싱글로 변환
end

[G_x, G_y] = gradient(I);
p=sqrt(G_x.^2 + G_y.^2);

Theta=atan(G_x./G_y);

V=p.*exp(-1i*Theta);

Threshold = 3.9;
%Right side
E1=p>Threshold;
E2=zeros(Res(1),Res(2));
for i = 1:3072
    for k = 1:3072
        if E1(i,k)==1
            E2(i,k)=1;
        end
    end
end

R_E=zeros(3072,3072);

for i = 1:3072
    for k = 3060:-1:3072/2
        if E2(i,k)==1
            R_E(i,k)=1;
            break
        end
        
    end
end



subplot(2,1,1)
imshow(E2)
subplot(2,1,2)
imshow(R_E)
























