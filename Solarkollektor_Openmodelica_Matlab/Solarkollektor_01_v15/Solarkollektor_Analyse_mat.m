
%%
load Solarkollektor.Hauptprogramm3_res.mat
data=data_2;
ts      = data(1,:);
Tm      = data(2,:);
derTm   = data(3,:);
Ta      = data(5,:);
G       = data(4,:);
Qabs    = data(6,:);
Quse    = data(7,:);
Qver    = data(8,:);
Tco     = data(9,:);

%%
th = ts/3600;
Quse(Quse<0)=0;
ctr=Quse./Quse;
ctr(isnan(ctr))=0;
Tci=75;

%%
figure(1)
plot(th,Tco.*ctr,'.r');
hold on
plot(th,Tm.*ctr,'.m')
plot(th,Ta,'.b');
hold off
grid
legend('Tco','Tm','Ta')
xlabel('Stunden des Jahres')
ylabel('℃')
ylim([-10 90])

%%
figure(2)
subplot(2,1,1)
plot(ts/3600 ,G.*ctr ,'.-r');
hold on
plot(ts/3600 ,Qabs/2.*ctr,'.-b');
hold off
legend('GT','Qabs/2')
grid
ylabel('w/m^2')
subplot(2,1,2)
plot(ts/3600 ,Qver/2.*ctr,'.-r');
hold on 
plot(ts/3600 ,Quse/2.*ctr,'.-g');
hold off
grid 
legend('Qver/2','Quse/2')
xlabel('Stunden des Jahres')
ylabel('W/m^2')
%%
Quse=Quse';
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
figure(3)
title 'Monatssummen'
bar(QuseM,'grouped');
grid
legend(['T{ci}=',num2str(Tci),'℃'])
xlim([1 12])
q_sol=sum(QuseM)/2;
xlabel(['Jahresertrag: ',num2str(ceil(q_sol)),...
    'kwh/(m^2-a)   '])
ylabel('kwh/M')