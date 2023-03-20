%% Information
% Author : Limin Gu
% Date   : 2021/09/17
% Function : Calculate the CTFT of signal h and plot the spectrum.
%            

function [f,H] = my_CTFT(t,h,f,s)
    dt = t(2)-t(1);
    nf = length(f);
    
    H = zeros(1,nf);

    for ii = 1:1:nf
        
        H(ii) = ;
        
    end
    
    figure
    subplot(311)
    plot(t,h)
    xlabel('Time / s');
    ylabel('h(t)');
    title('Original Signal h(t)');
    
    if s == 'R-I'
    subplot(312)
    plot(f,real(H))
    title('Real part of H(f)')
    xlabel('Frequency / Hz')
    ylabel('H(f)_{real}')

    subplot(313)
    plot(f,imag(H))
    title('Imaginary part of H(f)')
    xlabel('Frequency / Hz')
    ylabel('H(f)_{Imag}')
    
    elseif s == 'A-P'
    subplot(312)
    plot(f,abs(H))
    title('Abs of H(f)')
    xlabel('Frequency / Hz')
    ylabel('H(f)_{Abs}')

    subplot(313)
    plot(f,unwrap(angle(H)))
    title('Phase of H(f)')
    xlabel('Frequency / Hz')
    ylabel('H(f)_{Phase} / rad')
    
    end
    
end