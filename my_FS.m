%% Information
% Author : Limin Gu
% Date   : 2021/09/17
% Function : Calculate the FS of signal x and plot the spectrum.   
% Input : Time axis of x --t, Signal --x, Order vector --kk, Period of
%         signal x --T0.
% Output : Fourier coefficient of x --ak.

function ak = my_FS(t,x,kk,T0)

    ak = zeros(1,length(kk));
    w0 = 2*pi/T0;
    dt = t(2)-t(1);
    T = max(t)-min(t);
    
    for ii = 1:length(kk)
        ak(ii) = 1/T*sum(x.*exp(-1j*kk(ii)*w0*t))*dt;
    end
    
%     figure
%     subplot(211)
%     stem(kk,real(ak))
%     subplot(212)
%     stem(kk,imag(ak))
%     title('FS of signal')
end