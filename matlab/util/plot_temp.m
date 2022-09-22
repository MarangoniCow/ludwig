

% Series name
simID = '3DC_Pa_AH';
simTitle = '3DChannel, passive';
confSize = {'0.45$', '0.40$', '0.36$', '0.33$', '0.30$', '0.28$', '0.26$', '0.23$', '0.20$', '0.18$'};

n = length(col_disp);

S = plotdefaults;

fig_disp = figure;


for i = 7:10
    plot(movmean(disp_cell{i}(2, :), 5), 'LineWidth', S.std.LineWidth, 'color', S.col.blue(13 -i, :), ...
        'DisplayName', ['$2a_0/h = ', confSize{i}]);
    hold on
end
localfigproperties(fig_disp, [simTitle, ' displacement'])



fig_vel = figure;


for i = 7:10
    U = sqrt(vel_cell{i}(1, :).^2 + vel_cell{i}(2, :).^2 + vel_cell{i}(3, :).^2);
    plot(movmean(U, 25), 'LineWidth', S.std.LineWidth, 'color', S.col.red(13 -i, :), ...
        'DisplayName', ['$2a_0/h = ', confSize{i}]);
    hold on
end

localfigproperties(fig_vel, [simTitle, ' velocity'])

function localfigproperties(fig_handle, fig_title)
    
    S = plotdefaults;
    fig_handle.Position = [1215 1393 790 423];

    legend('FontSize', S.std.FontSizeLeg, 'NumColumns', 1, 'Interpreter', ...
                'latex', 'Location', 'eastoutside');
    ax.FontSize = S.std.FontSizeTick;
    title(fig_title)

end
