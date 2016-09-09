Sets
t time /t01*t11/

Scalars mu, r_0, m_0, m_dot, t_f, Ti, c_1,c_2,c_3, steplength;
mu=1.327*10**20;
r_0=1.496*10**11;
m_0=4.53*10**3;
m_dot=6.76*10**(-5);
t_f=1.660*10**7;
Ti=3.77;

c_1=Ti*r_0**2*(m_0*mu)**(-1);
c_2=m_dot*mu**(1/2)*(Ti*r_0**(1/2))**(-1);
c_3=t_f*mu**(1/2)*(r_0**(3/2))**(-1);

steplength = 0.1;

Parameters tau(t)  time span
/t01 0/;
loop(t, tau(t+1)  = tau(t) + steplength ) ;

Variables
z
x_1(t)           scaled radial distance from sun
x_2(t)           scaled radial component of speed
x_3(t)           scaled tangential component of speed
u(t)             angle of driving force;

POSITIVE VARIABLE x_1, x_2, x_3;

Equations
obj
x_1dx(t)         forward difference
x_2dx(t)         forward difference
x_3dx(t)         forward difference
equil        balance in centrifugal force
i1           initial radius
i2           initial radial speed
i3           initial tagential speed
f1           final radial speed
;

obj(t)$(ord(t) eq card(t)) .. z=e=x_1(t);
x_1dx(t)$(ord(t) ne card(t)) .. (x_1(t+1) - x_1(t))/steplength =e=
                                 c_3**2*x_2(t);
x_2dx(t)$(ord(t) ne card(t)) .. (x_2(t+1) - x_2(t))/steplength*x_1(t)**2 =e=
                                 x_3(t)**2*x_1(t) - 1 + (x_1(t)**2*sin(u(t)))/(1/c_1-c_2*c_3*tau(t));
x_3dx(t)$(ord(t) ne card(t)) .. (x_3(t+1) - x_3(t))/steplength*x_1(t) =e=
                                 -c_3**2*x_2(t)*x_3(t) + x_1(t)*c_3*cos(u(t))/(1/c_1-c_2*c_3*tau(t));
equil(t)$(ord(t) eq card(t)) .. x_3(t)**2*x_1(t) =e= 1;
i1(t)$(ord(t) eq 1) .. x_1(t) =e= 1;
i2(t)$(ord(t) eq 1) .. x_2(t) =e= 0;
i3(t)$(ord(t) eq 1) .. x_3(t) =e= 1;
f1(t)$(ord(t) eq card(t)) .. x_2(t) =e= 0;


Model satelite /all/;

Solve satelite using nlp maximizing z;

Display x_1.l, x_2.l, x_3.l, u.l, tau;
