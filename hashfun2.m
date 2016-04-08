function ret=hashfun2(val,Max_pg,l)

temp=dec2bin(val);
temp2=size(temp);
%%temp2
temp4=Max_pg-1+l;
if(temp2(1,2)<temp4)

   temp=cat(2,zeros(1,temp4-temp2(1,2)),temp);
   
end
%%temp

g=size(temp);

newstr=temp(1,g(1,2)-temp4+1:g(1,2));

ret=bin2dec(newstr);

end