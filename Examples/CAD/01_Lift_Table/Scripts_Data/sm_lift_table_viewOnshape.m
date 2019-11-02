function sm_lift_table_viewOnshape(location)
% Copyright 2016-2019 The MathWorks, Inc.

lifttable_url = 'https://cad.onshape.com/documents/58482f0af680f5104c2aa092/w/9b3bf8832aeb649b3d37b8ac/e/a3bd178a78d47fa4ecdbc98a';
getAccount_url = 'https://www.onshape.com/cad-pricing?utm_campaign=Mathworks&utm_source=Referrals';

if(strcmp(location,'getAccount'))
    openUrl = getAccount_url;
else
    openUrl = lifttable_url;
end

if(ispc)
    eval(['!start chrome "' openUrl '"']);
elseif(ismac)
    eval(['!open -a "Google Chrome" ''' openUrl '''']);
end
