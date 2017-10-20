function getg=getg(pmat,data0,varargin)
    if nargin > 2
        id = varargin{1};
    else
        id=1;
    end
    data=forward(pmat,id);
    nt=4096;
    nr=9;
    getg=0;
    for i=1:nr
%         g=0;
%         for j=1:nt
%             g=g+(data.tra(i,j)-data0.tra(i,j))^2;
%         end
%         if i~=2
%         getg=getg+sqrt(g);
%         end

        g=0;
        for j=1:nt
            g=g+(data.rad(i,j)-data0.rad(i,j))^2;
        end
        getg=getg+sqrt(g);

        g=0;
        for j=1:nt
            g=g+(data.ver(i,j)-data0.ver(i,j))^2;
        end
        getg=getg+sqrt(g);
    end
end