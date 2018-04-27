function main_plot = plot_my_graph_no_prompt(x_data,y_data, plot_shape,graph_size, colour_scheme, xticks, yticks, eqn, fit_model, legend_setting, graph_name, strXLabel, strYLabel)
%% Styling
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

[map,num,typ] = brewermap(length(x_data),colour_scheme);

hold on
for i = 1:length(x_data)
    data(i) = scatter(x_data{1,i}(:,1),y_data{1,i}(:,1),'filled',plot_shape{1,i},'MarkerFaceColor', map(i,:),'MarkerEdgeColor','k');
end


%% Setting lims

xlim([xticks(1,1) xticks(1,end)])
ylim([yticks(1,1) yticks(1,end)])


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

%% Plotting a fit
% 
if ~isempty(eqn) == 1
    syms x y
    plot_color = input('What colour for the plot?, e.g , Red, Green: ', 's');
%     eqn_name = input('What is the label for this eqn?, e.g Trend line', 's');
    f = fimplicit(eqn);
    uistack(f,'bottom')
    f.LineWidth = 2;
    f.LineStyle = '--';
    f.Color = plot_color ;
else 
end

if ~isempty(fit_model)  == 1
    plot_color = input('What colour for the plot?, e.g , Red, Green: ', 's');
%     fit_name = input('What is the label for this fit?, e.g Gauss fit: ', 's');
    h = plot(fit_model);
    uistack(h,'bottom')
    h.LineWidth = 2;
    h.LineStyle = '--';
    h.Color = plot_color ;
else
end




%% Legend settings

switch legend_setting
    case 'off'
        legend('off')
    case 'on'
        legend_names = input('Enter name for each legend entry: ','s');
        legend_names = strsplit(legend_names ,',');
        legend_location = input('Enter location for legend, e.g southeast: ', 's');
        legend(legend_names,'location', legend_location);

    end

%% Labels and name for the graph

% graph_name = input('Enter name for graph, e.g sample_1: ', 's');
% strXLabel = input('Enter label for x axis, e.g Count: ', 's');
% strYLabel = input('Enter label for y axis, e.g Area - mm: ', 's');



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