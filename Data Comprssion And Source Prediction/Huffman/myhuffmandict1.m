function [dict,avglen] = myhuffmandict1(sym, prob, varargin)


variance = 'max';


% Create tree nodes with the symbols and the corresponding probabilities
huff_tree = struct('signal', [], 'probability', [],...
    'child', [], 'code', [], 'origOrder', -1);

for i = 1:length( sym )
    huff_tree(i).signal = sym{i}; 
    huff_tree(i).probability = prob(i); 
	huff_tree(i).origOrder = i;
end

% Sort the symbol and probability vectors based on ascending order of
% probability
[~, i] = sort(prob);
huff_tree = huff_tree(i);

% Create a Huffman tree
n_ary=2;
huff_tree = create_tree(huff_tree, n_ary, variance); 
% Create the codebook
[~,dict,avglen] = create_dict(huff_tree,{},0); 

% The next few lines of code are to sort the dictionary.
% If sorting based on original order then use dict{:,4}.
% If sorting based on the length of code, then use dict{:,3}.
[~, dictsortorder] = sort([dict{:,4}]);
lenDict = length(dictsortorder);
finaldict = cell(lenDict, 2);
for i=1:length(dictsortorder)
    finaldict{i,1} = dict{dictsortorder(i), 1};
    finaldict{i,2} = dict{dictsortorder(i), 2};
end
dict = finaldict;

%--------------------------------------------------------------------------
% Function: huff_tree
% Input: An array of structures to be arranged into a Huffman tree
% Utility: This is a recursive algorithm to create the Huffman Code
%          tree. This is a recursive function
function huff_tree = create_tree(huff_tree, n_ary, variance)

% if the length of huff_tree is 1, it implies there is no more than one
% node in the array of nodes. This is the termination condition for the
% recursive loop
numRemNodes = length(huff_tree);
if( numRemNodes <= 1)
    return;
end

% Combine the first C (lowest probability) nodes under one parent node,
% remove the C nodes from the list of nodes and add the new parent node
% that was just created. The C is chosen such that the number of nodes in
% the resultant list is an integer multiple of (n_ary-1) plus 1.
temp = struct('signal', [], 'probability', 0, ...
    'child', [], 'code', []);

numNodesToComb = rem(numRemNodes-1, n_ary-1) + 1;
if numNodesToComb == 1 % Must be true except for the first round
    numNodesToComb = n_ary;
end

for i = 1:numNodesToComb
    if isempty(huff_tree), break; end
    temp.probability = temp.probability + huff_tree(1).probability; % for ascending order
    temp.child{i} = huff_tree(1);
	temp.origOrder = -1;
    huff_tree(1) = [];
end

    huff_tree = insertMaxVar(huff_tree, temp);

% create a Huffman tree from the reduced number of free nodes
huff_tree = create_tree(huff_tree, n_ary, variance);

function huff_tree = insertMaxVar(huff_tree, newNode)
i = 1;
while i <= length(huff_tree) && ...
        newNode.probability > huff_tree(i).probability 
    i = i+1;
end
huff_tree = [huff_tree(1:i-1) newNode huff_tree(i:end)];


function [huff_tree,dict,total_wted_len] = create_dict(huff_tree,dict,total_wted_len)
if isempty(huff_tree.child)
    dict{end+1,1} = huff_tree.signal;
    dict{end, 2} = huff_tree.code;
    dict{end, 3} = length(huff_tree.code);
	dict{end, 4} = huff_tree.origOrder;
    total_wted_len = total_wted_len + length(huff_tree.code)*huff_tree.probability;
    return;
end
num_childrens = length(huff_tree.child);
for i = 1:num_childrens
    huff_tree.child{i}.code = [huff_tree(end).code, (num_childrens-i)];
    [huff_tree.child{i}, dict, total_wted_len] = ...
        create_dict(huff_tree.child{i}, dict, total_wted_len);
end

% [EOF]
