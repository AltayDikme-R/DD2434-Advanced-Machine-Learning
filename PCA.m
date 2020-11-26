close all
clear all


[Y,Y2,types_row] = data_prep();


%%
%Centering our data

[d,n] = size(Y);
Y_mean = (1/n)*Y*ones(n,n);
Y_cent = Y-Y_mean;

[d,n] = size(Y2);
Y2_mean = (1/n)*Y2*ones(n,n);
Y2_cent = Y2-Y2_mean;


%%
%Singular Value Decomposition

[U,S,V] = svd(Y_cent);
[U2,S2,V2] = svd(Y2_cent);

%%
%Creating an auxhilliary object to write the diagonal as a vector.
vec_S = diag(S);
vec_S2 = diag(S2);

%Looking at the log plot of the singular values. 
figure(1)
plot(1:length(vec_S),log(vec_S),'*');
xlabel('Number of principal components, k','Fontsize',18)
ylabel('log(\sigma_i )','Fontsize',18)


figure(2)
plot(1:length(vec_S2),log(vec_S2),'*');
xlabel('Number of principal components, k','Fontsize',18)
ylabel('log(\sigma_i )','Fontsize',18)
% Determining how much of the data variance is explained by choosing k=2
% principal components.
squared = vec_S.^2;
disp(sum(squared(1:6))/sum(squared))

squared2 = vec_S2.^2;
disp(sum(squared2(1:6))/sum(squared2))



%%
%Choosing 2 dimensions since we want to be able to plot it. 
U_k = U(:,1:2);
U_k2 = U2(:,1:2);

X = U_k'*Y;
x = X(1,:);
y = X(2,:);

figure(3)
h = gscatter(x,y,types_row);
h(3).Color = 'k';
legend('Location','northeastoutside')
xlabel('k_1')
ylabel('k_2')


X2 = U_k2'*Y2;
x2 = X2(1,:);
y2 = X2(2,:);

hold on
figure(4)
g = gscatter(x2,y2,types_row);
g(3).Color = 'k';
legend('Location','northeastoutside')
xlabel('k_1')
ylabel('k_2')

