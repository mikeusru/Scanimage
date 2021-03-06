function [BETA,R,J]=r_Michaelis_summary

%Beta=[EC50, Hill, a];
nimo = 0.85;
nickel = 0.65;
Xarray = [20	0.1492	0.0074	0.1276	0.1295	0.2137	-0.0284	0.1538
33.3	0.2207	0.1205	0.235	0.2042	0.7133	0.0392	0.5328
50	0.6918	0.3526	0.7369	0.5181	1.14	0.304	0.9006
62.5	0.8774	0.7109	1.268	0.756	0.941	0.5619	0.9912
83.3	1	1	1	1	1	1	1
100	1.0075	1.0157	1.071	0.8283	0.9615	1.0594	0.9457];

x4 = [1,2,3,4];
y4 = [0.092546654
0.529252726
0.899866421
1.000000149];
z4 = [0.033289433
0.069142044
0.085424224
9.16149E-08];


X = Xarray(:, 1);
Y = mean(Xarray(:, 2:end), 2);
siz=size(Xarray);
numR = siz(1);
numD = siz(2)-1;
Z = std(Xarray(:, 2:end), 0, 2)/sqrt(numD-1);
BETA0=[mean(X), 4, max(Y)];
for i=1:numD
    [BETA,R,J] = NLINFIT(X,Xarray(:,i+1),@MichaelisMenten,BETA0);
    EC50each(i) = BETA(1);
    Hilleach(i) = BETA(2);
    ARange(i) = BETA(3);
end



[BETA,R,J] = NLINFIT(X,Y,@MichaelisMenten,BETA0);
[BETA1,R,J] = NLINFIT(X,Y,@MichaelisMenten_Fix,BETA0);
[BETA2,R,J] = NLINFIT(X,Y,@MichaelisMenten_Fix2,BETA0);
[BETA4,R,J] = NLINFIT(X,Y,@MichaelisMenten_Fix4,BETA0);
x1=[0:max(X)/25:max(X)];


figure; subplot(2,2,1);
hold on;
% plot ([0;X], [zeros(1, numD);Xarray(:,2:end)], '-o', 'MarkerFaceColor', 'Auto');
h = errorbar(X, Y, Z, 'o');
set(h(1), 'Color', 'Blue');
set(h(2), 'MarkerEdgeColor', 'Blue', 'MarkerFaceColor', 'Blue', 'MarkerSize',12);


plot(x1, MichaelisMenten(BETA, x1), 'color', 'blue', 'LineWidth', 4)
%plot(x1, MichaelisMenten_Fix(BETA1, x1), '--', 'color', 'green', 'LineWidth', 2);
%plot(x1, MichaelisMenten_Fix2(BETA2, x1), '--', 'color', 'red', 'LineWidth', 2);
%plot(x1, MichaelisMenten_Fix4(BETA4, x1), 'color', 'black', 'LineWidth', 2);
Xlim([0, max(X)]);
Ylim([-0.2, 1.3]);

yrange = get(gca, 'Ylim');
text(max(X)/40, yrange(2)*9/10, ['Hill Coefficient = ', num2str(BETA(2)), '    EC50 = ', num2str(BETA(1))], 'Color', 'Blue');
%text(max(X)/40, yrange(2)*8/10, ['Hill Coefficient = 1', '    EC50=', num2str(BETA1(1))], 'Color', 'Green');
%text(max(X)/40, yrange(2)*7/10, ['Hill Coefficient = 2', '    EC50=', num2str(BETA2(1))], 'Color', 'Red');
%text(max(X)/40, yrange(2)*6/10, ['Hill Coefficient = 4', '    EC50=', num2str(BETA4(1))], 'Color', 'Black');


subplot(2,2,2)
hold on;
%plot ([0;X], [zeros(1, numD);Xarray(:,2:end)], '-o', 'MarkerFaceColor', 'Auto', 'LineWidth', 1);
%errorbar(X, Y, Z, 'o');
%plot(X, Y, 'o', 'MarkerEdgeColor', 'Blue', 'MarkerFaceColor', 'Blue', 'MarkerSize',12);
Acolor = {'Red', 'Green', 'Blue', [1,0.5,0.5], 'Magenta', 'Cyan', 'black'};
for i=1:numD
    plot (X, Xarray(:, i+1), '-o', 'color', Acolor{i}, 'MarkerEdgeColor', Acolor{i}, 'MarkerFaceColor', Acolor{i}, 'LineWidth', 1);
    %plot(x1, MichaelisMenten([EC50each(i), Hilleach(i), ARange(i)], x1), 'color', Acolor{i}, 'LineWidth', 1);
end
plot(x1, MichaelisMenten([mean(EC50each), mean(Hilleach), mean(ARange)], x1), 'color', 'blue', 'LineWidth', 4);
Xlim([0, max(X)]);
text(max(X)/40, yrange(2)*9/10, ['Hill Coefficient = ', num2str(mean(Hilleach)), '+/-', num2str(std(Hilleach, 0)), ...
        '    EC50=', num2str(mean(EC50each)), '+/-', num2str(std(EC50each, 0))], 'Color', 'Black');

Ylim([-0.2, 1.3]);

subplot(2,2,3)
hold on;
h = errorbar(x4, y4, z4, 'o');
set(h(1), 'Color', 'Blue');
set(h(2), 'MarkerEdgeColor', 'Blue', 'MarkerFaceColor', 'Blue', 'MarkerSize',12);
[BETA_C,R,J] = NLINFIT(x4,y4,@MichaelisMenten_fix4,BETA0);
x41=[0:max(x4)/25:max(x4)];
plot(x41, MichaelisMenten_fix4(BETA_C, x41), 'color', 'blue', 'LineWidth', 4);

Xlim([0, max(x4)]);
text(max(x4)/40, yrange(2)*9/10, ['Hill Coefficient = ', num2str(BETA_C(2)), '    EC50 = ', num2str(BETA_C(1))], 'Color', 'Blue');

Ylim([-0.2, 1.3]);


subplot(2,2,4)
hold on;
h = errorbar(X/83.3, Y, Z, 'o');
set(h(1), 'Color', 'Blue');
set(h(2), 'MarkerEdgeColor', 'Blue', 'MarkerFaceColor', 'Blue', 'MarkerSize',12);
%plot(X/83.3, Y, 'o', 'MarkerEdgeColor', 'Blue', 'MarkerFaceColor', 'Blue', 'MarkerSize',12);
plot(x1/83.3, MichaelisMenten(BETA, x1), 'color', 'blue', 'LineWidth', 4)

h1 = errorbar(x4/4, y4, z4, 'o');
set(h1(1), 'Color', 'Red');
set(h1(2), 'MarkerEdgeColor', 'Red', 'MarkerFaceColor', 'Red', 'MarkerSize',12);

%plot(x4/4, y4, 'o', 'MarkerEdgeColor', 'Red', 'MarkerFaceColor', 'Red', 'MarkerSize',12);
%plot(x41/4, MichaelisMenten_fix4(BETA_C, x41), 'color', 'Red', 'LineWidth', 4);

Xlim([0, max(x1/83.3)]);
Ylim([-0.2, 1.3]);

h2 = errorbar([50,83.3]/83.3*nimo, [0.8776*Y(3), 0.954925],	[0.050184576*Y(3), 0.106295182], 'o');
set(h2(1), 'Color', 'Green');
set(h2(2), 'MarkerEdgeColor', 'Green', 'MarkerFaceColor', 'Green', 'MarkerSize',12);


h3 = errorbar([50,83.3]/83.3*nickel, [0.3263*Y(3), 0.7778],	[0.0889*Y(3), 0.0561], 'o');
set(h3(1), 'Color', 'Cyan');
set(h3(2), 'MarkerEdgeColor', 'Cyan', 'MarkerFaceColor', 'Cyan', 'MarkerSize',12);
% function y=MichaelisMenten(beta, x)
% EC50 = beta(1);
% Hill    = beta(2);
% a = beta(3);
% y = a*x.^Hill./(x.^Hill+EC50^Hill);

set(gcf, 'PaperPositionMode', 'auto');


