%IMP: we need PDE TOOLBOX to run this code
%this is an attempt to analysis simple beam with point forces
%please follow the comments and instructions ,else the code goes wrong
%please use clear command before every attempt ,logged date causes problem.
%please dont apply forces on the supports
display("PLEASE READ THIS INSTRUCTION WITH CARE")
display("IMP we need PDE TOOLBOX to run this code")
display("this is an attempt to analysis simple beam with point forces")
display("please follow the comments and instructions ,else the code goes wrong")
display("please use clear command before every attempt ,logged date causes problem.")
display("please dont apply forces on the supports ")

lob = input("enter the length of beam in meter\n")
nof = input("enter the number of point forces ")
% but all other answers tht is displayed will follow the right hand
% convection only ,it is only for the users convenience.
forces = zeros(1,nof+1)
vofs = zeros(1,nof+1)
i =1
while i<= nof

fprintf("enter the value of force %d ( + ve if downward ,- ve if upward \n) in N",i)
forces(i)=input("\n")
fprintf("enter the position of the force %d to act in meters from origin(move from the orign (ascending order)",i)
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
xlim([0 lob+1])
ylim([-1000,1000])


while i<=(nof + 1)
if i == 1
sf(i) = - Ra
end
if i > 1
sf(i)=- (-sf(i-1) + forces(i-1))
end
i=i+1
end
Ra=-Ra
Rb=-Rb

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
 figure(2)
 gm = multicuboid(1,0.25,d,'ZOffset',ref1)
 rotate(gm,90,[0 0 0],[0 1 0]);
 model.Geometry = gm
 pdegplot(model,'VertexLabels','on','FaceAlpha',0.5)
  structuralBC(model , 'Edge',4 ,'Constraint','fixed');
 
 a = 4
 i=0
while i <= nof
if i==0
a=a+2;
end
if i>0
a=a+8;
end
i=i+1;
end
structuralBC(model , 'Edge',a,'Constraint','fixed');
 
b = 5
i = 1

while i<=nof
structuralBoundaryLoad(model,'Vertex',b,'Force',[0;forces(i);0])
b=b+4;
i=i+1;
end 
generateMesh(model);
figure
pdeplot3D(model)
title('Mesh with Quadratic Tetrahedral Elements');
structuralProperties(model,'YoungsModulus',201E9,'PoissonsRatio',0.3);
result = solve(model)
figure
pdeplot3D(model,'ColorMapData',result.Displacement.ux)
title('x-displacement')
colormap('jet')
figure
pdeplot3D(model,'ColorMapData',result.Displacement.uz)
title('z-displacement')
colormap('jet')
figure
pdeplot3D(model,'ColorMapData',result.VonMisesStress)
title('von Mises stress')
colormap('jet')
display("THEREFORE I HAVE DONE A SIMPLE BEAM ANALYSIS FOR POINT FORCES")
display("AND HAVE PRODUCED THE FOLLOWING RESULTS")
display("1.SHEAR FORCE AT ALL POINT IN BEAM")
display("2.MESH OD THE BEAM")
display("3. DEFLECTION ABOUT X AXIS")
display("4. DEFLECTION ABOUT Z AXIS")
display("5. VON MISES STRESS")
i = 1
while i<= (nof +1)
if i == 1
fprintf("shear force between at origin and %f  = %f in N",vofs(i),sf(i))
end
if i > 1
fprintf("shear force between at %f and %f  = %f in N",vofs(i-1),vofs(i),sf(i))
end
i=i+1
end
display("THANKYOU")
display("190103086")
display("SARANYAA.RT")
display("clear")
display("clc")
display("pls contact the student in case of discrepancies")




