%%  Interpretation der OM-mat-file-Ausgabe  / ts 02.02.2021

clc
clear all
%%
% load Sim_out.mat            % individueller Name derAusgabedatei, alle Var: .*
load 'Sortieren_output/Sortieren03_res.mat'  % alternativ


%%  Datenaufbereitung
[r,c] = size(data_2);

%%  Header

col1 = string(name(:,1:r)');
col2 = string(description(:,1:r)');
data = (data_2);
res_0 = table(col1,col2,data);
res_0.Properties.VariableNames{1} = 'Bez_var';
res_0.Properties.VariableNames{2} = 'OM_var';


%%
res_0.OM_var
ts0       = res_0.data(1,:)';
% Zeile 2:  "collector.IrrTot                                    "    "Total solar radiation on collector's absorber surfcace [W/m2]      
GT0       = res_0.data(2,:)';
% Zeile 3:  "collector.QCon[1].y                                 "    "Value of Convective heat flow Real output  
Qv0        = res_0.data(3,:)';
% Zeile 4:  "collector.replicatorQrad.y[1]                       "    "Value of Radiative heat flow Real output signals 
Qabs0      = res_0.data(4,:)';
% Zeile 5:  "collector.sumConRad[1].y                            "    "Value of Useenergy Real output signal 
Quse0      = res_0.data(5,:)';




%% Filter f¨¹r Stundenwerte
p = ts0/3600 - fix(ts0/3600);  % 
pp = p ==0;     % wenn pp ==1, dann voller Stundenwert

ts = ts0(pp)/3600;  % Auwahl der vollen Stunden
ts = ts(2:end-1,1); % Eliomination erster / letzter Wert
GT = GT0(pp);
GT = GT(2:end-1,1);
Qv = Qv0(pp);
Qv = Qv(2:end-1,1);
Qabs = Qabs0(pp);
Qabs = Qabs(2:end-1,1);
Quse = Quse0(pp);
Quse = Quse(2:end-1,1);
%%
Tci = 75 ;
Quse(Quse<0)=0;
ctr=Quse./Quse;
ctr(isnan(ctr))=0;
%%
figure(1)
subplot(2,1,1)
plot(ts/3600 ,GT.*ctr ,'.-r');
hold on
plot(ts/3600 ,Qabs/2.*ctr,'.-b');
hold off
legend('GT','Qabs/2')
grid
ylabel('w/m^2')
subplot(2,1,2)
plot(ts/3600 ,Qv/2.*ctr,'.-r');
hold on 
plot(ts/3600 ,Quse/2.*ctr,'.-g');
hold off
grid 
legend('Qv/2','Quse/2')
xlabel('Stunden des Jahres')
ylabel('W/m^2')
%%
QuseD=sum(reshape(Quse(1:8760,1),[24,365]))./1000;
QuseM(1,1)=sum(QuseD(1:31));
QuseM(1,2)=sum(QuseD(32:59));
QuseM(1,3)=sum(QuseD(60:90));
QuseM(1,4)=sum(QuseD(91:120));
QuseM(1,5)=sum(QuseD(121:151));
QuseM(1,6)=sum(QuseD(152:181));
QuseM(1,7)=sum(QuseD(182:212));
QuseM(1,8)=sum(QuseD(213:243));
QuseM(1,9)=sum(QuseD(244:273));
QuseM(1,10)=sum(QuseD(274:304));
QuseM(1,11)=sum(QuseD(305:334));
QuseM(1,12)=sum(QuseD(335:365));
%%
figure(2)
title 'Monatssummen'
bar(QuseM,'grouped');
grid
legend(['T{ci}=',num2str(Tci),'¡æ'])
xlim([1 12])
q_sol=sum(QuseM)/2;
xlabel(['Jahresertrag: ',num2str(ceil(q_sol)),...
    'kwh/(m^2-a)    '])
ylabel('kwh/M')