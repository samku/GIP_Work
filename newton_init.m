clc
clear all

fix1 =  [100,0,10];
fix2 = [100,100,10];
fix3 = [0,100,10];
for i=1:100
    %Gen points
    points(i,:)=[i+4*randn(1,1),i+8*randn(1,1),0];
    scatter(points(i,1),points(i,2));
    d1(i)=sqrt(((fix1(1)-points(i,1))^2)+((fix1(2)-points(i,2))^2)+((fix1(3)-points(i,3))^2));
    d2(i)=sqrt(((fix2(1)-points(i,1))^2)+((fix2(2)-points(i,2))^2)+((fix2(3)-points(i,3))^2));
    d3(i)=sqrt(((fix3(1)-points(i,1))^2)+((fix3(2)-points(i,2))^2)+((fix3(3)-points(i,3))^2));
    hold on
    
    %Solve - Newton
    guess = [0;0;0];
    iter = 1000;
    cnt = 0;
    relax = 0.01;
    tolerance = 0.01;
    pass = 1;
    while pass == 1
        jacobi = 2*[guess(1)-fix1(1) guess(2)-fix1(2) guess(3)-fix1(3);...
                    guess(1)-fix2(1) guess(2)-fix2(2) guess(3)-fix2(3);...
                    guess(1)-fix3(1) guess(2)-fix3(2) guess(3)-fix3(3)];
        value =[ ((guess(1)-fix1(1))^2)+((guess(2)-fix1(2))^2)+((guess(3)-fix1(3))^2) - d1(i)^2;...
                 ((guess(1)-fix2(1))^2)+((guess(2)-fix2(2))^2)+((guess(3)-fix2(3))^2) - d2(i)^2;...
                 ((guess(1)-fix3(1))^2)+((guess(2)-fix3(2))^2)+((guess(3)-fix3(3))^2) - d3(i)^2;  ] ;     
        guess = guess - relax*inv(jacobi)*value;
        cnt = cnt+1;
        d1_iter=sqrt(((fix1(1)-guess(1))^2)+((fix1(2)-guess(2))^2)+((fix1(3)-guess(3))^2));
        d2_iter=sqrt(((fix2(1)-guess(1))^2)+((fix2(2)-guess(2))^2)+((fix2(3)-guess(3))^2));
        d3_iter=sqrt(((fix3(1)-guess(1))^2)+((fix3(2)-guess(2))^2)+((fix3(3)-guess(3))^2));
        if (cnt>=iter) || (abs(d1_iter-d1(i))<=tolerance && abs(d2_iter-d2(i))<=tolerance && abs(d3_iter-d3(i))<=tolerance)
            pass = 0;
        end
    end
    count(i) = cnt;
    x_detect(i,:) = transpose(guess);
    d1_detect(i)=sqrt(((fix1(1)-x_detect(i,1))^2)+((fix1(2)-x_detect(i,2))^2)+((fix1(3)-x_detect(i,3))^2));
    d2_detect(i)=sqrt(((fix2(1)-x_detect(i,1))^2)+((fix2(2)-x_detect(i,2))^2)+((fix2(3)-x_detect(i,3))^2));
    d3_detect(i)=sqrt(((fix3(1)-x_detect(i,1))^2)+((fix3(2)-x_detect(i,2))^2)+((fix3(3)-x_detect(i,3))^2));
    scatter(x_detect(i,1),x_detect(i,2),'*'); 
    
end

