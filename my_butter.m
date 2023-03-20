function Hs = my_butter(wc,s,n)
% lpx
% 2022-03-23
% my butter filter
% only for even order low pass filter
if(mod(n,2)==0)
    I=1:1:n/2;
    theta=(I-0.5)*180/n;
    Hs=ones(1,length(s));
    for ii = 1:length(I)
        Hs=Hs.*(wc^2./(s.^2+2*cos(theta(ii)/180*pi)*wc*s+wc^2));
    end
else
    disp(['n is not even '])
end

end

