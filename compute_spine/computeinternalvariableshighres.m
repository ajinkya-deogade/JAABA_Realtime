function [a,b,theta]=computeinternalvariableshighres(xcontour,ycontour)
    
    
    [X,Y]=meshgrid(linspace(round(min(xcontour*100)),round(max(xcontour*100)),round(max(xcontour*100))-round(min(xcontour*100))+1),...
        linspace(round(min(ycontour*100)),round(max(ycontour*100)),round(max(ycontour*100))-round(min(ycontour*100))+1));
    in=inpolygon(X,Y,round(xcontour*100),round(ycontour*100));
    [Xseg,Yseg]=find(in==1);
    [a,b,theta]=cov2ell(cov([Yseg+round(min(xcontour*100)),Xseg+round(min(ycontour*100))]));
    a=a/100;
    b=b/100;