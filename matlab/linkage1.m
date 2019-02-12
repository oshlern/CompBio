function gametevec = linkage1(phenotype,numberofgametes,sw)
%This function generates a user specified number of gametes from a
%user specified phenotype.  {B,D,S} are the dominant phenotypes for the 
%three individual traits, corresponding to alleles A, B and C for the three
%respective genes, while {H,L,T} are the recessive phenotypes,
%corresponding to alleles a, b and c respectively.  Each dominant phenotype
%is further specified as homozygous (BM, DM and SM) or heterozygous (BR,
%LR, TR).  The program uses prefixed relative distances
%between the genes for the three traits.  These distances are used to
%control the probability of crossover during the generation of gametes, but
%they are unknown to the user.  The resulting gametevec shows the
%occurences of different gametes in the following order: 
%{A,B,C}, {A,B,c}, {A,b,C}, {A,b,c}, {a,B,C}, {a,B,c}, {a,b,C}, {a,b,c}
%sw = 1; %BAC, CAB
%sw = 2; %ABC, CBA
%sw = 3; %ACB, BCA
%Typical application:
%
%gametevec = linkage1({'BR','DR','SR'},1000);
%

clc;
if sw==1,
    x = 7.1339;
    p = 0.134/(1+x);
elseif sw==2,
    x = 5.78;
    p = 0.187/(1+x);
elseif sw==3,
    x = 0.265;
    p = 0.217/(1+x);
else end
P1 = (1-p*x)*(1-p);
P2 = p*x*(1-p);
P3 = (1-p*x)*p;
P4 = x*p^2;
gametevec = zeros(1,8);
h = mnrnd(numberofgametes,[P1,P2,P3,P4]);
if sw==1,
    if strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SR'),
        gametevec(1) = binornd(h(1),0.5,1);
        gametevec(8) = h(1) - gametevec(1);
        gametevec(4) = binornd(h(4),0.5,1);
        gametevec(5) = h(4) - gametevec(4);
        gametevec(2) = binornd(h(2),0.5,1);
        gametevec(7) = h(2) - gametevec(2);
        gametevec(3) = binornd(h(3),0.5,1);
        gametevec(6) = h(3) - gametevec(3);
    elseif strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SM'),
        gametevec(1) = binornd(h(1)+h(2),0.5,1);
        gametevec(7) = h(1) + h(2) - gametevec(1);
        gametevec(3) = binornd(h(3)+h(4),0.5,1);
        gametevec(5) = h(3) + h(4) - gametevec(3);
    elseif strcmp(phenotype(1),'BM') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SR'),
        gametevec(1) = binornd(h(1)+h(4),0.5,1);
        gametevec(4) = h(1) + h(4) - gametevec(1);
        gametevec(2) = binornd(h(2)+h(3),0.5,1);
        gametevec(3) = h(2) + h(3) - gametevec(2);
    elseif strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DM') & strcmp(phenotype(3),'SR'),
        gametevec(1) = binornd(h(1)+h(3),0.5,1);
        gametevec(6) = h(1) + h(3) - gametevec(1);
        gametevec(2) = binornd(h(2)+h(4),0.5,1);
        gametevec(5) = h(2) + h(4) - gametevec(2);
    elseif strcmp(phenotype(1),'BM') & strcmp(phenotype(2),'DM') & strcmp(phenotype(3),'SR'),
        gametevec(1) = binornd(numberofgametes,0.5,1);
        gametevec(3) = numberofgametes - gametevec(1);
    elseif strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DM') & strcmp(phenotype(3),'SM'),
        gametevec(1) = binornd(numberofgametes,0.5,1);
        gametevec(2) = numberofgametes - gametevec(1);
    elseif strcmp(phenotype(1),'BM') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SM'),
        gametevec(1) = binornd(numberofgametes,0.5,1);
        gametevec(5) = numberofgametes - gametevec(1);
    elseif strcmp(phenotype(1),'BM') & strcmp(phenotype(2),'DM') & strcmp(phenotype(3),'SM'),
        gametevec(1) = numberofgametes;
    elseif strcmp(phenotype(1),'H') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SR'),
        gametevec(5) = binornd(h(1)+h(2),0.5,1);
        gametevec(8) = h(1) + h(2) - gametevec(5);
        gametevec(6) = binornd(h(3)+h(4),0.5,1);
        gametevec(7) = h(3) + h(4) - gametevec(6);
    elseif strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'L') & strcmp(phenotype(3),'SR'),
        gametevec(3) = binornd(h(1)+h(4),0.5,1);
        gametevec(8) = h(1) + h(4) - gametevec(3);
        gametevec(4) = binornd(h(2)+h(3),0.5,1);
        gametevec(7) = h(2) + h(3) - gametevec(4);
    elseif strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'T'),
        gametevec(3) = binornd(h(1)+h(3),0.5,1);
        gametevec(6) = h(1) + h(3) - gametevec(3);
        gametevec(4) = binornd(h(2)+h(4),0.5,1);
        gametevec(7) = h(2) + h(4) - gametevec(4);
    else end
elseif sw==2,
    if strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SR'),
        gametevec(1) = binornd(h(1),0.5,1);
        gametevec(8) = h(1) - gametevec(1);
        gametevec(3) = binornd(h(4),0.5,1);
        gametevec(6) = h(4) - gametevec(3);
        gametevec(2) = binornd(h(2),0.5,1);
        gametevec(7) = h(2) - gametevec(2);
        gametevec(4) = binornd(h(3),0.5,1);
        gametevec(5) = h(3) - gametevec(4);
    else end
elseif sw==3,
    if strcmp(phenotype(1),'BR') & strcmp(phenotype(2),'DR') & strcmp(phenotype(3),'SR'),
        gametevec(1) = binornd(h(1),0.5,1);
        gametevec(8) = h(1) - gametevec(1);
        gametevec(2) = binornd(h(4),0.5,1);
        gametevec(7) = h(4) - gametevec(2);
        gametevec(3) = binornd(h(2),0.5,1);
        gametevec(6) = h(2) - gametevec(3);
        gametevec(4) = binornd(h(3),0.5,1);
        gametevec(5) = h(3) - gametevec(4);
    else end
else end

disp(gametevec);
  
        

    

