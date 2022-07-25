clear all
t0=cputime;

%Parameter
dsz=8;delta=0.1;OptTol=1e-8;ConTol=1e-3;

%import original image
image=imread("./test_images/256_256_buildings.png");
gimage=rgb2gray(image);
%gimage=imresize(gimage,0.5);
[m,n]=size(gimage);
gimage=double(gimage);
u=blockproc(gimage,[dsz,dsz],@(x)x.data(:));
u=reshape(u,m*n,1)/255;
%imoport mask
mask=imread("./test_masks/256_256_random50.png");
%mask=imresize(mask,0.5);
mask=double(mask);
mask=blockproc(mask,[dsz,dsz],@(x)x.data(:));
mask=reshape(mask,m*n,1)/255;

%%show the demaged image
% D=find(mask==0);
% u(D)=mask(D);
% u=reshape(u,m*dsz,n/dsz)*255;
% dimage=blockproc(u,[dsz*dsz,1],@(x)reshape(x.data,[dsz,dsz]));
% imshow(uint8(dimage));

I=find(mask~=0);
s=length(I);
A=sparse(1:s,[I],ones(s,1),s,m*n);
b=A*u;
Psi=get_Psi(m,n,dsz);
%construct the problem 
x = optimvar('x',m*n,1);
y = optimvar('y',m*n,1);
% x.LowerBound=0;
% x.UpperBound=1;
prob = optimproblem('Objective',sum(y),'ObjectiveSense','min');
prob.Constraints.c1 = Psi*x-y<=0;
prob.Constraints.c2 = -Psi*x-y<=0;
prob.Constraints.c3 = A*x-b<=delta*ones(s,1);
prob.Constraints.c3 = -A*x+b<=delta*ones(s,1);
problem = prob2struct(prob);
problem.options=optimoptions("linprog",'Algorithm','interior-point',"MaxIteration",30,"Display","iter","OptimalityTolerance",OptTol,"ConstraintTolerance",ConTol);
x = linprog(problem);

t=cputime-t0;
 
%show figure
xx=reshape(x(1:m*n,1),m*dsz,n/dsz)*255;
newimage=blockproc(xx,[dsz*dsz,1],@(x)reshape(x.data,[dsz,dsz]));
imshow(uint8(newimage))
 
%calculate 
PSNR = 10*log10(m*n/norm(x(1:m*n,1)-u)^2)
