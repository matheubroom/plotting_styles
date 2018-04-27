function main_plot = plot_my_graph(x_data,y_data, data_names,fit_model)
%% Styling
graph_size = input('Enter size of graph, e.g sm, md, lg: ', 's');
    switch graph_size
        case 'sm'
            fig_xlength = 6;
            fig_ylength = 6;
        case 'md'
            fig_xlength = 13.5;
            fig_ylength = 5.4;
        case 'lg'
            fig_xlength = 13.5;
            fig_ylength = 10;
    end

set(gcf, 'Units', 'centimeters')
main_plot = axes;
afFigurePosition = [1 1 fig_xlength fig_ylength]; % [pos_x pos_y width_x width_y]
set(gcf, 'Position', afFigurePosition); % [left bottom width height]

%% Plotting the data
colour_scheme = input('Enter colour scheme, e.g Blues: ', 's');

[map,num,typ] = brewermap(length(x_data),colour_scheme);

hold on
for i = 1:length(x_data)
    data(i) = scatter(x_data{1,i}(:,1),y_data{1,i}(:,1),'filled','MarkerFaceColor', map(i,:),'MarkerEdgeColor','k');
end


%% Setting lims
min_x = min(vertcat(x_data{[1 length(x_data)]}));
max_x = max(vertcat(x_data{[1 length(x_data)]}));

min_y = min(vertcat(y_data{[1 length(y_data)]}));
max_y = max(vertcat(y_data{[1 length(y_data)]}));

padding_x = 0.05*(max_x-min_x);
padding_y = 0.05*(max_y-min_y);

xlim_new = round([min_x-padding_x max_x+padding_x],2,'significant');
ylim_new = round([min_y-padding_y max_y+padding_y],2,'significant');

xlim(xlim_new) % set the xlims
ylim(ylim_new) % set the ylims

number_steps_x = input('Enter number ticks on axis, e.g 4: ');
number_steps_y = input('Enter number ticks on axis, e.g 4: ');

delta_x = (xlim_new(1,2) - xlim_new(1,1))/number_steps_x;
delta_y = (ylim_new(1,2) - ylim_new(1,1))/number_steps_y;

xticks = [xlim_new(1,1):delta_x:xlim_new(1,2)];
yticks = [ylim_new(1,1):delta_y:ylim_new(1,2)];

set(gca, ...
  'GridLineStyle','-'       ,...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.0 .0 .0], ...
  'YColor'      , [.0 .0 .0], ...
  'YTick'       , yticks, ...
  'XTick'       , xticks, ...
  'LineWidth'   , 1         );

check_plot = input('Is the limits of the graph ok?: ', 's');
    switch check_plot 
        case 'no'
            xticks= input('Enter the limits for x axis: ');
            xlim([xticks(1,1) xticks(1,end)]) % set the xlims
            yticks= input('Enter the limits for y axis: ');
            ylim([yticks(1,1) yticks(1,end)]) % set the xlims
        case 'yes'
    end
    
    
check_plot = input('Are the axis ticks ok?: ', 's');
    switch check_plot 
        case 'no'
            xticks= input('Enter ticks and range for x axis: ');
            yticks= input('Enter ticks and range for y axis: ');
            set(gca, ...
              'GridLineStyle','-'       ,...
              'Box'         , 'off'     , ...
              'TickDir'     , 'out'     , ...
              'TickLength'  , [.02 .02] , ...
              'XMinorTick'  , 'off'      , ...
              'YMinorTick'  , 'off'      , ...
              'YGrid'       , 'off'      , ...
              'XColor'      , [.0 .0 .0], ...
              'YColor'      , [.0 .0 .0], ...
              'YTick'       , yticks, ...
              'XTick'       , xticks, ...
              'LineWidth'   , 1         );
        case 'yes'
    end

% main_plot.XRuler.MinorTickValues = [xlim_new(1,1):0.2:xlim_new(1,2)];
%% Plotting a fit
% 

plot_fit = input('Do you have an eqn to plot?, e.g yes no: ', 's');
    switch plot_fit 
        case 'yes'
            syms x y
            eqn_input = input('Whats the eqn in standard notation?, e.g ', 's');
            plot_color = input('What colour for the plot?, e.g , Red, Green: ', 's');
            eqn_name = input('What is the label for this eqn?, e.g Trend line', 's');
            eqn = eval(eqn_input);
            f = fimplicit(test);
            uistack(f,'bottom')
            f.LineWidth = 2;
            f.LineStyle = '--';
            f.Color = plot_color ;
        case 'no'
    end

plot_fit = input('Do you have fit to plot?, e.g yes no: ', 's');
    switch plot_fit 
        case 'yes'
            plot_color = input('What colour for the plot?, e.g , Red, Green: ', 's');
            fit_name = input('What is the label for this fit?, e.g Gauss fit: ', 's');
            h = plot(fit_model);
            uistack(h,'bottom')
            h.LineWidth = 2;
            h.LineStyle = '--';
            h.Color = plot_color ;
        case 'no'
    end



%% Legend settings
legend_location = input('Enter location for legend, e.g southeast: ', 's');

if  exist('eqn_name') + exist('data_names') > 2
    legend(eqn_name, data_names{1,1:length(data_names)},'location',legend_location)
end

if exist('eqn_name') == 1
        legend(eqn_name,'location',legend_location)
end

if exist('fit_name') + exist('data_names') > 2
    legend(fit_name, data_names{1,1:length(data_names)},'location',legend_location)
end

if exist('fit_name') == 1
        legend(fit_name,'location',legend_location)
end

if exist('data_names') == 1    
    legend(data_names{1,1:length(data_names)},'location',legend_location)
end


%% Labels and name for the graph

graph_name = input('Enter name for graph, e.g sample_1: ', 's');
strXLabel = input('Enter label for x axis, e.g Count: ', 's');
strYLabel = input('Enter label for y axis, e.g Area - mm: ', 's');

% legend('Circle Trend','p40um h15um','p40um h22um','p40um h31um','location','southeast');


%% DONT CHANGE

% fonts properties
iFontSize = 11;
strFontUnit = 'points'; % [{points} | normalized | inches | centimeters | pixels]
strFontName = 'Times'; % [Times | Courier | ] TODO complete the list
strFontWeight = 'normal'; % [light | {normal} | demi | bold]
strFontAngle = 'normal'; % [{normal} | italic | oblique] ps: only for axes
 strInterpreter = 'tex'; % [{tex} | latex]
%
%
fXLabelRotation = 0.0;
fYLabelRotation = 90.0;
xlabel( strXLabel, ...
'FontName', strFontName, ...
'FontUnit', strFontUnit, ...
'FontSize', iFontSize, ...
'FontWeight', strFontWeight, ...
'Interpreter', strInterpreter);
%
ylabel( strYLabel, ...
'FontName', strFontName, ...
'FontUnit', strFontUnit, ...
'FontSize', iFontSize, ...
'FontWeight', strFontWeight, ...
'Interpreter', strInterpreter);
%
set(get(gca, 'XLabel'), 'Rotation', fXLabelRotation);
set(get(gca, 'YLabel'), 'Rotation', fYLabelRotation);

% 
%% 
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];

%% 

set(gcf, 'PaperPositionMode', 'auto');
print(graph_name,'-depsc', '-cmyk')


end