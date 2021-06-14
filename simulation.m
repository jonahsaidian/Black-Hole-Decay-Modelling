%a black hole of mass ~500,000 Kg has lifetime of order 10 s
m=1e6; %units of kg
m0=m;
c=3e+8; %units of m/s
G=6.67e-11; %units of N (m/kg)^2
R=2*G*m/c/c*10^(24); %units of yocto meters
R0=R;
m_loss=1e2; %lost mass per particle
N=ceil(1400 *(R0/741)^(-2) ); 
%number of particle interaction per second calibrated with m=5e5kg with
%l=11s and scaling with the changing radius
S=100; %number of seconds to simulate
mvec=zeros(S,1);
for t=1:S
    mvec(t)=m;
    p=[];
    p=[3*R0*(rand(N,1).^2+rand(N,1).^2+rand(N,1).^2).^(1/2),rand(N,1)]; 
    % the location of each collision and its acceptance probability    
    count=0;
    for i=1:N
        if p(i,1)>R && p(i,1)^3 < (1/p(i,2)*R^3)
            count=count+1;
        elseif p(i,1)>R && R/R0< p(i,2)
            count=count+1;
        end
    end
    m=max(m-m_loss*count,0);
    R=2*G*m/c/c *10^(24);
    if m<10
        l=t;
        break
    end
end
T=0:S-1;
plot(T,mvec,'red')
hold on
%analytic solution
v=1/(15360*pi);
hb=1.05e-34;
a_l=ceil(8.407e-17*m0^3);
X=0:a_l;
mx=zeros(a_l,1);
for i=1:a_l+1
    mx(i)=(1/(8.4e-17)*(a_l-X(i)))^(1/3);
end
plot(X,mx)
xlabel('time in s')
ylabel('Mass in Kg')
