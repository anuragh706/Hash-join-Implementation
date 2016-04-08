function h(R,att1,S,att2,Rrecperpg,Srecperpg,Max_pg,Max_hash,l,Fmax)
   
Rsize=size(R);
Ssize=size(S);

Rsize=Rsize(1,1);
Ssize=Ssize(1,1);

c=zeros(1,Max_pg-1);
c=c';
d=zeros(1,Max_pg-1);
d=d';

disp( sprintf( 'Hashing round %d \n', l ) );
disp( sprintf( 'Reading reltion 1 \n' ) );
    for i=1:Rsize
   
    temp=R(i,att1);
    
   hash=mod(hashfun2(temp,Max_pg,l),Max_pg-1);
   
   if(c(hash+1,1)~=0 && mod(c(hash+1,1),Rrecperpg)==0)
        disp( sprintf( 'Page for bucket %d full. Flushed to secondary storage.  \n',hash+1 ) );
   end    
   
   disp( sprintf( 'Tuple %d : %d mapped to bucket : %d  \n',i,temp,hash+1 ) );
   
        Rbuck(hash+1,c(hash+1,1)+1)=temp;
        
        c(hash+1,1)=c(hash+1,1)+1;
         

    
    end
    disp( sprintf( 'Done with relation 1  \n' ) );
  %%  Rbuck
   %% c
    disp( sprintf( 'Reading reltion 2 \n' ) );
   
    for j=1:Ssize
   
        
     temp1=S(j,att2);
     
     
  hash=mod(hashfun2(temp1,Max_pg,l),Max_pg-1);
  
     if(d(hash+1,1)~=0 && mod(d(hash+1,1),Rrecperpg)==0)
        disp( sprintf( 'Page for bucket %d full. Flushed to secondary storage.  \n',hash+1 ) );
     end  
     
     
   disp( sprintf( 'Tuple %d : %d mapped to bucket : %d  \n',j,temp1,hash+1 ) );
   
        Sbuck(hash+1,d(hash+1,1)+1)=temp1;
        d(hash+1,1)=d(hash+1,1)+1;
   
  

    
    
    end
    
    disp( sprintf( 'Done with relation 2  \n' ) );
    
    for chk1=1:Max_pg-1
        
         disp( sprintf( 'Relation 1,Round %d,Bucket %d : %d pages \n',l,chk1,ceil(c(chk1,1)/Rrecperpg) ) );
        
    end
    
    
    for chk2=1:Max_pg-1
        
         disp( sprintf( 'Relation 2,Round %d,Bucket %d : %d pages \n',l,chk2,ceil(d(chk2,1)/Srecperpg) ) );
        
    end
   %% Sbuck
   %% d
   cols1=size(R);
   cols1=cols1(1,2);
   cols2=size(S);
   cols2=cols2(1,2);
  %{
   for tt=1:Max_pg-1
       
       disp( sprintf( 'Bucket %d  \n  R1 keys :',tt ));
       for kl=1:c(tt,1)
        
         disp( sprintf( '%d, ',Rbuck(tt,kl) ));
       
       
       end
        disp( sprintf( 'Pages :%d \n R2 Keys :',ceil(c(tt,1)/Rrecperpg)));
       
       for ql=1:c(tt,1)
        
         disp( sprintf( '%d, ',Sbuck(tt,ql) ));
       
       
       end
       
       disp( sprintf( 'Pages :%d \n',ceil(d(tt,1)/Srecperpg)));
       
       if(ceil(c(tt,1)/Rrecperpg)+ ceil(d(tt,1)/Srecperpg)< Max_pg)  
        
           disp( sprintf( 'In memory join :yes\n' ));
           
       else 
           disp( sprintf( 'In memory join: No' ));

           
       end
   end
   %}
    for k=1:Max_pg-1
       
    p1=ceil(c(k,1)/Rrecperpg);
    p2=ceil(d(k,1)/Srecperpg);
  %% p1+p2
 
  
    if(ceil(c(k,1)/Rrecperpg)+ ceil(d(k,1)/Srecperpg)< Max_pg)   
        disp( sprintf( 'Total pages in bucket %d : %d pages, Therefore memory join possible!!! \n',k,ceil(c(k,1)/Rrecperpg)+ ceil(d(k,1)/Srecperpg) ) );
        for q=1:c(k,1)
           for w=1:d(k,1)
               
                    if(Rbuck(k,q)==Sbuck(k,w))
                       
                        check1=find(R==Rbuck(k,q));
                        
                        k1=size(check1);
                        check2=find(S==Rbuck(k,q));
                        k2=size(check2);
                        
                        for t1=1:k1
                           
                            for t2=1:k2
                            
                                disp(cat(2,R(check1(t1,1),1:cols1),S(check2(t2,1),1:cols2)));
                                
                                
                            end
                            
                        end
                        
                        
                    end
           
           end
            
        end
        
        
    elseif(Max_hash>0)
       disp( sprintf( 'Bucket %d total size is %d pages,therefore No inmemory join ',k,ceil(c(k,1)/Rrecperpg)+ ceil(d(k,1)/Srecperpg) ) );
        Rbucknew=Rbuck(k,1:c(k,1))';
        Sbucknew=Sbuck(k,1:d(k,1))';
        h(Rbucknew,1,Sbucknew,1,Rrecperpg,Srecperpg,Max_pg,Max_hash-1,l+1,Fmax);
        
    end
    
    end
        
end