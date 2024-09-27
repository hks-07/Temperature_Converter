classdef TemperatureConverterApp < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        ConvertButton        matlab.ui.control.Button
        OutputTempEditField  matlab.ui.control.NumericEditField
        OutputUnitDropDown   matlab.ui.control.DropDown
        OutputUnitLabel      matlab.ui.control.Label
        InputTempEditField   matlab.ui.control.NumericEditField
        InputUnitDropDown    matlab.ui.control.DropDown
        InputUnitLabel       matlab.ui.control.Label
        InputTempLabel       matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)
        
        % Button pushed function: ConvertButton
        function ConvertButtonPushed(app, ~)
            % Get the input temperature and selected units
            inputTemp = app.InputTempEditField.Value;
            inputUnit = app.InputUnitDropDown.Value;
            outputUnit = app.OutputUnitDropDown.Value;
           
            % Perform the conversion
            if strcmp(inputUnit, 'Celsius') && strcmp(outputUnit, 'Fahrenheit')
                % Convert Celsius to Fahrenheit
                outputTemp = (inputTemp * 9/5) + 32;
            elseif strcmp(inputUnit, 'Fahrenheit') && strcmp(outputUnit, 'Celsius')
                % Convert Fahrenheit to Celsius
                outputTemp = (inputTemp - 32) * 5/9;
            else
                % If both units are the same, no conversion needed
                outputTemp = inputTemp;
            end
           
            % Set the output temperature in the output field% setting the output temperature in the output field
    % setting the output temperature in the output field
    
            app.OutputTempEditField.Value = outputTemp;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 400 300];
            app.UIFigure.Name = 'MATLAB App';

            % Create InputTempLabel
            app.InputTempLabel = uilabel(app.UIFigure);
            app.InputTempLabel.HorizontalAlignment = 'right';
            app.InputTempLabel.Position = [59 219 68 22];
            app.InputTempLabel.Text = 'Input Temp';

            % Create InputUnitLabel
            app.InputUnitLabel = uilabel(app.UIFigure);
            app.InputUnitLabel.HorizontalAlignment = 'right';
            app.InputUnitLabel.Position = [59 166 68 22];
            app.InputUnitLabel.Text = 'Input Unit';

            % Create InputUnitDropDown
            app.InputUnitDropDown = uidropdown(app.UIFigure);
            app.InputUnitDropDown.Items = {'Celsius', 'Fahrenheit'};
            app.InputUnitDropDown.Position = [142 166 100 22];
            app.InputUnitDropDown.Value = 'Celsius';

            % Create InputTempEditField
            app.InputTempEditField = uieditfield(app.UIFigure, 'numeric');
            app.InputTempEditField.Position = [142 219 100 22];

            % Create OutputUnitLabel
            app.OutputUnitLabel = uilabel(app.UIFigure);
            app.OutputUnitLabel.HorizontalAlignment = 'right';
            app.OutputUnitLabel.Position = [59 113 68 22];
            app.OutputUnitLabel.Text = 'Output Unit';

            % Create OutputUnitDropDown
            app.OutputUnitDropDown = uidropdown(app.UIFigure);
            app.OutputUnitDropDown.Items = {'Celsius', 'Fahrenheit'};
            app.OutputUnitDropDown.Position = [142 113 100 22];
            app.OutputUnitDropDown.Value = 'Fahrenheit';

            % Create OutputTempEditField
            app.OutputTempEditField = uieditfield(app.UIFigure, 'numeric');
            app.OutputTempEditField.Position = [142 60 100 22];

            % Create ConvertButton
            app.ConvertButton = uibutton(app.UIFigure, 'push');
            app.ConvertButton.ButtonPushedFcn = createCallbackFcn(app, @ConvertButtonPushed, true);
            app.ConvertButton.Position = [142 20 100 22];
            app.ConvertButton.Text = 'Convert';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App initialization and construction
    methods (Access = public)

        % Construct app
        function app = TemperatureConverterApp

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
