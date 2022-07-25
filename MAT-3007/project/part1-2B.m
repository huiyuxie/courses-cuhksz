clear all
t0=cputime;

%Parameter
sigma= 0.075; dsz=8;delta=0.9*sigma;OptTol=1e-8;ConTol=1e-4;

%import original image
image=imread("./test_images/512_512_circles.png");
gimage=rgb2gray(image);
gimage=imresize(gimage,0.5);
[m,n]=size(gimage);
gimage=double(gimage);
u=blockproc(gimage,[dsz,dsz],@(x)x.data(:));
u=reshape(u,m*n,1)/255;

A=speye(m*n);
b=u+delta*randn(m*n,1);
Psi=get_Psi(m,n,dsz);
%construct the problem 
x = optimvar('x',m*n,1);
y = optimvar('y',m*n,1);
% x.LowerBound=0;
% x.UpperBound=1;
prob = optimproblem('Objective',sum(y),'ObjectiveSense','min');
prob.Constraints.c1 = Psi*x-y<=0;
prob.Constraints.c2 = -Psi*x-y<=0;
prob.Constraints.c3 = x-b<=delta*ones(m*n,1);
prob.Constraints.c3 = -x+b<=delta*ones(m*n,1);
problem = prob2struct(prob);
problem.options=optimoptions("linprog",'Algorithm','interior-point',"Display","iter","OptimalityTolerance",OptTol,"ConstraintTolerance",ConTol);
x = linprog(problem);

t=cputime-t0;
 
%show figure
xx=reshape(x(1:m*n,1),m*dsz,n/dsz)*255;
newimage=blockproc(xx,[dsz*dsz,1],@(x)reshape(x.data,[dsz,dsz]));
imshow(uint8(newimage))
 
%calculate 
PSNR1 = 10*log10(m*n/norm(x(1:m*n,1)-u,2)^2);
PSNR2 = 10*log10(m*n/norm(u-b,2)^2);

%
bb=reshape(b,m*dsz,n/dsz)*255;
newimage=blockproc(bb,[dsz*dsz,1],@(x)reshape(x.data,[dsz,dsz]));
imshow(uint8(newimage));
 
