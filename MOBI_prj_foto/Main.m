%%
%"XYR01F1.DTA" dla ro=0.01 i fazy fi=0
%"XYR1F1.DTA" dla ro=0.1 i fazy fi=0
%"XYR2F2.DTA" dla ro=0.2 i fazy fi=1/2*PI
%"XYR3F3.DTA" dla ro=0.3 i fazy fi=PI
%"XYR4F4.DTA" dla ro=0.4 i fazy fi=3/2*PI

format long g

directory = uigetdir(pwd, 'Select a folder');
dir_txt = dir(fullfile(directory, '*.txt'));
dir_DTA = dir(fullfile(directory, '*.DTA'));

dir1 = dir_DTA(:,:);
dir2 = dir_txt(:,:);

[len1,dir_arr1] = struct2cellArr(dir1);
[len2,dir_arr2] = struct2cellArr(dir2);
a = coma2dot(dir1,len1);
b = coma2dot(dir2,len2);

j = 0;
counter = 0;

for c = j : len2
    j = j +1;
    s1 = strfind(dir2(j).name,'comma_'); 
    s2 = strfind(dir2(j).name,'F');
    s3 = strfind(dir2(j).name,'R');
    if ~isempty(s1) && ~isempty(s3) && ~isempty(s3)
        counter = counter + 1;
        imported_data = importdata(dir2(j).name);
        data_cell = cellfun( @(x) strsplit( x, 'D0' ), imported_data, 'UniformOutput', false );
        b = 2;
        p = 12;
        arr_from_file = zeros(p,b+2);
        
       [ro,fi] = fileVariant(dir2,j);
       
        for c1 = 1:b
            for c2 = 1:p
                arr_from_file(c2,c1) = str2double(data_cell{c2,1}(1,c1));
                arr_from_file(c2,b+1)  = ro;
                arr_from_file(c2,b+2)  = fi;
                arr_from_file(c2,b+3) = C.k(c2);
            end
        end
        ise = evalin( 'base', 'exist(''RXrofi'',''var'') == 1' );
        if ise == 0
            RXrofi = arr_from_file;
        else
            RXrofi = cat(1,RXrofi,arr_from_file);
        end
    else
        %do nothing
    end
    if j >=52
        break;
    end
end

y(:,1) = complex(RXrofi(:,1) , RXrofi(:,2));
y(:,2) = RXrofi(:,3);
y(:,3) = RXrofi(:,4);
y(:,4) = RXrofi(:,5);
i = 1;
for c = 1:length(y) % coresponding modes
    y(c,5) = i;
    if i >= 12
        i = 1;
    else
        i = i+1;
    end
end

clear RXrofi
clear i j k l counter

m = [0:1:4];
%W = [0:0.174e-5:5e-4];
x = [-C.L.*0.5e-2:C.L.*6.96e-5/8:C.L.*0.5e-2];

clear i j
%min cutoff for TEm modes nc = 1
%MinW = zeros(length(m),length(y(1:12,4)));
%for i = 1:length(m)
%    for j = 1:length(y(1:12,4))
%        MinW(i,j) = cutOffWMin(i,y,j);
%    end
%end


cutOffWTEm = zeros(length(m),length(C.Beta));
cutOffWTMm = zeros(length(m),length(C.Beta));

for i = 1:length(m)
    for j = 1:length(C.Beta)
        cutOffWTEm(i,j) = cutOffWidthTEm(i,C.Beta,j);
        cutOffWTMm(i,j) = cutOffWidthTMm(i,C.Beta,j);
    end
end

betaTEm = zeros(length(m),length(cutOffWTEm));
betaTMm = zeros(length(m),length(cutOffWTMm));
Em_field = zeros(length(m),length(x),length(cutOffWTEm));
integralEmField = zeros(length(m),length(cutOffWTEm));

for i = 1:length(m)
    for j = 1:length(cutOffWTEm)
        betaTEm(i,j) = beta_TEm(cutOffWTEm(i,j),m(i));
        betaTMm(i,j) = beta_TMm(cutOffWTMm(i,j),m(i));
        integralEmField(i,j) = integral_Em(betaTEm(i,j),cutOffWTEm(i,j));
        for l = 1:length(x)
            Em_field(i,l,j) = Em(betaTEm(i,j),cutOffWTEm(i,j),x(l));
        end
    end
end
%% g0L(|KL|)

clear c1 c2
pPindex = 3;
alfaLindex = 4;
m = 1; % coresponding mode structure mode = m - 1
Windex = 778; % 778 -> 3.5 [um]1072
%gZero = zeros(length(y),length(alfaLindex));
for c2 = 1:length(m)
    for c1 = 1:length(y)
        gZero(c2,c1) = g_zero(integralEmField,y,alfaLindex,pPindex,c1,m(c2),cutOffWTEm,Windex,betaTEm,max(x));
    end
end

clear j i c1
i = 241;
j = 252;
%i = 277;
%j = 288;
divider = 4;

figure(1)
for c1 = 1:length(y)/12/divider
    plot(y(i:j,4),gZero(:,i:j).*C.L);
    hold on
    %i = i + 48;
    %j = j + 48;
end

clear j i c1
grid on
hold off
i = 241;
j = 252;

figure(2)
for c1 = 1:length(y)/12/divider
    semilogx(y(i:j,4),gZero(:,i:j).*C.L);
    hold on
    %i = i + 48;
    %j = j + 48;
end
xlabel('|kqL|', 'FontSize', 12);
ylabel('g0L','FontSize', 12);
%legend('alfaL = 0.001','alfaL = 0.01','alfaL = 0.1','alfaL = 1');
%legend('PumpPower = 0.001','PumpPower = 0.01','PumpPower = 0.1','PumpPower = 1');
%legend('r = 0.01','r = 0.1','r = 0.2','r = 0.3','r = 0.4','r = 0.5');
legend('m = 0','m = 1','m = 2','m = 3');
grid on
clear m i c1 c2 j
%%
clear m i
m = [0:1:4];
Width = 1.2409e-6; %width set 
%sens = [1e-8,5e-8,8e-8]
figure(3)
semilogy(C.Beta,cutOffWTEm);
hold on
semilogy(C.Beta,cutOffWTMm,'--');
grid on
xlabel('Stała propagacji Beta', 'FontSize', 12);
ylabel('Grubość odcięćia W [m]','FontSize', 12);

for c = 1:length(m)
    yline(cutOffWTEm(c,1),'--r','HandleVisibility','off');
    yline(cutOffWTMm(c,1),'--b','HandleVisibility','off');
end
hold on
%crxss_WTEm1 = find_crossection(cutOffWTEm,cutOffWTEm,betaTEm,1e-8,m);
%crxss_WTEm2 = find_crossection(cutOffWTEm,cutOffWTMm,betaTEm,1e-8,m);
%crxss_WTMm1 = find_crossection(cutOffWTMm,cutOffWTEm,betaTEm,1e-8,m);
%crxss_WTMm2 = find_crossection(cutOffWTMm,cutOffWTMm,betaTMm,1e-8,m);


clear c1 c2
y1 = ylim;
for c1 = 1:length(m)
    for c2 = 1:length(m)
        if crxss_WTEm1(c1,c2) == 0
            %do nothing
        else
        line([crxss_WTEm1(c1,c2) crxss_WTEm1(c1,c2)], [y1(1) cutOffWTMm(c2,1)],'Color','red','LineStyle','--');
        %xline(crxss_WTEm1(c1,c2),'--r','HandleVisibility','off');
        end
        if crxss_WTEm2(c1,c2) == 0
            %do nothing
        else
        %xline(crxss_WTEm2(c1,c2),'--r','HandleVisibility','off');
        end
        if crxss_WTMm1(c1,c2) == 0
            %do nothing
        else
            %text = string(c1)
            %xline(crxss_WTMm1(c1,c2),'--b',{'m' + text},'HandleVisibility','off');
        %xline(crxss_WTMm1(c1,c2),'--b','HandleVisibility','off');
        line([crxss_WTMm1(c1,c2) crxss_WTMm1(c1,c2)], [y1(1) cutOffWTMm(c2,1)],'Color','blue','LineStyle','--');
        end
        if crxss_WTMm2(c1,c2) == 0
            %do nothing
        else
        %xline(crxss_WTMm2(c1,c2),'--b','HandleVisibility','off');
        end
    end
end

legend('TE m=0','TE m=1','TE m=2','TE m=3','TE m=4','TM m=0','TM m=1','TM m=2','TM m=3','TM m=4');

figure(4) %wave propagation by mode
clear c1 c2
for c1 = 1:length(m)
    for c2 = 1:length(Em_field)
        if  cutOffWTEm(c1,c2) <= Width+2e-8 && cutOffWTEm(c1,c2) >= Width-2e-8
            plot(x,Em_field(c1,:,c2));
            hold on
        else
            %do nothing
        end
    end
end
xline(-Width,'--r');
xline(0,'--r');
xlabel('Przekrój poprzeczyny lasera DFB [m]', 'FontSize', 12);
ylabel('Wartość pola E [V/m]','FontSize', 12);
grid on






