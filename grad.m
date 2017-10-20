function [g,gp]=grad(pmat0,data0)
    nz=size(pmat0);
    nz=nz(2);
    dp=0.001;
    gp=zeros(1,nz+1);
    parfor i=1:nz+1
        if i==nz+1
            gp(i)=getg(pmat0,data0,i);
        else
            pmat=zeros(1,nz);
            for j=1:nz
                if i==j
                    pmat(j)=pmat0(j)+dp;
                else
                    pmat(j)=pmat0(j);
                end
            end
            gp(i)=getg(pmat,data0,i);
        end
    end
    g=gp(nz+1);
    gp(nz+1)=[];
    for i=1:nz
        gp(i)=(gp(i)-g)/dp;
    end
end