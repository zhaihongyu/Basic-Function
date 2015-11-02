% Generathe the 4 basic moment tensor with random perforation
% 2015-11-2
function Gen_4MTs_RandPer()
% 4 basic seismic moment tensors 2015-11-2 %
M_ISO_Pos=2/3*[1 0 0;0 1 0;0 0 1];
M_ISO_Neg=-2/3*[1 0 0;0 1 0;0 0 1];
M_DC=[1 0 0;0 0 0;0 0 -1];
M_CLVD_Neg=2/3*[1 0 0;0 1 0;0 0 -2];
M_CLVD_Pos=2/3*[2 0 0;0 -1 0;0 0 -1];
% Identify random coefficient
Basic_Percent=0.7;

end