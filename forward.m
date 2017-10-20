function [data,time]=forward(pzmat,id)
%     pmat=[4.4695,6.0723,6.1197,6.8693,8.1182];
%     pmat=[4.5666,5.4067,5.6405,7.2306,7.9935];
%     zmat=[3.1545,15.6885,13.0765,14.8318];
    pmat=pzmat;
%     zmat=[3.1545,15.6885,13.0765,14.8318];
%     zmat=[4,14,13,14];
    zmat=[3.2305,15.4767,13.0879,17.2157];
%     zmat=pzmat;
%     zmat(2:4)=pzmat;
    for i=2:4
        zmat(i)=zmat(i)+zmat(i-1);
    end

    fid=fopen(sprintf('crfl%d.dat',id),'w');
    fprintf(fid,'velocity model for Gansu SW refer to ZhouMindu 2012\n');
    fprintf(fid,' 0 0 1 0 0   1 0 1 1 1   1 0 0 0 0   0 1 1 1 1   1\n');
    fprintf(fid,'    3    0    0    1    1\n');
    
    nz=5;
    nr=9;
    nt=4096;
    
    qpmat=[180.0,200.0,210.0,260.0,350.0];
    dmat=[2.65,2.75,2.80,3.10,3.37];
    lmat=[1,1,10,1];
    
    smat=pmat./1.732;
    qsmat=qpmat./2;
    
    dist=[146.8791,165.8086,215.1607,256.2203,275.3373,282.8396,359.3283,410.6326,437.8507,    100,120,140,160,180,200,220,    240,260,280,300,320,340,360,380,    400,420,440,460,480,520,540,560];
    azim=[317.8994,343.6969,354.7531,338.9809,320.5721,355.3201,337.0134,320.5277,342.3499,    100,110,120,130,140,150,160,    170,180,190,200,210,220,230,240,    250,260,270,280,290,300,310,320];
    

    for i=1:nz
        if i==1
            zi=0;
        else
            zi=zmat(i-1);
        end
        fprintf(fid,'%.4f    %.4f    %.4f    %.4f    %.4f    %.4f    0\n',zi,pmat(i),qpmat(i),smat(i),qsmat(i),dmat(i));
        if i<nz
            fprintf(fid,'%.4f    %.4f    %.4f    %.4f    %.4f    %.4f    %d\n',zmat(i),pmat(i),qpmat(i),smat(i),qsmat(i),dmat(i),lmat(i));
        end
    end
    
    fprintf(fid,' \n');
    fprintf(fid,'    0.0000\n');
    fprintf(fid,'    0.0000    0.0000   18.8000    0.0000    1.0000\n');
    fprintf(fid,'    2.6704    0.6458    1.7977\n');
    fprintf(fid,'    0.0000    0.0000    0.0000    0.0000        9\n');
%     for i=0:3
%         fprintf(fid,'  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f\n',dist(1+i*8),dist(2+i*8),dist(3+i*8),dist(4+i*8),dist(5+i*8),dist(6+i*8),dist(7+i*8),dist(8+i*8));
%     end
%     for i=0:3
%         fprintf(fid,'  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f\n',azim(1+i*8),azim(2+i*8),azim(3+i*8),azim(4+i*8),azim(5+i*8),azim(6+i*8),azim(7+i*8),azim(8+i*8));
%     end
    fprintf(fid,'  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f\n',dist(1),dist(2),dist(3),dist(4),dist(5),dist(6),dist(7),dist(8));
    fprintf(fid,'  %.4f\n',dist(9));
    fprintf(fid,'  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f  %.4f\n',azim(1),azim(2),azim(3),azim(4),azim(5),azim(6),azim(7),azim(8));
    fprintf(fid,'  %.4f\n',azim(9));
    fprintf(fid,' 9999.0000    0.0000\n');
    fprintf(fid,'    1.0000    1.2000   50.0000  100.0000       600\n');
    fprintf(fid,'    0.0010    0.0200    0.1000    0.2000\n');
    fprintf(fid,'    0.1000      4096         0         1    2.4000  204.8000');
    fclose(fid);

    system(sprintf('a%d.exe',id));

    time=zeros(1,nt);
    data=struct('tra',zeros(nr,nt),'rad',zeros(nr,nt),'ver',zeros(nr,nt));
    
    fid=fopen(sprintf('crfl%d.sh',id),'rt');
    while ~feof(fid)
        line=fgets(fid);
        if strfind(line,'increment')
            break;
        end
    end
    for i=1:nr
        results = textscan(fid, '%f %f',nt, 'Delimiter', '\n');
        if i==1
            time=results{1};
        end
        results = results{2};
        data.tra(i,1:nt)=results(1:nt);
        fgets(fid);
    end
    fclose(fid);
    
    fid=fopen(sprintf('crfl%d.psv',id),'rt');
    while ~feof(fid)
        line=fgets(fid);
        if strfind(line,'increment')
            break;
        end
    end
    for i=1:nr
        results = textscan(fid, '%f %f',nt, 'Delimiter', '\n');
        results = results{2};
        data.rad(i,1:nt)=results(1:nt);
        fgets(fid);
        
        results = textscan(fid, '%f %f',nt, 'Delimiter', '\n');
        results = results{2};
        data.ver(i,1:nt)=results(1:nt);
        fgets(fid);
    end
    fclose(fid);
    
    data.tra(2,1:nt)=0;
    data.rad(2,1:nt)=0;
    data.ver(1,1:nt)=0;
    data.tra=data.tra./norm(data.tra);
    data.rad=data.rad./norm(data.rad);
    data.ver=data.ver./norm(data.ver);
    
%     wave=data.tra;
%     wave(2,1:nt)=0;
%     wave=wave./norm(wave);
end