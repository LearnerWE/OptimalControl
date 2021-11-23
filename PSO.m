
clear;
close all;

%% Problem Definition

Costfunction= @(x) costfunctionnrax(x);

nVar=70;                %number of dimensions/variables
Varsize=[1 nVar];       %Size of answer
Varmin=-10;             %Lower bound
Varmax=10;              %upper bound

%% Parameters of PSO

iter=100;       %number of iterations
npso=100;       %number of particles

kappa=1;
phi1=2.05;
phi2=2.05;
phi=phi1+phi2;
chi=2*kappa/abs(2-phi-sqrt(phi^2-4*phi));
w=chi;            %inertia
wdamp=.99;      %inertia
c1=chi*phi1;           %personal accelaration
c2=chi*phi2;           %social accelaration

%% Initialization

empty_particle.position=[];
empty_particle.velocity=[];
empty_particle.cost=[];
empty_particle.best.position=[];
empty_particle.best.cost=[];

particle=repmat(empty_particle,npso,1);
globalbest.cost=inf;

for i=1:npso
    
    particle(i).position=unifrnd(Varmin,Varmax,Varsize);
    particle(i).velocity=zeros(Varsize);
    particle(i).cost=sphere(particle(i).position);
    
    particle(i).best.position=particle(i).position;
    particle(i).best.cost=particle(i).cost;
    
    if particle(i).best.cost < globalbest.cost
        
        globalbest=particle(i).best;
        
    end
    
end
bestcosts=[iter,1];

%% PSO

for it=1:iter
    
    for i=1:npso
        
       particle(i).velocity = w*particle(i).velocity ...
       + c1*rand(Varsize).*(particle(i).best.position-particle(i).position)...
       + c2*rand(Varsize).*(globalbest.position-particle(i).position);   
       
       particle(i).position = particle(i).position + particle(i).velocity; 
       particle(i).cost= Costfunction(particle(i).position); 
       
       if particle(i).cost<particle(i).best.cost
           
           particle(i).best.position=particle(i).position;
           particle(i).best.cost=particle(i).cost;
           
           if particle(i).best.cost<globalbest.cost
               
               globalbest=particle(i).best;
               
           end
           
       end
       
    end
        bestcosts(iter)=globalbest.cost;
        disp(['iteration' num2str(it) ': best cost =' num2str(bestcosts(iter))]);
        %w=w*wdamp;
        
end
    


%% results



