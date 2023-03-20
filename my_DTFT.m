%% Information
% 
% Function : Calculate the DTFT of signal h and plot the spectrum.
% Input: Points sequence --nT, Signal sequence --xn, Frequency axis --f
% Output: Frequency axis --f, DTFT of x --X.
% Figure Option --s ['R-I' or 'A-P' or 'None']
% update:20220301 
% use fs:nyquist frequency when we dont have time information

% function X = my_DTFT(xn,f,fs,s)
%     nT=1:length(xn);
%     nT=nT/fs;
% 
%     nf = length(f);
%     
%     X = zeros(1,nf);
% 
%     for ii = 1:1:nf
%         X(ii) = sum( xn.*exp(-1j*f(ii)*2*pi*nT));
%     end
%     
%     switch (s)
%         case 'R-I'
%         figure
%         subplot(311)
%         stem(nT,xn)
%         xlabel('n');
%         ylabel('x[n]');
%         title('Original Signal x[n]');
%         
%         subplot(312)
%         plot(f,real(X))
%         title('Real part of DTFT(x[n])')
%         xlabel('Frequency / Hz')
%         ylabel('Real')
% 
%         subplot(313)
%         plot(f,imag(X))
%         title('Imaginary part of DTFT(x[n])')
%         xlabel('Frequency / Hz')
%         ylabel('Imag')
% 
%         case 'A-P'
%         figure
%         subplot(311)
%         stem(nT,xn)
%         xlabel('n');
%         ylabel('x[n]');
%         title('Original Signal x[n]');
%         subplot(312)
%         plot(f,abs(X))
%         title('Abs of DTFT(x[n])')
%         xlabel('Frequency / Hz')
%         ylabel('Amplitude')
% 
%         subplot(313)
%         plot(f,unwrap(angle(X)))
%         title('Phase of DTFT(x[n])')
%         xlabel('Frequency / Hz')
%         ylabel('Phase / rad')
%         
%         case 'None'
%     end
%     
% end
function X = my_DTFT(nT,xn,f,s)

    nf = length(f);
    
    X = zeros(1,nf);

    for ii = 1:1:nf
        X(ii) = sum( xn.*exp(-1j*f(ii)*2*pi*nT));
%         X(ii) = sum( x.*exp(-1j*f(ii)*2*pi*t)*dt ); % CTFT
    end
    
    switch (s)
        case 'R-I'
        figure
        subplot(311)
        stem(nT,xn)
        xlabel('n');
        ylabel('x[n]');
        title('Original Signal x[n]');
        
        subplot(312)
        plot(f,real(X))
        title('Real part of DTFT(x[n])')
        xlabel('Frequency / Hz')
        ylabel('Real')

        subplot(313)
        plot(f,imag(X))
        title('Imaginary part of DTFT(x[n])')
        xlabel('Frequency / Hz')
        ylabel('Imag')

        case 'A-P'
        figure
        subplot(311)
        stem(nT,xn)
        xlabel('n');
        ylabel('x[n]');
        title('Original Signal x[n]');
        subplot(312)
        plot(f,abs(X))
        title('Abs of DTFT(x[n])')
        xlabel('Frequency / Hz')
        ylabel('Amplitude')

        subplot(313)
        plot(f,unwrap(angle(X)))
        xlim([-4,4]) %
        title('Phase of DTFT(x[n])')
        xlabel('Frequency / Hz')
        ylabel('Phase / rad')
        
        case 'None'
    end
    
end