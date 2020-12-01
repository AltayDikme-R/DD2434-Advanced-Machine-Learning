close all
clear all

[Y,Y2,types_row] = data_prep();

%%
%Creating distance matrix
D = squareform(pdist(Y'));
D2 = squareform(pdist(Y2'));
n = length(D);  %Finding dimension of the dist. matrix (nxn)
n2 = length(D2);



%Double centering trick.
row_mean = (1/n)*D*(ones(n,1)*ones(n,1)');
col_mean = (1/n)*(ones(n,1)*ones(n,1)')*D;
tot_mean = (1/n^2)*(ones(n,1)*ones(n,1)')*D*(ones(n,1)*ones(n,1)');

row_mean2 = (1/n2)*D*(ones(n2,1)*ones(n2,1)');
col_mean2 = (1/n2)*(ones(n2,1)*ones(n2,1)')*D;
tot_mean2 = (1/n2^2)*(ones(n2,1)*ones(n2,1)')*D*(ones(n2,1)*ones(n2,1)');

cent = D-col_mean-row_mean+tot_mean;
cent2 = D2-col_mean2-row_mean2+tot_mean2;
%Creating the similarity matrix. 
S = -(0.5)*cent;
S2 = -(0.5)*cent2;

%Eigendecomposition of the similarity matrix
[U,L] = eig(S); 
[U2,L2] = eig(S2); 

%Plot for Dataset1
X = sqrt(L)*U';
x = X(1,:);
y = X(2,:);

figure(1)
h = gscatter(x,y,types_row);
h(3).Color = 'k';
legend('Location','northeastoutside')
xlabel('k_1')
ylabel('k_2')

%Plot for Dataset 2
X2 = sqrt(L2)*U2';
x2 = X2(1,:);
y2 = X2(2,:);

figure(2)
g = gscatter(x2,y2,types_row);
g(3).Color = 'k';
legend('Location','northeastoutside')
xlabel('k_1')
ylabel('k_2')
