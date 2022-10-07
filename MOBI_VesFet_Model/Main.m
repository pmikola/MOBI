%% Ioff(Uds) VesFET 
clear all clc
close(figure(1))
close(figure(2))
VesFet1 = VesFet(C.UDS3,0);
figure(1)
plot(C.UDS3,C.ID3);
hold on
plot(C.UDS3,VesFet1.Idiff,'-o');
grid on
xlabel('Uds [V]') 
ylabel('Ioff [A]') 

figure(2)
semilogy(C.UDS3,C.ID3);
hold on
semilogy(C.UDS3,VesFet1.Idiff,'-o');
grid on
xlabel('Uds [V]') 
ylabel('Ioff [A]') 
%% Id(Ugs) -> Uds = 0.05 V
clear all clc
close(figure(3))
close(figure(4))
VesFet2 = VesFet(0.05,C.UGS1);
figure(3)
plot(C.UGS1,C.ID1);
hold on
plot(C.UGS1,VesFet2.Idrift1,'-o');
grid on
xlabel('Ugs [V]') 
ylabel('Id [A]') 

figure(4)
semilogy(C.UGS1,C.ID1);
hold on
semilogy(C.UGS1,VesFet2.Idrift1,'-o');

grid on
xlabel('Ugs [V]') 
ylabel('Id [A]') 




%% Id(Ugs) -> Uds = 0.8 V 
clear all clc
close(figure(5))
close(figure(6))
VesFet3 = VesFet(0.8,C.UGS2);
figure(5)
plot(C.UGS2,C.ID2);
hold on
plot(C.UGS2,VesFet3.Idrift2,'-o');
grid on
xlabel('Ugs [V]') 
ylabel('Id [A]') 

figure(6)
semilogy(C.UGS2,C.ID2);
hold on
semilogy(C.UGS2,VesFet3.Idrift2,'-o');
grid on
xlabel('Ugs [V]') 
ylabel('Id [A]') 


%% gm - transkonduktancja
    clear all clc
    close(figure(7))
    close(figure(8))
    VesFet4 = VesFet(0.05,C.UGS1);
    VesFet5 = VesFet(0.8,C.UGS2);
    ID1 = flip(C.ID1);
    ID2 = flip(C.ID2);
    UGS1 = flip(C.UGS1);
    gm1_005_ref = (-diff(ID1)./-diff(UGS1)); %[A/V]
    gm1_005 = (-diff(flip(VesFet4.Idrift1))./-diff(UGS1)); %[A/V]
    
    ID2 = flip(C.ID2);
    UGS2 = flip(C.UGS2);
    gm1_08_ref = (-diff(ID2)./-diff(UGS1)); %[A/V]
    gm1_08 = (-diff(flip(VesFet5.Idrift2))./-diff(UGS2)); %[A/V]
    
    figure(7)
    plot(flip(C.UGS1(1:16)),gm1_005_ref)
    hold on
    plot(flip(C.UGS2(1:16)),gm1_08_ref)
    hold on
    plot(flip(C.UGS1(1:16)),gm1_005,'-o')
    hold on
    plot(flip(C.UGS2(1:16)),gm1_08,'-o')
    hold on
    legend('gm ref 1' , 'gm ref 2' , 'gm model 1', 'gm model 2');
    grid on
    xlabel('Ugs [V]') 
    ylabel('gm [A/V]') 
    
    figure(8)
    %n = 1.2 ; % smoothing window
    %b = ones(1,n) ;
    %xf = flip(C.UGS1(1:16));
    %yf = filter(b,n,gm1_005) ;
    %xq = C.UGS1(1:16);
    %vq2 = interp1(flip(C.UGS2(1:16)),gm1_005,xq,'makima');
    %integration = spline(flip(C.UGS2(1:16)),gm1_005,xq);
    %p = polyfit(flip(C.UGS2(1:16)), gm1_005, 1);
    %v = polyval(p, flip(C.UGS2(1:16)));
    
    semilogy(flip(C.UGS1(1:16)),gm1_005_ref)
    hold on
    semilogy(flip(C.UGS1(1:16)),gm1_08_ref)
    hold on
    semilogy(flip(C.UGS2(1:16)),gm1_005,'-o')
    %semilogy(flip(C.UGS2(1:16)),gm1_005,'o',xq,integration,'-');
    hold on
    semilogy(flip(C.UGS2(1:16)),gm1_08,'-o')
    hold on
    

    
    legend('gm ref 1' , 'gm ref 2' , 'gm model 1', 'gm model 2');
    grid on
    xlabel('Ugs [V]') 
    ylabel('gm [A/V]')
    
    %% Id - Vds - Vgs
    clear all clc
    close(figure(9))
    close(figure(10))
    
    Id_0 = zeros(1,length(C.UDS3));
    Id_03 = zeros(1,length(C.UDS3));
    Id_055 = zeros(1,length(C.UDS3));
    Id_07 = zeros(1,length(C.UDS3));
    Id_08 = zeros(1,length(C.UDS3));
    for i = 1:length(C.UDS3)
    VesFet_01 = VesFet(C.UDS3(i),0.1)
    temp = VesFet_01.Idrift2;
    Id_01(i) = temp;
    VesFet_03 = VesFet(C.UDS3(i),0.3)
    temp = VesFet_03.Idrift2;
    Id_03(i) = temp;
    VesFet_055 = VesFet(C.UDS3(i),0.55)
    temp = VesFet_055.Idrift2;
    Id_055(i) = temp;
    VesFet_07 = VesFet(C.UDS3(i),0.7)
    temp = VesFet_07.Idrift2;
    Id_07(i) = temp;
    VesFet_08 = VesFet(C.UDS3(i),0.8)
    temp = VesFet_08.Idrift2;
    Id_08(i) = temp;
    end
    %VesFet7 = VesFet(C.UDS3,C.UGS2);
    
    figure(9)
    plot(C.UDS3,Id_01)
    hold on
    plot(C.UDS3,Id_03)
    hold on
    plot(C.UDS3,Id_055)
    hold on
    plot(C.UDS3,Id_07)
    hold on
%    plot(C.UDS3,Id_08)
%    hold on
    legend('Ugs = 0.1V' , 'Ugs = 0.3V' , 'Ugs = 0.55V', 'Ugs = 0.7V');
    xlabel('Uds [V]') 
    ylabel('Id [A]')
    grid on
    
    figure(10)
    semilogy(C.UDS3,Id_01)
    hold on
    semilogy(C.UDS3,Id_03)
    hold on
    semilogy(C.UDS3,Id_055)
    hold on
    semilogy(C.UDS3,Id_07)
    hold on
    
    legend('Ugs = 0.1V' , 'Ugs = 0.3V' , 'Ugs = 0.55V', 'Ugs = 0.7V');
    xlabel('Uds [V]') 
    ylabel('Id [A]')
    grid on