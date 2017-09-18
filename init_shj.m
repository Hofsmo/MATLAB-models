%% Initialize the  power system
PID_parameters;
Ysp=0;
backlash=0;
Ty = 0.2;
Tw = 1.2/2;
Tw2 = Tw;
Tdel=0;
A = 100;

D = 50;
Kd = 0.1; 
W0 = 0.01;

f0 = 50;

M1 = 300;
H = 3;
H1=2.7;
M2 = A*M1;
H2 = A*H;
Kd2 = A*Kd;

S_base = M1+M2;
n_p = 1e-2;

Um = 20;
Ub = 400;
k = M1/S_base*Ub^2/Um^2;
k2 = M1/S_base*Ub^2/Um^2;

x1 = 50;
x2 = 50;
xd1 = 0.2*k;
xd2 = 0.2*k2/A;

xtot = x1+x2+xd1+xd2;

b1 = 1/x1;  
b2 = 1/x2;
bd1 = 1/xd1;
bd2 = 1/xd2;

%% Matrix crap
B = [bd1, 0, -bd1, 0, 0;
    0, bd2, 0, -bd2 0;
    -bd1, 0, bd1 + b1, 0, -b1;
    0, -bd2, 0, bd2+b2, -b2;
    0, 0, -b1, -b2, b1+b2];
Y11 = B(1:2,1:2);
Y12 = B(1:2, 3:5);
Y21 = B(3:5, 1:2);
Y22 = B(3:5, 3:5);
X22 = inv(Y22);

K11 = bd1*(1-bd1*X22(1,1));
K12 = bd1*bd2*X22(1,2);
K13 = bd1*X22(1,3);

K22 = bd2*(1-bd2*X22(2,2));
K21 = bd1*bd2*X22(2,1);
K23 = bd2*X22(2,3);

%% Simulation parameters
T = 1800;
Ts = 0.02;
t = 0:Ts:T;

el = 0.5;
vl = timeseries(el*randn(T/Ts+1,1),t);

e1 = el*1e-3;
v1 = timeseries(e1*randn(T/Ts+1,1),t);

e2 = el*1e-3;
v2 = timeseries(e2*randn(T/Ts+1,1),t);