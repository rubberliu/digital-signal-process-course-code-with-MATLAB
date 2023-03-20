%% Information
% Author : Limin Gu
% Date   : 2021/09/17
% Function : Calculate the CTFT of signal x and plot the spectrum.          
% Input  : Time axis--t, Signal--h, Frequency axis--f
%         'R-I' or 'A-P'--'Real-imag' or 'Abs-Phase'.
% Output : Frequency Axis--f,  CTFT results--H

function X = my_CTFT(t,x,f,s)
    dt = t(2)-t(1);
    fs = 1/dt;
    nf = length(f);
    
    X = zeros(1,nf);

    for ii = 1:1:nf
        X(ii) = sum( x.*exp(-1j*f(ii)*2*pi*t)*dt );
    end
       
    switch (s)
        case 'R-I'
        figure
        subplot(311)
        plot(t,x)
        xlabel('Time / s');
        ylabel('x(t)');
        title('Original Signal x(t)');

        subplot(312)
        plot(f,real(X))
        title('Real part of CTFT(x(t))')
        xlabel('Frequency / Hz')
        ylabel('Real')

        subplot(313)
        plot(f,imag(X))
        title('Imaginary part of CTFT(x(t))')
        xlabel('Frequency / Hz')
        ylabel('Imag')

        case 'A-P'
        figure
        subplot(311)
        plot(t,x)
        ylim([0,1.2*max(x)])
        xlabel('Time / s');
        ylabel('x(t)');
        title('Original Signal x(t)');

        subplot(312)
        plot(2*pi*f,abs(X))
        title('Modulus of CTFT(x(t))')
        xlabel('Frequency / Hz')
        ylabel('Modulus')

        subplot(313)
        plot(2*pi*f,unwrap(angle(X)) )
        title('Phase of CTFT(x(t))')
        xlabel('Frequency / Hz')
        ylabel('Phase / rad')
        
        case 'None'
    
    end
    
end