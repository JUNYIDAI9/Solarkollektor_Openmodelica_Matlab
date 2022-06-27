%%  Interpretation der OM-mat-file-Ausgabe  / ts 02.02.2021

clc
clear all
%%
% load Sim_out.mat            % individueller Name derAusgabedatei, alle Var: .*
load 'Solarkollektor.Hauptprogramm_output/Solarkollektor.Hauptprogramm_res.mat'  % alternativ


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
ts      = res_0.data(1,:);
Tm      = res_0.data(2,:);
derTm   = res_0.data(3,:);
G       = res_0.data(7,:);
Qabs    = res_0.data(8,:);
Quse    = res_0.data(9,:);
Qver    = res_0.data(10,:);
Tco     = res_0.data(11,:);

%%
th = ts/3600;

%%
figure(1)
% subplot(3,1,1)
plot(th,Tco,'.r');
hold on
plot(th,Tm,'.m')
% plot(th,Ta,'.b');
hold off
grid
legend('Tco','Tm')
xlabel('Stunden des Jahres')
ylabel('°C')
ylim([-10 80])

%%
figure(2)
plot(th,Qabs,'r');
hold on
plot(th,Qver,'m')
plot(th,Quse,'b');
hold off
grid
legend('Qabs','Qver','Quse')
xlabel('Stunden des Jahres')
ylabel('°C')





% data2 = data_2;
% %%
% t=data2(1,:);
% Tm=data2(2,:);
% der_Tm=data2(3,:);  
% dni=data2(4,:);
% dhi=data2(5,:);
% Ta=data2(6,:);
% G=data2(7,:);
% Qaco=data2(8,:);
% Qabs=data2(9,:);
% qACO=data2(10,:);
% Qu=data2(11,:);
% Qv=data2(12,:);
% Tco=data2(13,:);
% Cp=data2(14,:);
% qabs=data2(16,:);
% quse=data2(17,:);
% qv=data2(18,:);
% %%
% T_ci=50;
% A=2;
% %%
% quse(quse<0)=0;
% ctr=quse./quse;
% ctr(isnan(ctr))=0;
% th=t/3600;
% %%
% figure(1)
% plot(th,Tco.*ctr,'.r');
% hold on
% plot(th,Tm.*ctr,'.m')
% plot(th,Ta,'.b');
% hold off
% grid
% legend('Tco','Tm','Ta')
% xlabel('Stunden des Jahres')
% ylabel('¡æ')
% %%
% figure(2)
% subplot(2,1,1)
% plot(th,G,'.-r');
% hold on
% plot(th,qabs.*ctr,'.-b');
% hold off
% legend('G','qabs')
% grid
% ylabel('w/m^2')
% subplot(2,1,2)
% plot(th,qv.*ctr,'.-r');
% hold on 
% plot(th,quse.*ctr,'.-g');
% hold off
% grid 
% legend('qv','quse')
% xlabel('Stunden des Jahres')
% ylabel('W/m^2')
% %%
% Qu(Qu<0)=0;
% Quse = Qu';
% QuseD=sum(reshape(Quse(1:8760,1),[24,365]))./1000;
% QuseM(1,1)=sum(QuseD(1:31));
% QuseM(1,2)=sum(QuseD(32:59));
% QuseM(1,3)=sum(QuseD(60:90));
% QuseM(1,4)=sum(QuseD(91:120));
% QuseM(1,5)=sum(QuseD(121:151));
% QuseM(1,6)=sum(QuseD(152:181));
% QuseM(1,7)=sum(QuseD(182:212));
% QuseM(1,8)=sum(QuseD(213:243));
% QuseM(1,9)=sum(QuseD(244:273));
% QuseM(1,10)=sum(QuseD(274:304));
% QuseM(1,11)=sum(QuseD(305:334));
% QuseM(1,12)=sum(QuseD(335:365));
% %%
% figure(3)
% title 'Monatssummen'
% bar(QuseM,'grouped');
% grid
% legend(['T_{ci}=',num2str(T_ci),'¡æ'])
% xlim([1 12])
% q_sol=sum(QuseM)/A;
% Tmm=mean(Tm);
% xlabel(['Jahresertrag: ',num2str(ceil(q_sol)),...
%     'kwh/(m^2-a)   Mitteltemp.: ',num2str(ceil(Tmm)),'¡æ'])
% ylabel('kwh/M')
