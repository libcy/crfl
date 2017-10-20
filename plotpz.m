function plotpz = plotpz( pmat,zmat)
for i=2:4
    zmat(i)=zmat(i)+zmat(i-1);
%     zmat2(i)=zmat2(i)+zmat2(i-1);
%     zmat3(i)=zmat3(i)+zmat3(i-1);
end

plot([pmat(1),pmat(1)],[0,zmat(1)],'b');hold on;
plot([pmat(1),pmat(2)],[zmat(1),zmat(1)],'b');hold on;
plot([pmat(2),pmat(2)],[zmat(1),zmat(2)],'b');hold on;
plot([pmat(2),pmat(3)],[zmat(2),zmat(2)],'b');hold on;
plot([pmat(3),pmat(3)],[zmat(2),zmat(3)],'b');hold on;
plot([pmat(3),pmat(4)],[zmat(3),zmat(3)],'b');hold on;
plot([pmat(4),pmat(4)],[zmat(3),zmat(4)],'b');hold on;
plot([pmat(4),pmat(5)],[zmat(4),zmat(4)],'b');hold on;
plot([pmat(5),pmat(5)],[zmat(4),70],'b');hold on;

% plot([pmat2(1),pmat2(1)],[0,zmat2(1)],'r');hold on;
% plot([pmat2(1),pmat2(2)],[zmat2(1),zmat2(1)],'r');hold on;
% plot([pmat2(2),pmat2(2)],[zmat2(1),zmat2(2)],'r');hold on;
% plot([pmat2(2),pmat2(3)],[zmat2(2),zmat2(2)],'r');hold on;
% plot([pmat2(3),pmat2(3)],[zmat2(2),zmat2(3)],'r');hold on;
% plot([pmat2(3),pmat2(4)],[zmat2(3),zmat2(3)],'r');hold on;
% plot([pmat2(4),pmat2(4)],[zmat2(3),zmat2(4)],'r');hold on;
% plot([pmat2(4),pmat2(5)],[zmat2(4),zmat2(4)],'r');hold on;
% plot([pmat2(5),pmat2(5)],[zmat2(4),70],'r');hold on;
% 
% plot([pmat3(1),pmat3(1)],[0,zmat3(1)],'g');hold on;
% plot([pmat3(1),pmat3(2)],[zmat3(1),zmat3(1)],'g');hold on;
% plot([pmat3(2),pmat3(2)],[zmat3(1),zmat3(2)],'g');hold on;
% plot([pmat3(2),pmat3(3)],[zmat3(2),zmat3(2)],'g');hold on;
% plot([pmat3(3),pmat3(3)],[zmat3(2),zmat3(3)],'g');hold on;
% plot([pmat3(3),pmat3(4)],[zmat3(3),zmat3(3)],'g');hold on;
% plot([pmat3(4),pmat3(4)],[zmat3(3),zmat3(4)],'g');hold on;
% plot([pmat3(4),pmat3(5)],[zmat3(4),zmat3(4)],'g');hold on;
% plot([pmat3(5),pmat3(5)],[zmat3(4),70],'g');hold off;

axis([2,5,0,70]);
xlabel('S-wave velocity(km/s)');
ylabel('depth(km)');
set(gca,'ydir','reverse');

end

