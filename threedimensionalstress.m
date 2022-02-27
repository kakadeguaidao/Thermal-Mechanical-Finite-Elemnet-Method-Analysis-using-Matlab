function [sigmavonmises]=threedimensionalstress(sigmax,sigmay,sigmaz,tauxy,tauyz,tauxz)

%Three Dimensional stress motion is exstrem and Von-mises critical stress
%values sub function.                             [A.Ö]-27.12.2006 (C)(R)
%_________Input Veriables
%[sigmax] :"x" axis direction normal stress
%[sigmay] :"y" axis direction normal stress
%[sigmaz] :"z" axis direction normal stress
%[tauxy] :"xy" surface shear stress
%[tauyz] :"yz" surface shear stress
%[tauxz] :"xz" surface shear stress
%_________Output Veriables
%[taumax]:  maximum shear stress
%[taumin]:  minimum shear stress
%[sigman1]: maximum normal stress value
%[sigman2]: median normal stress value
%[sigman3]: minimum normal stress value
%flag=0: exstrem stress values are real
%flag=1: exstrem stress values are complex (virtual)


jumper=0;
%Exstrem stresses values
I1= sigmax+sigmay+sigmaz ;
I2= sigmax*sigmay+sigmax*sigmaz+sigmay*sigmaz-tauxy^2-tauxz^2-tauyz^2 ;
I3= det ([sigmax tauxy   tauxz     ;
          tauxy  sigmay  tauyz     ;
          tauxz  tauyz   sigmaz] ) ;

%Matlab 7.01 symbolic tool box output
sigmas=[   1/6*(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)-6*(1/3*I2-1/9*I1^2)/(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+1/3*I1
         -1/12*(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+3*(1/3*I2-1/9*I1^2)/(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+1/3*I1+1/2*i*3^(1/2)*(1/6*(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+6*(1/3*I2-1/9*I1^2)/(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3))
         -1/12*(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+3*(1/3*I2-1/9*I1^2)/(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+1/3*I1-1/2*i*3^(1/2)*(1/6*(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3)+6*(1/3*I2-1/9*I1^2)/(-36*I2*I1+108*I3+8*I1^3+12*(12*I2^3-3*I2^2*I1^2-54*I2*I1*I3+81*I3^2+12*I3*I1^3)^(1/2))^(1/3))];
    

if jumper ~= 0 
sigmasr=sigmas;
else
sigmasr=real(sigmas);
end

sigman1= max(sigmasr);
sigman2= median(sigmasr);
sigman3= min(sigmasr);

%Exstrem stress values
ss=[sigman1
    sigman2
    sigman3];
   
%Maximum shear stress (Kn/m**2)
taumax=+(sigman1-sigman3)/2;
taumin=-(sigman1-sigman3)/2;

%Tansor= [sigmax   tauxy    tauxz 
%         tauxy    sigmay   tauyz
%         tauxz    tauyz   sigmaz];


%Von-mises critical strees value
sigmavonmises=sqrt(0.50*((sigman1-sigman2)^2+ ...
                         (sigman1-sigman3)^2+ ...
                         (sigman2-sigman3)^2));


