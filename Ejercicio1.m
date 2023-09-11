clear all
close all
clc
%% ---------------------------------------------------------------------------------------
%                                  EJERCICIO 1
%-----------------------------------------------------------------------------------------
% Especificaciones del circuito
V = 12; % Voltaje de la fuente (en voltios)
R1 = 1.8; % Resistencia (en ohmios)
C = 2200e-6; % Capacitancia (en faradios)

% Transformada de Laplace de los componentes
syms s t;

% Transformada de Laplace de la resistencia (R1)
R1_s = R1;

% Transformada de Laplace del capacitor (C)
C_s = 1 / (s * C);

% Transformada de Laplace de la fuente de voltaje (V)
V_s = V / s;

% Ley de Kirchhoff para voltajes en el dominio de Laplace
I_s = (V_s - 0) / (R1_s + C_s);

% Mostrar la expresión de la corriente en el dominio frecuencial
disp('Expresión de la corriente en el dominio frecuencial:');
disp(vpa(I_s, 2));

% Transformada inversa de Laplace para encontrar la corriente en el dominio temporal
I_t = ilaplace(I_s, s, t);

% Mostrar la expresión de la corriente en el dominio temporal
disp('Expresión de la corriente en el dominio temporal:');
% disp(I_t);
disp(vpa(I_t, 2));
%% ---------------------------------------------------------------------------------------
%                                  EJERCICIO 2
%-----------------------------------------------------------------------------------------
V_final = 10; % Tensión final en voltios

% Calcular el tiempo necesario para que el capacitor alcance los 10V
t_carga = -(R1*C) * log(1 - V_final / V);

fprintf('Tiempo necesario para cargar el capacitor hasta %.1fV: %.2fms\n', V_final, t_carga * 1000);

%% ---------------------------------------------------------------------------------------
%                                  EJERCICIO 3
%-----------------------------------------------------------------------------------------

% Tensión de la fuente
V_fuente = V

% Caída de voltaje en la resistencia
V_resistencia = R1 * I_t

% Tensión en el capacitor como la diferencia entre V_fuente y V_resistencia
V_capacitor_t = V_fuente - V_resistencia

% Evaluar la tensión en el capacitor en t = R1 * C
tiempo_constante_de_tiempo = R1 * C;
tension_en_tiempo_constante_de_tiempo = subs(V_capacitor_t, t, tiempo_constante_de_tiempo)

% Mostrar la tensión en el capacitor en t = R1 * C
disp('Tensión en el capacitor en t = R1 * C:');
disp(vpa(tension_en_tiempo_constante_de_tiempo,2));

%%
%-----------------------------------------------------------------------------------------
%                                  EJERCICIO 3 Extra
%-----------------------------------------------------------------------------------------

% Valores de n desde 1 hasta 5
n_values = 1:5;

% Inicializar vectores para almacenar los resultados
tiempos_ms = zeros(size(n_values));
porcentaje_de_carga = zeros(size(n_values));
tensiones_en_capacitor = zeros(size(n_values));

% Calcular el porcentaje de carga y la tensión en el capacitor para cada valor de n
for i = 1:length(n_values)
    n = n_values(i);
    tiempo = n * R1 * C * 1000; % Convertir a ms
    porcentaje = 100 * (1 - exp(-n));
    tension = double(subs(V_capacitor_t, t, tiempo / 1000)); % Convertir de ms a s
    tiempos_ms(i) = tiempo;
    porcentaje_de_carga(i) = porcentaje;
    tensiones_en_capacitor(i) = tension;
end

% Mostrar los resultados en una tabla
disp('Porcentaje de Carga del Capacitor para n * R1 * C');
disp('--------------------------------------------------');
disp('n      Tiempo (ms)   Porcentaje (%)   Tensión en el Capacitor (V)');
disp('--------------------------------------------------');
for i = 1:length(n_values)
    fprintf('%d      %.2f          %.4f           %.4f\n', n_values(i), tiempos_ms(i), porcentaje_de_carga(i), tensiones_en_capacitor(i));
end

%%
%-----------------------------------------------------------------------------------------
%                                  EJERCICIO 4
%-----------------------------------------------------------------------------------------

% Especificaciones del circuito de descarga
R2 = 4.7; % Resistencia (en ohmios)
V_inicial = 10; % Tensión inicial del capacitor (en voltios)

% Transformada de Laplace de la resistencia (R2)
R2_s = R2;

% Expresión de Is en el dominio de Laplace
Is = V_inicial / (s * (R2 + 1 / (s * C)));

% Transformada inversa de Laplace para obtener la corriente en el dominio temporal
corriente_temporal = ilaplace(Is, s , t);
disp(vpa(corriente_temporal, 3));
