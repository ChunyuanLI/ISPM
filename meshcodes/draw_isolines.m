function [handle,S]=draw_isolines(triang_faces,vertices,values,Nlines)
% [handle]=draw_isolines(triang_faces,vertices,values,Nlines);
% Draws isolines (also called contour lines) of a scalar function linearly
% interpolated on a triangulated surface by its values at vertices.
% NOTATION:
% 'Ntriangles' denotes the number of triangles, which is the number
% of rows in the (input) array 'triang_faces'. 'Ngrid_pts' denotes the
% number of vertices which is the number of rows in the (input)
% array 'vertices'. 'DIM' is the dimension of the physical space,
% also the number of columns in 'vertices' (DIM==2 or DIM==3).
% PARAMETERS:
% -- triang_faces (Ntriangles x 3)
%     triang_faces(i,j) is the index of
%     the vertex no. 'j' (j=1,2,3) of the triangle no. 'i' into the
%     array 'vertices'.
% -- vertices (Ngrid_pts x DIM)
%     vertices(k,:) are the coordinates of the vertex no. 'k'.
% -- values (Ngrid_pts x 1)
%     Value of the interpolated function, at each vertex.
% -- Nlines (1x1)
%     Number of levels of isolines to draw.
%
% Returns handle to the graphics object.
%================
% Example usage
%================
% load camel;
% patch('Vertices',vertices, 'faces', faces,'faceColor',[0.55164 0.50648 0.52648],'EdgeColor','none',...
%     'faceLighting','phong','faceAlpha','interp','faceLighting','phong'); 
% view(3); grid on; alpha(1); axis on; axis image; axis tight; lighting phong;  
% light('Position',[-1 -1 1],'Style','infinite'); material shiny; camlight headlight;
% material([.5 .5 0.2 25 0]); hold on; zoom(1.3); cameramenu; 
% hold on; draw_isolines(faces,vertices,vertices(:,2),20)
figure

patch('Vertices',vertices, 'faces', triang_faces,'faceColor',[0.55164 0.50648 0.52648], 'EdgeColor','none',...
    'faceLighting','phong','faceAlpha','interp','faceLighting','phong'); 
view(3); grid on; alpha(1); axis on; axis image; axis tight; zoom(1.2); axis off 
lighting phong;  
light('Position',[-1 -1 1],'Style','infinite'); material shiny; camlight headlight;
material([.5 .5 0.2 25 0]); hold on; zoom(1.2); cameramenu; 

%     patch('Vertices',vertices,'Faces',triang_faces,'FaceColor','flat');
%     shading interp;
%     view(3); grid on; %view(-6,16); 
%     set(gcf,'Renderer','OpenGL');
%     alpha(1); axis on; axis image; axis tight; zoom(1.2); axis off
%     lighting phong; %phong; gouraud; flat;
%     light('Position',[-1 -1 1],'Style','infinite'); material shiny; %dull, metal
%     material([.5 .5 0.2 25 0]); cameramenu; 

hold on;

if nargin<1
    help draw_isolines
    return
end

S.CDataMapping = 'scaled';
S.EdgeColor = 'flat';
S.faces = [];
S.vertices = [];


S.FaceVertexCData = [];


MAXA = max(values(:));
MINA = min(values(:));

LV = linspace(MINA,MAXA,Nlines);
v_ix = 1;

Ntriangles = size(triang_faces,1);
[Ngrid_pts,DIM] = size(vertices);

if Ngrid_pts ~= length(values)
   error('Ngrid_pts ~= length(values)');
end

for f=1:1:Ntriangles
    for l_ix= 1:1:length(LV)
        [p1,p2] = draw_eco_line(LV(l_ix),vertices(triang_faces(f,:)',:),...
                                values(triang_faces(f,:)'));
        if ~isempty(p1)
           S.FaceVertexCData = [S.FaceVertexCData;LV(l_ix);LV(l_ix)];
           S.vertices = [S.vertices ; p1' ; p2'];
           S.faces = [S.faces ;[v_ix,v_ix + 1]];
           v_ix = v_ix + 2;
        end
    end
end

handle = patch_checked(S);
%handle = patch(S,'EdgeColor','interp'); view(3); axis tight; axis image; grid;
%handle = patch('Xdata',S.vertices,'Ydata',S.faces,'facecolor','none','edgecolor','interp');


% grid on;
% xlabel('x');
% ylabel('y');
% if DIM == 3
%    zlabel('z');
% end
% colorbar;

function [posA,posB]=draw_eco_line(val,vertices,values)
%
values = values(:);

if (val <= min(values))  || (val >= max(values))
    posA = [] ; posB = [];
    return;
end

pos = [];

if (val >= min(values(1:2)))  && (val <=  max(values(1:2)))
    if (val ~= values(2))
        pos = [pos;midp(val,values(1),values(2),vertices(1,:),vertices(2,:))];
    end
end

if (val >= min(values(2:3)))  && (val <=  max(values(2:3)))
    if (val ~= values(3))
        pos = [pos;midp(val,values(2),values(3),vertices(2,:),vertices(3,:))];
    end
end

if (val >= min(values([1,3])))  && (val <=  max(values([1,3])))
    if(val ~= values(1))
        pos = [pos;midp(val,values(1),values(3),vertices(1,:),vertices(3,:))];
    end
end

Npos = size(pos,1);
if Npos ~= 2
    posA=[];  posB=[];
    return;
end

posA = pos(1,:)';
posB = pos(2,:)';


function x = midp(v,y2,y1,x2,x1)
x = ((v - y1)/(y2 - y1))*(x2-x1) + x1;


function graphic_handle = patch_checked(S)
% graphic_handle = patch_checked(S);
% wraps around call to 'patch(S)'.
% checks for empty arguments.

if ( ~isfield(S,{'vertices'}) )
    error('patch_checked: inp arg does not have a field "vertices"');
end

if ( isempty(S.vertices) )
    warning('PATCH_CHECKED:NO_VERTICES',...
            'patch_checked: inp arg have an empty field "vertices"');
end

error_condition = ( ~isfield(S,{'vertices'}) ) || ( isempty(S.vertices) ) ;

if ( error_condition )
    graphic_handle = [];
    return;
end

graphic_handle = patch(S,'EdgeColor','interp','LineWidth',1.5); view(3); axis tight; axis image;% grid; 

