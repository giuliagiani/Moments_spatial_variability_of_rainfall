function [D1,D2]=moments_spatial_variability_of_rainfall(spatial_rainfall, flow_dist, area) 
%This function calculates the moments of spatial variability of rainfall
%(Zoccatelli et al., 2011) given:

%spatial_rainfall: a m x n matrix containing the rainfall intensity in mm/h
%for each pixel falling in the catchment area. Any pixel
%falling outside the catchment area should be filled with NaNs.

%flow_dist: a m x n matrix containing for each pixel falling in the
%catchment area the distance between the centroid of the pixel and the
%catchment outlet measured along the flow path in meters. Again, any 
%pixel falling outside the catchment area should be filled with NaNs.

%area: catchment area in km2.


P0=[];
P1=[];
P2=[];
g1=[];
g2=[];
D1=[];
D2=[];

sub_area=area./length(find(isnan(flow_dist)==0)); %dA [km2]

P0= nansum(nansum(spatial_rainfall.*sub_area))/area/1000; % Eq.4 order 0 [m/h]
P1= nansum(nansum(spatial_rainfall.*flow_dist.*sub_area))/area/1000;  % Eq.4 order 1 [m^2/h]
P2= nansum(nansum(spatial_rainfall.*(flow_dist.^2).*sub_area))/area/1000; %Eq. 4 order 2[m^3/h]
g1= nansum(nansum(flow_dist.*sub_area))/area; %Eq.2 order 0 [m]
g2= nansum(nansum((flow_dist.^2).*sub_area))/area; %Eq. 2 order 1[m^2]

D1=P1/(P0*g1); %Eq.5 
D2=(P2/P0-((P1/P0)^2))/(g2-(g1^2)); %Eq.5
end