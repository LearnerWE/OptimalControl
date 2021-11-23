clc;
clear all;
close all;
A = [0 1 0 0; -1.42e10 -75.263 7.71e7 192.4736; 0 0 0 1; 87.71e7 -207.526 -1.256e10 -120.52];
B = [0 ;17.54e7 ;0 ;0 ];
C =[1 0 0 0];
D = [0];
X0 = [0;0;0;0];
sys=ss(A,B,C,D);

%poleplacement
p1= -80+1000i;
p2= -80-1000i;
p3= -20+1000i;
p4= -20-1000i;
p = [p1 p2 p3 p4];
k = place(A,B,p);
sys_cl=ss(A-B*k,B,C,D);
closedlooppoles1=eig(A-B*k);

%quadrature

Q = C'*C;
R =[1];
[k1,S,CLP]=lqr(A,B,Q,R);
sys_cl2=ss(A-B*k1,B,C,D);
closedlooppoles2=eig(A-B*k1);

Q = C'*C;
R =[100];
[k2,S,CLP]=lqr(A,B,Q,R);
sys_cl3=ss(A-B*k2,B,C,D);
closedlooppoles3=eig(A-B*k2);

Q = 100*C'*C;
R =[1];
[k3,S,CLP]=lqr(A,B,Q,R);
sys_cl4=ss(A-B*k3,B,C,D);
closedlooppoles4=eig(A-B*k3);

Q = C'*C;
R =[1];
[k1,S,CLP]=lqr(A,B,Q,R);
sys_cl5=ss(A-B*k1,B,C,D);
closedlooppoles1=eig(A-B*k1);

%model for kalman
vd = 1000*eye(4);
vn = 1;
BF = [B vd 0*B];
DF = [0 0 0 0 0 vn];
sys1 = ss(A,BF,C,DF);
fullsys= ss(A,BF,eye(4),zeros(4,size(BF,2)));

%kalman filter

[Kf,P,E] = lqe(A,vd,C,vd,vn);
syskf = ss(A-Kf*C,[B Kf],eye(4),0*[B Kf]);







