function error = costfunctionnrax(x)

rng('default')
input=10*rand(6,1000);
target=10*rand(1000);
z=ones(10,1);



for i=1:1000


for n=0:9
    
    z(n+1,1)= tanh(x(1+n*6)*input(1,i)+x(2+n*6)*input(2,i)+x(3+n*6)*input(3,i)+ ...
    x(4+n*6)*input(1,i)+x(5+n*6)*input(2,i)+x(6+n*6)*input(3,i))*x(n+61);
    
end


val = z(1,1)+z(2,1)+z(3,1)+z(4,1)+z(5,1)+z(6,1)+z(7,1)+z(8,1)+z(9,1)+z(10,1);
error = + (val-target(i))^2;

end
end