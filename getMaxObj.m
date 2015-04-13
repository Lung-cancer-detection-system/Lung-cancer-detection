function maximg = getMaxObj(X)
%Function to keep only the maximum sized (biggest) object in an image
%SCd 11/30/2010
%
%Updates:
%   -02/03/2011: Added ability to handle an image directly
%
%Usage:
%   Imx = keepMaxObj(CC);
%   Imx = keepMaxObj(V);
%
%Input Arguments:
%   -CC: Connected components returned from bwconncomp
%   -V: Logical image with parts you want true
%   
%Output Arguments:
%   -Imx: Logical volume with only the biggest object left true.
%
%See Also: bwconncomp
%
      %Error checking:
      assert(islogical(X)||isstruct(X),'The first input argument is expected to be a struct or a logical');
      if isstruct(X)
          CC = X;
          parts = {'PixelIdxList','ImageSize'};
          assert(all(ismember(parts,fieldnames(CC))),'CC is expected to be the output from bwconncomp');
      else
          CC = bwconncomp(X);
      end  
      clear X;
      %Preallocate and find number of voxels/object
      Nvox = zeros(CC.NumObjects,1);
      for ii = 1:CC.NumObjects
          Nvox(ii) = numel(CC.PixelIdxList{ii});
      end
      %Find the biggest object's index, warn and save all if there are multiples
      [mx,midx] = max(Nvox);
      more_than1_max = sum(mx==Nvox);
      if more_than1_max > 1
          midx = find(mx == Nvox);
          warning('Multiple:Maxima', 'There were %i objects with the maximum size.\n  They are all left on!',more_than1_max);
      end    
      %Create the final image
      maximg = false(CC.ImageSize);
      maximg([CC.PixelIdxList{midx}]) = true;
end