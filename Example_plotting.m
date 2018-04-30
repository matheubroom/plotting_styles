%% This is a simple example of using the plotting function by Matheu Broom

%% Select Data

% Prepare your data. All data should be entered as a set of x,y data points
% in cells. The data cells are 1 row N coloum, where each cell contains a
% matrix of data. Each matching matrix from x data and y data must be the
% same length. If the y data has multiple sets then it is plotted against
% the same x values. 

x_data{1,1}(:,1) = linspace(1,20,20); % x data 1, linear spaced values
y_data{1,1} = x_data{1,1}(:,1).^2; % y data 1, equal to x^2
x_data{1,2}(:,1) = linspace(1,20,20); % x data 2, linear spaced values
y_data{1,2} = x_data{1,2}(:,1).^3; % y data 2, equal to x^3

%% Plot Shape

% This is to choose the type of plotting or scattering for each of the data
% sets. Ie for scatter s is square, c is circle. See Matlab help for
% options

plot_shape{1,1} = 'c'; % scattering data set 1 with circles
plot_shape{1,2} = 's'; % scattering data set 2 with squares

%% Fits and Eqns

% This secton is to choose fitted models or eqns that need to be plotted
% along side data. 

fit_model{1,1} = fit(x_data{1,1}(:,1),y_data{1,1}(:,1),'poly2'); % fits a poly 2 model to data set 1
eqn{1,1} = @(x,y) y-x^3; % creates an eqn to plot

%% Ticks

% This section is to choose the x,y ticks and the range of the data. In
% future this section will be automatic. (Almost there)

raw_ticks = preview_graph(x_data,y_data); % previews the graph for you to view the range of data

xticks = str2num(raw_ticks{1,1});
yticks = str2num(raw_ticks{2,1});


% uncomment below if you want to set by hand.

% xticks = [0,5,10,15,20]; % set by hand
% yticks = [0,100,200,300,400]; % set by hand

%% Labels

% set the labels for the graph, ie title, x axis and y axis. 

graph_name = 'test_graph';
x_axis_label = 'Index';
y_axis_label = 'Value';



%% Main plotting function

main_plot = plot_my_graph_no_prompt('scatter',x_data,y_data, plot_shape, 'md', [], xticks, yticks, eqn, fit_model, 'on', graph_name, x_axis_label,y_axis_label)


