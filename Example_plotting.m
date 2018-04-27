x_data{1,1}(:,1) = linspace(1,20,20);
y_data{1,1} = x_data{1,1}(:,1).^2;
x_data{1,2}(:,1) = linspace(1,20,20);
y_data{1,2} = x_data{1,2}(:,1).^3;



plot_shape{1,1} = 's';
plot_shape{1,2} = 'c';


fit_model = fit(x_data{1,1}(:,1),y_data{1,1}(:,1),'poly2');

xticks = [0,5,10,15,20];
yticks = [0,100,200,300,400];

eqn = @(x,y) y-x^3;


main_plot = plot_my_graph_no_prompt(x_data,y_data,plot_shape,'md', 'set1', xticks, yticks,[], fit_model, 'on', 'test_graph','count','measure')