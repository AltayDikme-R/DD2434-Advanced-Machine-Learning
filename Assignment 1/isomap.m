close all
clear all

%Preparing the data
[Y,Y2,types_row] = data_prep();

%%
%Determining the squared euclidean pairwise distances
dist = pdist(Y','squaredeuclidean');
D = squareform(dist);

dist2 = pdist(Y2','squaredeuclidean');
D2 = squareform(dist2);

%Determining the k-nearest neighbors
k = 15;
for j=1:length(D)
    [maxval, idx] = sort(D(j,:),'ascend');

    zero_idx = find(maxval == 0);
    maxval(zero_idx)=[];
    idx(zero_idx)=[];
    %neighbors = idx(1:k);
    idx(1:k) = [];
    for i=1:length(idx)
        D(j,idx(i))=0;
    end
end

for j=1:length(D2)
    [maxval, idx] = sort(D2(j,:),'ascend');

    zero_idx = find(maxval == 0);
    maxval(zero_idx)=[];
    idx(zero_idx)=[];
    %neighbors = idx(1:k);
    idx(1:k) = [];
    for i=1:length(idx)
        D2(j,idx(i))=0;
    end
end

%Recreating our distance matrix so that it is symmetric.
D = triu(D)+triu(D)';
D2 = triu(D2)+triu(D2)';

%Our graphs
G = graph(D);
G2 = graph(D2);

%Plots of the graphs in order to see if they are connected or not.
figure(1)
plot(G);

figure(2)
plot(G2);

%Creating distance matrix using Djikstra's algorithm. 
%Sets inf and nan to zero in cases where we have disconnected graphs.
d = distances(G,'Method','positive');
d(isinf(d)|isnan(d)) = 0;

d2 = distances(G2,'Method','positive');
d2(isinf(d2)|isnan(d2)) = 0;


%%
%MDS implementation on our new distance matrices.

n = length(d);
n2 = length(d2);

%Centering of data
row_mean = (1/n)*d*(ones(n,1)*ones(n,1)');
col_mean = (1/n)*(ones(n,1)*ones(n,1)')*d;
tot_mean = (1/n^2)*(ones(n,1)*ones(n,1)')*d*(ones(n,1)*ones(n,1)');

row_mean2 = (1/n2)*d2*(ones(n2,1)*ones(n2,1)');
col_mean2 = (1/n2)*(ones(n2,1)*ones(n2,1)')*d2;
tot_mean2 = (1/n2^2)*(ones(n2,1)*ones(n2,1)')*d2*(ones(n2,1)*ones(n2,1)');

cent = d-col_mean-row_mean+tot_mean;
cent2 = d2-col_mean2-row_mean2+tot_mean2;


S = -(0.5)*cent;
S2 = -(0.5)*cent2;

%Eigenvalue decomposition
[U,L] = eig(S); 
[U2,L2] = eig(S2); 

X = sqrt(L)*U';
x = X(1,:);
y = X(2,:);

figure(3)
h = gscatter(x,y,types_row);
h(3).Color = 'k';
legend('Location','northeastoutside')
xlabel('k_1')
ylabel('k_2')


X2 = sqrt(L2)*U2';
x2 = X2(1,:);
y2 = X2(2,:);

figure(4)
k = gscatter(x2,y2,types_row);
k(3).Color = 'k';
legend('Location','northeastoutside')
xlabel('k_1')
ylabel('k_2')