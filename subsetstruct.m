function s2 = subsetstruct(s1,is)
% SUBSETSTRUCT extract subset of each field of a structure.
%    s2 = subsetstruct(s1,is)
%    s1 = full structure
%    is = n-element logical vector of field elements to extract, where n is
%         size of dimension to use for extraction (max of 2 dimensions, and
%         extracts first dimension if size of both dim are same--use 
%         function twice in succession in this case)
%       = if index vector, converted to n-element logical vector assuming
%         maximum dimension of first field as size n
%         (use logical vector if this is not the case)
%    s2 = sub structure

% Copyright (c) 1994-2014 by Michael G. Kay
% Matlog Version 16 26-Jan-2015 (http://www.ise.ncsu.edu/kay/matlog)

% Input Error Checking ****************************************************
narginchk(2,2);
if ~isstruct(s1) || length(s1) ~= 1
   error('"s1" must be a single structure.')
end
% End (Input Error Checking) **********************************************

fn = fieldnames(s1);
s2 = s1;
for i = 1:length(fn)
   fv = getfield(s1,fn{i});
   if i == 1
      if islogical(is)       %Logical
         n = length(is(:));
         idx = find(is); % Use index instead of logical so that can have
                         % multiple values the same (e.g., if multiple
                         % cites the same in idx, then s = uscity(idx)
                         % gives s the same size as idx; using logical
                         % only gives the unique values in idx)
      else                   %Index
         n = length(fv);
         %is = idx2is(is,n);
         idx = is;
      end
   end
   if size(fv,1) == n
      s2 = setfield(s2,fn{i},fv(idx,:)); % is -> idx
   elseif size(fv,2) == n
      s2 = setfield(s2,fn{i},fv(:,idx)); % is -> idx
   else
      error('Length of "is" does not match any field dimensions.')
   end
end
