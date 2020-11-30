function [Y,Y2,types_row] = data_prep()
% This function prepares our data so that we every category is represented as a boolean.
% Returns two data matrices and a row with our types. The two data matrices correspond with the
% two approaches taken to turn the "legs" category into booleans.

data = importdata('zoo.data');

Y = data.data';
Y2 = data.data'; %Making an extra data matrix.
legs_row = Y(13,:);
types_row = Y(17,:);

[d,n] = size(Y);

%Removing the final row, and also the row with number of legs.
Y(17,:) = [];
Y(13,:) = [];
Y2(17,:) = [];

no_legs = zeros(1,n);
two_legs = zeros(1,n);
four_legs = zeros(1,n);
six_legs = zeros(1,n);
eight_legs = zeros(1,n);

%If the animal has 0 legs the no_legs vector will have a boolean 1 and 0
%otherwise, and so on for 2,4,6,8 legs.
for i=1:length(legs_row)
    if legs_row(i) == 0
       no_legs(i) = 1;
    elseif legs_row(i) == 2
        two_legs(i) = 1;
    elseif legs_row(i) == 4
        four_legs(i) = 1;
    elseif legs_row(i) == 6
        six_legs(i) = 1;
    elseif legs_row(i) == 8
        eight_legs(i) = 1;
    end
end

%Adding our new boolean vectors to our data matrix.
Y = [Y;no_legs;two_legs;four_legs;six_legs;eight_legs];


%On our backup data instead we set the boolean to be true if the animal has
%any legs, and 0 if it has none. 
for i=1:length(Y2(13,:))
    if Y2(13,i) >0
        Y2(13,i) = 1;
    end
end


end

