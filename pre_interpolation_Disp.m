function [pre_exact]=pre_interpolation_Disp(gcoord)
    
 [sdof,nx]=size(gcoord);
 pre_exact=zeros(sdof,1);
  load reference_D;
  stress_ref=reference(:,4);
  gcoord_1=reference(:,1:3);
    for i1=1:sdof
    	for k=1:size(gcoord_1,1) 
	          rr(k)=sqrt(((gcoord(i1,1)-gcoord_1(k,1))^2+(gcoord(i1,2)-gcoord_1(k,2))^2+(gcoord(i1,3)-gcoord_1(k,3))^2));
        end
       [series,dddd]=sort(rr);  
       if series(1)<10^-10
           pre_exact(i1,1)=stress_ref(dddd(1));
       else    
       
       weight1=1/series(1); weight2=1/series(2); 
       weight3=1/series(3); weight4=1/series(4);
       weight5=1/series(5); weight6=1/series(6);
       weight=weight1+weight2+weight3+weight4+weight5+weight6;

       pre_exact(i1,1)=weight1*stress_ref(dddd(1))+ weight2*stress_ref(dddd(2))+ weight3*stress_ref(dddd(3))+  weight4*stress_ref(dddd(4))...
           +weight5*stress_ref(dddd(5))+weight6*stress_ref(dddd(6));
       
       pre_exact(i1,1)=pre_exact(i1,1)/weight;       
       end
    end