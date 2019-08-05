%
% pr6_4_2 
clear all; clc; close all;

run Set_I                               % ��������
run PART_I                              % �������ݣ���֡��׼��
Y=fft(y);                               % FFT�任
N2=wlen/2+1;                            % ȡ��Ƶ�ʲ���
n2=1:N2;
Y_abs=abs(Y(n2,:));                     % ȡ��ֵ
M=fix(N2/4);                            % �����Ӵ���
for k=1 : fn
    for i=1 : M                         % ÿ���Ӵ�����4������
        j=(i-1)*4+1;
        SY(i,k)=Y_abs(j,k)+Y_abs(j+1,k)+Y_abs(j+2,k)+Y_abs(j+3,k);
    end
    Dvar(k)=var(SY(:,k));               % ����ÿ֡�Ӵ������Ƶ������
end
Dvarm=multimidfilter(Dvar,10);          % ƽ������
dth=mean(Dvarm(1:(NIS)));               % ��ֵ����
T1=1.5*dth;
T2=3*dth;
[voiceseg,vsl,SF,NF]=vad_param1D(Dvarm,T1,T2);% Ƶ�򷽲�˫���޵Ķ˵���
% ��ͼ
subplot 311; plot(time,x,'k');
title('����������');
ylabel('��ֵ'); axis([0 max(time) -1 1]);
subplot 312; plot(time,signal,'k');
title('������������(�����10dB)');
ylabel('��ֵ'); axis([0 max(time) -1 1]);
subplot 313; plot(frameTime,Dvar,'k');
title('��ʱ�����Ӵ������Ƶ������ֵ'); grid; ylim([0 1.2*max(Dvar)]);
xlabel('ʱ��/s'); ylabel('��ֵ'); 
line([0,frameTime(fn)], [T1 T1], 'color','k','LineStyle','--');
line([0,frameTime(fn)], [T2 T2], 'color','k','LineStyle','-');
for k=1 : vsl                           % ��������˵�
    nx1=voiceseg(k).begin; nx2=voiceseg(k).end;
    fprintf('%4d   %4d   %4d\n',k,nx1,nx2);
    subplot 311; 
    line([frameTime(nx1) frameTime(nx1)],[-1 1],'color','k','LineStyle','-');
    line([frameTime(nx2) frameTime(nx2)],[-1 1],'color','k','LineStyle','--');
    subplot 313; 
    line([frameTime(nx1) frameTime(nx1)],[0 1.2*max(Dvar)],'color','k','LineStyle','-');
    line([frameTime(nx2) frameTime(nx2)],[0 1.2*max(Dvar)],'color','k','LineStyle','--');
end

