function temp= hashfun(val,l)

a=10^l;
b=10^(l-1);


temp=uint8((mod(val,a)-mod(val,b))/b);


end