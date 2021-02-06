clear
clf

nx = 20;
ny = 20;
max_it = 1000;

V = zeros(nx,ny);

x_sum = 0;
y_sum = 0;
num_div = 0;

imboxfilt(V,3)
for i=1:max_it
   for m=1:nx
      for n=1:ny
        if(m == 1) %left
            x_sum = 1 + V(m+1,n);
        elseif(m == nx) %Right
            x_sum = 1 + V(m-1,n);
        else
            x_sum = V(m-1,n) + V(m+1,n); 
        end
        
        %{
        if(n == 1)
           y_sum = V(m,n+1);
           num_div = 3;
        elseif(n == ny)
           y_sum = V(m,n-1);
           num_div = 3;
        else
            y_sum = V(m,n+1) + V(m,n-1);
            num_div = 4;
        end
        %}
        
        if(n == 1)
           y_sum = 0;
           num_div = 4;
        elseif(n == ny)
           y_sum = 0;
           num_div = 4;
        else
            y_sum = V(m,n+1) + V(m,n-1);
            num_div = 4;
        end
        V(m,n) = (x_sum + y_sum)/num_div;
        
      end
      
      if mod(i,50) == 0
          figure(1)
          surf(V')
          pause(0.05)
      end
   end
end

V2 = zeros(nx, ny);
V2(1,:) = 1;

figure(3)
imboxfilt(V2,3)

[Ex, Ey] = gradient(V);

figure(2)
quiver(-Ey', -Ex', 1)
