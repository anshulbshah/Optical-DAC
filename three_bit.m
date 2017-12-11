%option 2
%% 
% MSB = 1;
% LSB = 0;
t = -5e-8:1e-10:5e-8;
P0 = 0.1;
tau = 7*1e-9; %ps
x = sqrt(P0)*exp(-t.^2/(tau)^2);
%% 
%% 
MSB = 1;
LSB = 1;
outs = zeros(4,1001);
for i = 1:8
    if(i == 1)
        MSB = 0;
        NMSB = 0;
        LSB = 0;
    elseif(i==2)
        MSB = 0;
        NMSB = 0
        LSB = 1;
    elseif(i==3)
        MSB = 0;
        NMSB = 1;
        LSB = 0;
    elseif(i==4)
        MSB = 0;
        NMSB = 1;
        LSB = 1;
    elseif(i == 5)
        MSB = 1;
        NMSB = 0;
        LSB = 0;
    elseif(i==6)
        MSB = 1;
        NMSB = 0
        LSB = 1;
    elseif(i==7)
        MSB = 1;
        NMSB = 1;
        LSB = 0;
    else
        MSB = 1;
        NMSB = 1;
        LSB = 1;
    end
    %MSB = 0;
    %LSB = 0;
    [rx1,tx1] = NOLM(0.9,2.1,2,x,sqrt(MSB*3.8 + 0.04));
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
    p = 0:0.01:1;
    [rx2,tx2] = NOLM(0.1,2.1,2,RX_1,sqrt(NMSB*3.8));
    TX_2 = tx2;
    RX_2 = rx2;
%     figure(2)
%     plot(t,abs(RX_1),'o');
%     hold on;
    %NOLM2_out = abs(TX_2).^2
    
    [rx4,tx4] = NOLM(0.1,2.1,2,RX_2,sqrt(LSB*0.525));
    TX_4 = tx4;
    NOLM4_out = abs(TX_4).^2;
    
    [rx5,tx5] = NOLM(0.9,2.1,2,TX_2,sqrt(LSB*2.00 + 0.04));
    RX_5 = rx5;
    NOLM5_out = abs(RX_5).^2
    %plot(p,NOLM2_out)
%% 
%hold on;
% p = 0:0.1:2;
%% 
    %NMSB = 1; LSB = 0;
    [rx3,tx3] = NOLM(0.9,2.1,2,TX_1,sqrt(NMSB*3.8));
    reference_val = 0.8362*0.213*TX_1;
    %rx3 = rx3/sqrt(2);
    %tx3 = tx3/sqrt(2);
    figure(2)
    %plot(t,abs(reference_val),'--')
%     plot(t,abs(TX_1),'+');
%     hold on;
%     plot(t,abs(TX_1/sqrt(2)),'.');
    RX_3 = 0.718*rx3/(2*sqrt(2));
    TX_3 = 0.718*tx3/(2*sqrt(2));
%     figure(3)
%     plot(t,abs(RX_3),'--');
%     hold on;
%     plot(t,abs(TX_3),'+');
%     figure(5)
%     plot(t,abs(RX_2),'--');
%     hold on;
%     plot(t,abs(TX_2),'+');
    %NOLM6_out = abs(RX_3).^2
    
    [rx6,tx6] = NOLM(0.1,2.1,2,RX_3,sqrt(LSB*0.525));
    TX_6 = tx6;
    NOLM6_out = abs(TX_6).^2;
    
    [rx7,tx7] = NOLM(0.9,2.1,2,TX_3,sqrt(LSB*2.00 + 0.04));
    RX_7 = rx7;
    NOLM7_out = abs(RX_7).^2;


%%
    figure(4)
    subplot(4,1,1)
    plot(t,sqrt(NOLM4_out));
    subplot(4,1,2)
    plot(t,sqrt(NOLM5_out));
    subplot(4,1,3)
    plot(t,sqrt(NOLM6_out));
    subplot(4,1,4)
    plot(t,sqrt(NOLM7_out));
    outs(i,:) = NOLM4_out + NOLM5_out + NOLM6_out + NOLM7_out;
    figure(2)
    plot(t,sqrt(outs(i,:)) + abs(reference_val));
    hold on;
    max(abs(RX_1).^2)
    max(abs(TX_1).^2)
    %pause;
    
end
legend('000','001','011','010','110','111','101','100');
xlabel('Time');
ylabel('Amplitude');
title('Analog pulses for 3bit configuration');
%plot(p,abs(RX_3).^2)
% RX_3 = rx3;
% NOLM3_out = abs(rx3).^2*1000
% outs(i,:) = NOLM2_out + NOLM3_out;
% plot(t,sqrt(outs(i,:)));