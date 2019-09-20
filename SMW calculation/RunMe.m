M=zeros();
P=zeros();
Q=zeros();

%in every case i the order of the operation is the following:
%create the accurate solution of every codition (if it's the same only one time)
%1.create the A array using Mx_Make_77
%(initialize A for the CollegeMSG case) 
%2.calculate b using the accurate x
%3.calculate the solution using Sherman-MOrrison function(SMW_solve77)
%4.calculate d front/back errors using function d_errors_calc
%5.calculate x using Matlabs built in method
%6.calculate the errors for the matlabs built in method using d_errors_calc

xsol=x_Constructor(64);

%hadamard
A_had=Mx_Make_77('had',64);
b_had=A_had*xsol;
my_xsol_had=SMW_solve_77(A_had,b_had,M,P,Q,'colwise');
[my_d_had,my_es_had,my_ps_had,my_absE_had]=d_errors_calc(A_had,my_xsol_had,b_had,xsol);
x_had=A_had\b_had;
[d_had,es_had,ps_had,absE_had]=d_errors_calc(A_had,x_had,b_had,xsol);

%trihad
A_trihad=Mx_Make_77('trihad',64);
b_trihad=A_trihad*xsol;
my_xsol_trihad=SMW_solve_77(A_trihad,b_trihad,M,P,Q,'colwise');
[my_d_trihad,my_es_trihad,my_ps_trihad,my_absE_trihad]=d_errors_calc(A_trihad,my_xsol_trihad,b_trihad,xsol);
x_trihad=A_trihad\b_trihad;
[d_trihad,es_trihad,ps_trihad,absE_trihad]=d_errors_calc(A_trihad,x_trihad,b_trihad,xsol);

%toep
A_toep=Mx_Make_77('toep',64);
b_toep=A_toep*xsol;
my_xsol_toep=SMW_solve_77(A_toep,b_toep,M,P,Q,'colwise');
[my_d_toep,my_es_toep,my_ps_toep,my_absE_toep]=d_errors_calc(A_toep,my_xsol_toep,b_toep,xsol);
x_toep=A_toep\b_toep;
[d_toep,es_toep,ps_toep,absE_toep]=d_errors_calc(A_toep,x_toep,b_toep,xsol);

%mc
xsol=x_Constructor(400);
A_mc=Mx_Make_77('mc',400);
b_mc=A_mc*xsol;
my_xsol_mc=SMW_solve_77(A_mc,b_mc,M,P,Q,'colwise');
[my_d_mc,my_es_mc,my_ps_mc,my_absE_mc]=d_errors_calc(A_mc,my_xsol_mc,b_mc,xsol);
x_mc=A_mc\b_mc;
[d_mc,es_mc,ps_mc,absE_mc]=d_errors_calc(A_mc,x_mc,b_mc,xsol);

%wathen
xsol=x_Constructor(443);
A_wathen=Mx_Make_77('wathen',12);
b_wathen=A_wathen*xsol;
my_xsol_wathen=SMW_solve_77(A_wathen,b_wathen,M,P,Q,'colwise');
[my_d_wathen,my_es_wathen,my_ps_wathen,my_absE_wathen]=d_errors_calc(A_wathen,my_xsol_wathen,b_wathen,xsol);
x_wathen=A_wathen\b_wathen;
[d_wathen,es_wathen,ps_wathen,absE_wathen]=d_errors_calc(A_wathen,x_wathen,b_wathen,xsol);

%CollegeMsg
xsol=x_Constructor(1899);
A_colmsg=Mx_Make_77('CollegeMSG',1);
A_colmsg=eye(1899)-0.85*A_colmsg;
b_colmsg=A_colmsg*xsol;
my_xsol_colmsg=SMW_solve_77(A_colmsg,b_colmsg,M,P,Q,'colwise');
[my_d_colmsg,my_es_colmsg,my_ps_colmsg,my_absE_colmsg]=d_errors_calc(A_colmsg,my_xsol_colmsg,b_colmsg,xsol);
x_colmsg=A_colmsg\b_colmsg;
[d_colmsg,es_colmsg,ps_colmsg,absE_colmsg]=d_errors_calc(A_colmsg,x_colmsg,b_colmsg,xsol);



%-------------------------------------->
%function to construct the accurate x
%takes sa input the size of the x (depends on A matrix)
function xsol=x_Constructor(size)
    xsol=zeros(size,1);
    for i=1:size
        if isequal(mod(i,2),0)
            xsol(i)=i;
        else
            xsol(i)=(-1)^(i+1)*(1/2*i);
        end
    end
end

%--------------------------------------->
%function that calculates d, front error, back error
%inputs: A calculated depending on the case
%and vector b which is calculated 
function [d,es,ps,absE]=d_errors_calc(A,my_xsol,b,xsol)
    d=cond(A,Inf);
    ps=normest(A*my_xsol-b)/(normest(A)*normest(my_xsol)+normest(b));
    es=2*d*ps; 
    absE=norm(xsol-my_xsol,inf)/norm(my_xsol,inf);
end







