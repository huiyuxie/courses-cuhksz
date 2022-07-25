%%
p=ones(50,50);
for i=1:50
    for j=1:50
        if (j/50)>(i/50)^3
            n=51-j;
            p(i,n)=0;
        end
    end
end
u=zeros(50,1);



for i=1:50
    for j=1:49
        if abs(p(i,j)-p(i,j+1))==1
            u(i,1)=j;
        end
    end
end

for i =28:45
    for j =1:4
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end

for i =26:27
    for j =3
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end

for i =23:25
    for j =2
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
for i =20:22
    for j =1
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
for i=14:49
    p(i,u(i))=0.1*rand()+0.45;
end

imagesc(p)
colorbar
%%
for i=91:95
    for j=1:4
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =50:59
    for j =1:4
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =28:45
    for j =1:4
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =30:32
    for j =3
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =26:27
    for j =3
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =23:25
    for j =2
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =20:22
    for j =1
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%
for i =37:39
    for j =1:5
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
%%     
for i=14:49
    p(i,u(i))=0.1*rand()+0.45;
end
%%
p(50,1)=0.5*rand();
p(50,2)=0.5*rand();

p(49,3)=0.5*rand();
p(49,4)=0.5*rand();
%%
imagesc(p)

%%

for i=1:2
    k1=randi([22 49],1);
    d=u(k1,1);
    k2=randi([d 48],1);
    p(k1,k2)=0.1*rand()+0.8;
end

%%
for i=19
    p(i,49)=0.5*rand()+0.5;
end
%%
for i =46:49
    for j =1:2
        p(i,u(i)+j)=0.5*rand() +0.5;
        p(i,u(i)-j)=0.5*rand();
    end
end
