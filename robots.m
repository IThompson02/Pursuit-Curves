function robots(N)
clf
figure('Position',[0 0 1280 720])
daspect([1 1 1])

n = N;
O = string(n);
disp(O)

Final = (n*40)

%Setup Video Capture
FileName = O+'robots';
fps = 20;
Vid = VideoWriter(FileName);
Vid.FrameRate = fps;
Vid.Quality = 100;
open(Vid)


%Define Circle
x0=0;
y0=0;
r=3;
plot(x0,y0,'.r')
hold on
teta=-pi:0.01:pi;
x=r*cos(teta)+x0;
y=r*sin(teta)+y0;
plot(x,y,'r')
hold off
hold on
%break into N points

tet=linspace(-pi,pi,n+1)
xi=r*cos(tet)+x0
yi=r*sin(tet)+y0
for k=1:numel(xi)
    %Plot Points on edge of circle
    plot(xi(k),yi(k),'.b')  
end
daspect([1 1 1])


for k=1:20
    f = getframe(gcf);
    writeVideo(Vid,f);
    pause(0.1)
end

%remove last duplicate value
xi(end)=[]
yi(end)=[]
%Combine xi and yi into one array xi = real, yi = imaginary
z = complex(xi,yi)




%Code to make them follow
z = reshape(z,1,[]);
L = length(z);
d = 0.05;
hold on
for k = 1:Final
    disp(k)
    V = z(end,[(2:L) 1]) - z(end,:);
    z(end+1,:) = z(end,:) + d*V;
    for l = 1:L
        plot(real(z(:,l)),imag(z(:,l)),'b')
        %pause(0.1)
        f = getframe(gcf);
        writeVideo(Vid,f);
    end
    daspect([1 1 1])
end
daspect([1 1 1])
close(Vid)
hold off
end