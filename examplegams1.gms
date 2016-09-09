SETS

i grade /A, B, C/
j products /whole, juice, paste/
q scenarios /lowest,lower, low,  normal, up, upper,uppest/;

PARAMETERS

k(q) percentage up or down in scenario q
/lowest -0.3
lower -0.2
low -0.1
normal 0
up 0.1
upper 0.2
uppest 0.3/

p(q) probability of event q
/lowest 0.004 
lower 0.054
low 0.242
normal 0.4
up 0.242
upper 0.054
uppest 0.004/

a(i) portion of grade i in pounds
/A 600000
B 2400000
C 80000/

b(j) demand of product j in pounds
/whole 14400000
juice 1000000
paste 2000000/

c(i) cost of products in dollars per pound
/ A 0.06
B 0.06
C 0.085/

s(j) selling price in dollars per pound of product j
/ whole 0.222222
juice 0.225
paste 0.152/

v(j) variable costs for product j
/whole 0.14
juice 0.159
paste 0.078/

h(i) grade classification of i
/ A 9
B 5
C 9/

g(j) grade requirement of product j
/whole 8
juice 6
paste 5/;

VARIABLES

x(i,j,q) portion of grade i to product j
y(j) amount of grade C tomatoes purchased
z total profit ;
Positive Variable x,y ;

Equations
profit	objective function
demand(j,q) the demand forecast of the products j
grade(j,q) satisfy grade requirements 
portionA(q) constraint to amount of A tomatoes available
portionB(q) constraint to amount of B tomatoes available
portionC(q) constraint to amount of C tomatoes available;

profit .. Z =e= sum((i,j,q), p(q)*(s(j)-v(j))*x(i,j,q))- c('A')*a('A') - c('B')*a('B')-sum((j,q),c('C')*x('C',j,q)*p(q));

demand(j,q) .. sum(i,x(i,j,q)) =l= b(j) ;
grade(j,q) .. x('A',j,q)*9+x('B',j,q)*5+x('C',j,q)*9 =g= g(j)*(x('A',j,q)+x('B',j,q)+x('C',j,q));
portionA(q) .. x('A','whole',q)+x('A','juice',q)+x('A','paste',q)=l=(1+k(q))*a('A');
portionB(q) .. x('B','whole',q)+x('B','juice',q)+x('B','paste',q)=l=3000000-(1+k(q))*a('A');
portionC(q) .. x('C','whole',q)+x('C','juice',q)+x('C','paste',q)=l=a('C'); 


Model project1 /all/
Solve project1 using lp maximizing z ;
Display x.l, x.m ;
