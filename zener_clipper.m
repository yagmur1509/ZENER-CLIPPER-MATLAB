% 1. ZAMAN VE GÝRÝÞ SÝNYALÝ PARAMETRELERÝ
f = 50;                     % Frekans (Hz)
T = 1/f;                    % Periyot (20 ms)
t = linspace(0, T/2, 1000); % 0 - 10 ms
Vin = 10 * sin(2 * pi * f * t); % 10V tepe deðerli giriþ sinyali

% 2. DEVRE PARAMETRELERÝ
R = 10000;                  % Direnç deðeri (10k Ohm)
V_zener = 4.7;              % 1N750 Zener gerilimi
V_ileri = 0.7;              % Diyot forward gerilimi
V_sinir = V_zener + V_ileri; % Devrenin clipping noktasý

% 3. ÇIKIÞ GERÝLÝMÝ VE AKIM HESAPLAMALARI
Vout = Vin; 
% Sinyalin sýnýr deðerini aþtýðý yerleri kýrpar
Vout(Vin > V_sinir) = V_sinir;
Vout(Vin < -V_sinir) = -V_sinir;

% Akým hesaplamalarý (I = V/R)
I_D1 = (Vin - Vout) / R;    
I_D2 = -I_D1; % Ters akým gösterimi

% 4. GRAFÝK ÇÝZÝMÝ
figure('Name', 'Zener Kýrpýcý Devre Analizi', 'Color', 'w');

% Vout Gerilimi
yyaxis left;
plot(t * 1000, Vout, 'g', 'LineWidth', 1.5);
ylabel('Gerilim (V)', 'Color', 'g', 'FontWeight', 'bold');
ylim([0 6]); % Fotoðraftaki gibi 0 ile 6V arasýna sabitle
set(gca, 'YColor', 'g');

% Diyot Akýmlarý
yyaxis right;
plot(t * 1000, I_D1 * 1e6, 'b', 'LineWidth', 1.5); hold on;
plot(t * 1000, I_D2 * 1e6, 'r', 'LineWidth', 1.5);
ylabel('Akým (\muA)', 'Color', 'k', 'FontWeight', 'bold');
set(gca, 'YColor', 'k');

% Genel Eksen Ayarlarý
xlabel('Zaman (ms)', 'FontWeight', 'bold');
title('Zener Diyot Kýrpýcý (Clipper) Transient Analizi');
legend('V(vout)', 'I(D1)', 'I(D2)', 'Location', 'best');
grid on;
xlim([0 10]);