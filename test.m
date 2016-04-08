rel_inp1=input('Enter the relation 1:','s');
rel_inp2=input('Enter the relation 2:','s');
Rsize=input('Record size of R:');
Ssize=input('Record size of S:');
Pgsize=input('Page size :');
Max_pg=input('Maximum pages :');
Max_hash=input('Max hash rounds :');

temp='C:\Users\Jigsaw\Desktop\';

file1=strcat(temp,rel_inp1);
file2=strcat(temp,rel_inp2);

R=dlmread(file1);
S=dlmread(file2);

Rsizerow=size(R);
Ssizerow=size(S);

Rsizerow=Rsize(1,1);
Ssizerow=Ssize(1,1);

Rrecperpg=uint8(Pgsize/Rsize);
Srecperpg=uint8(Pgsize/Ssize);

c=zeros(1,Max_pg-1);
c=c';
d=zeros(1,Max_pg-1);
d=d';
att1=input('Enter the attribute number in 1st relation :');
att2=input('Enter the attribute number in 2nd relation :');
l=1;

h(R,att1,S,att2,Rrecperpg,Srecperpg,Max_pg,Max_hash,l,Max_hash);
     