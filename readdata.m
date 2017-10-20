function wave=readdata()
    nr=9;
    nt=4096;
    wave=struct('tra',zeros(nr,nt),'rad',zeros(nr,nt),'ver',zeros(nr,nt));
    
    for i=1:nr
        name=sprintf('data2/tra%d.dat',i);
        fid=fopen(name,'rt');
        results = textscan(fid, '%f', 'Delimiter', '\n');
        wave.tra(i,1:nt)=results{1};
        fclose(fid);

        name=sprintf('data2/rad%d.dat',i);
        fid=fopen(name,'rt');
        results = textscan(fid, '%f', 'Delimiter', '\n');
        wave.rad(i,1:nt)=results{1};
        fclose(fid);

        name=sprintf('data2/ver%d.dat',i);
        fid=fopen(name,'rt');
        results = textscan(fid, '%f', 'Delimiter', '\n');
        wave.ver(i,1:nt)=results{1};
        fclose(fid);
    end
    
    wave.tra(2,1:nt)=0;
    wave.rad(2,1:nt)=0;
    wave.ver(1,1:nt)=0;
    wave.tra=wave.tra./norm(wave.tra);
    wave.rad=wave.rad./norm(wave.rad);
    wave.ver=wave.ver./norm(wave.ver);
end