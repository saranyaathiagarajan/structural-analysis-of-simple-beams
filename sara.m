lob = input("enter the length of beam\n")
nof = input("enter the number of point forces\n")
forces = zeros(1,nof+1)
vofs = zeros(1,nof+1)
i =1
while i<= nof

fprintf("enter the value of force %d",i)
forces(i)=input("\n")
fprintf("enter the position of the force %d to act in meters from origin",i)
vofs(i)=input("\n")
i = i +1
end
Rb=0
i =1
while i<=nof
    
     Rb =Rb + forces(i)*vofs(i)
      i=i+1
end
Rb = -(Rb/lob)
i=0
Ra = 0
while i<=nof
     i =i+1
     Ra = Ra + forces(i)
end
Ra = -(Ra + Rb)
i=1
vofs(nof +1 ) = lob
syms x

while i<=(nof + 1)
if i == 1
sf(i) = Ra
y=piecewise(0<x<vofs(i) , sf(i))
fplot(y)
hold on
end
if i > 1
sf(i)= -(sf(i-1) + forces(i-1))
y=piecewise(vofs(i -1) <x< vofs(i) ,sf(i))
fplot(y)
hold on
end
i=i+1
end
model = createpde('structural','static-solid');
i=0
ref1 = zeros(1,nof+1)
ref2 = zeros(1,nof+2)
 while i<=nof
if i == 0
ref1(i + 1)= 0
end
if i > 0
ref1(i+1)=vofs(i);
end
i=i+1
 end
i=0
while i<=nof+1
if i == 0
ref2(i + 1)= 0
end
if i > 0
ref2(i+1)=vofs(i);
end
i=i+1
end
i=1
while i <= nof +1
d(i) = ref2(i+1) - ref2(i)
i=i+1
end
 
 gm = multicuboid(1,0.25,d,'ZOffset',ref1)
 rotate(gm,90,[0 0 0],[0 1 0]);
 model.Geometry = gm
 pdegplot(model,'VertexLabels','on','FaceAlpha',0.5)
 
 a=4
 structuralBC(model , 'Edge',4 ,'Constraint','fixed');
 
 




