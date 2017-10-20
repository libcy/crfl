nr=9;
nt=4096;
nz=5;

pmat0=[4.5666,5.4067,5.6405,7.2306,7.9935];
pmat1=[4,6,6,7,8];
% pmat0=[4.4695,6.0723,6.1197,6.8693,8.1182];
% pmat1=[4.5666,5.4067,5.6405,7.2306,7.9935];

% pmat0=[15.6885,13.0765,14.8318];
% pmat1=[14,14,14];

mode=5;

if mode==5||mode==1
    data1=readdata();
    
    if mode==1
        [data0,time]=forward(pmat1,1);
    end
else
    [data0,time]=forward(pmat0,1);
end

if mode==1
    figure(1);
    data0=data0.tra;
    dw=max(max(abs(data0)));
    for i=1:nr
        plot(time,data0(i,1:nt)+(i-1)*dw,'r');hold on;
        plot(time,data1.ver(i,1:nt)+(i-1)*dw,'b');hold on;
    end
    hold off;
    axis([time(1),time(nt),-inf,inf]);
elseif mode==2||mode==4
    yyy=zeros(nz,20);
    xxx=zeros(nz,20);
    target=pmat0;
    dx=0.5;
    nx=16;
    tic;
    for j=1:nz
        disp(j);
        parfor i=1:8
            pmat=zeros(1,nz);
            for k=1:nz
                if k==j
                    pmat(k)=target(k)+dx*(i-nx/2);
                else
                    pmat(k)=target(k);
                end
            end
            yyy(j,i)=getg(pmat,data0,i);
            xxx(j,i)=target(j)+dx*(i-nx/2);
        end
        parfor i=9:16
            pmat=zeros(1,nz);
            for k=1:nz
                if k==j
                    pmat(k)=target(k)+dx*(i-nx/2);
                else
                    pmat(k)=target(k);
                end
            end
            yyy(j,i)=getg(pmat,data0,i-8);
            xxx(j,i)=target(j)+dx*(i-nx/2);
        end
    end
    toc;
    for i=1:nz
        figure(i);
        plot(xxx(i,1:nx),yyy(i,1:nx));axis([xxx(i,1),xxx(i,nx),min(yyy(i,1:nx)),max(yyy(i,1:nx))]);
    end
    if mode==4
        for i=nz+1:2*nz
            figure(i);
            dyy=diff(yyy(i-nz,1:nx));
            plot(xxx(i-nz,1:nx-1),dyy);axis([xxx(i-nz,1),xxx(i-nz,nx-1),min(dyy),max(dyy)]);
        end
    end
elseif mode==5
    target=pmat1;
    tic;
    [X, info]=cg('grad',data1,target,[2 2 1 0 0 200 0 0 0]);
    toc;
    figure(1);
    plot(1:nz,X);hold on;plot(1:nz,target);hold off;title('pmat1');
    figure(2);
    dw=max(max(abs(data1.rad)));
    data2=forward(X,1);
    for i=1:nr
        plot(time,data2.rad(i,1:nt)+(i-1)*dw);hold on;
        plot(time,data1.rad(i,1:nt)+(i-1)*dw);hold on;
    end
    hold off;
    axis([time(1),time(nt),-inf,inf]);
elseif mode==7
    tic;
    [X, info]=cg('grad',data0,pmat1,[2 2 1 0 0 200 0 0 0]);
    toc;
    figure(1);
    plot(1:nz,X);hold on;plot(1:nz,pmat1);hold off;title('pmat1');
    figure(2);
    plot(1:nz,X);hold on;plot(1:nz,pmat0);hold off;title('pmat0');
elseif mode==6
    [g,gp]=grad(pmat1,data0);plot(1:nz,gp);
end
