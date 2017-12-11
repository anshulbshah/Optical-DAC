%option 2
%% 
% MSB = 1;
% LSB = 0;
t = -5e-8:1e-10:5e-8;
P0 = 0.104
tau = 7*1e-9; %ps
x = sqrt(P0)*exp(-t.^2/(tau)^2);
%% 
%% 
MSB = 1;
LSB = 1;
outs = zeros(4,1001);
for i = 1:4
    if(i == 1)
        MSB = 0;
        LSB = 0;
    elseif(i==2)
        MSB = 0;
        LSB = 1;
    elseif(i==3)
        MSB = 1;
        LSB = 1;
    else
        MSB = 1;
        LSB = 0;
    end
    %MSB = 0;
    %LSB = 0;
    p = 0:0.01:4;
    [rx1,tx1] = NOLM(0.9,2.1,2,x,sqrt(MSB*3.8 + 0.04));
    %[rx1,tx1] = NOLM(0.9,2.1,2,sqrt(0.104),sqrt(1.*p + 0.04));
%     plot(p,abs(tx1).^2./abs(sqrt(.104)).^2)
%     hold on;
%     plot(p,abs(rx1).^2./abs(sqrt(.104)).^2)
%     legend('Transmittance','Reflectance');
%     xlabel('Pump Power');
%     ylabel('Transmittance-Reflectance');
%     title('Reflectance and Transmittance characteristics of NOLM1')
    RX_1 = rx1;
    TX_1 = tx1;
    %PR1 = abs(RX_1)^2;
    %PT1 = abs(TX_1)^2;
%% 
% plot(p,abs(RX_1).^2)
% hold on;
% plot(p,abs(TX_1).^2)
% 
%% 
    [rx2,tx2] = NOLM(0.1,2.1,2,RX_1,sqrt(LSB*0.43));
    %p = 0:0.01:0.6;
    %[rx2,tx2] = NOLM(0.1,2.1,2,sqrt(0.104),sqrt(1*p));
    TX_2 = tx2;
    NOLM2_out = abs(TX_2).^2
%     plot(p,abs(tx2).^2./abs(sqrt(.104)).^2)
%     xlabel('Pump Power');
%     ylabel('Transmittance');
%     title('Effect of Phase mismatch')
    %plot(p,NOLM2_out)
%% 
%hold on;
% p = 0:0.1:2;
%% 

    [rx3,tx3] = NOLM(0.9,2.1,2,TX_1,sqrt(LSB*2.00 + 0.04));
    p = 0:0.01:4;
    %[rx3,tx3] = NOLM(0.9,2.1,2,sqrt(0.104),sqrt(1*p + 0.04));
    RX_3 = rx3;
    NOLM3_out = abs(RX_3).^2
%     plot(p,abs(rx3).^2./abs(sqrt(.104)).^2)
%     xlabel('Pump Power');
%     ylabel('Reflectance');
%     title('Reflectance characteristics of NOLM3')


%%
    outs(i,:) = NOLM2_out + NOLM3_out;
    %subplot(2,2,i);
    plot(t,sqrt(outs(i,:)));
    ylim([0, 0.2]);
    %title(strcat(num2str(max(sqrt(outs(i,:))),2),'V'));
    %xlabel(strcat(int2str(MSB),int2str(LSB)));
    xlabel('Time');
    ylabel('Amplitude');
    hold on;
    if(i == 2)
        plot(t,2*sqrt(outs(i,:)));
        hold on;
        plot(t,3*sqrt(outs(i,:)));
    end
    
end
%legend('00','01','2x','3x','11','10');
%plot(p,abs(RX_3).^2)
% RX_3 = rx3;
% NOLM3_out = abs(rx3).^2*1000
% outs(i,:) = NOLM2_out + NOLM3_out;
% plot(t,sqrt(outs(i,:)));
