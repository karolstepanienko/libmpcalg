%% ValidateMPCS
% Abstract class responsible for validation of MPCS parameters
classdef (Abstract) ValidateMPCS
    properties (Access = protected, Constant)
        v = Validation();  % Validation object with data validation functions
        c = Constants();  % Constant values
    end

    methods (Access = protected)
        function obj = validateMPCSParams(obj, N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin_)
            % Runs Analytical and Fast MPCS algorithm parameter validation

            %% Parameter validation
            p = inputParser;
            p.CaseSensitive = true(1);
            p.FunctionName = 'MPCS';

            % Required parameters
            addRequired(p, 'N', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'Nu', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfOutputs', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfInputs', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'numberOfStateVariables', obj.v.validScalarIntGreaterThan0Num);
            addRequired(p, 'dA', obj.v.validSquareMatrix);
            addRequired(p, 'dB', obj.v.validMatrix);
            addRequired(p, 'dC', obj.v.validMatrix);
            addRequired(p, 'dD', obj.v.validMatrix);

            % Optional parameters
            addParameter(p, 'mi', obj.c.defaultMi, obj.v.validNum);
            addParameter(p, 'lambda', obj.c.defaultLambda, obj.v.validNum);
            
            addParameter(p, 'uMin', obj.c.defaultuMin,...
                obj.v.validScalarDoubleNum);
            
            addParameter(p, 'uMax', obj.c.defaultuMax,...
                obj.v.validScalarDoubleNum);
            
            addParameter(p, 'duMin', obj.c.defaultduMin,...
                obj.v.validScalarDoubleLessThan0Num);
            
            addParameter(p, 'duMax', obj.c.defaultduMax,...
                obj.v.validScalarDoubleGreaterThan0Num);
            
            addParameter(p, 'algType', obj.c.analyticalAlgType,...
                obj.v.validAlgType);

            % Parsing values
            parse(p, N, Nu, ny, nu, nx, dA, dB, dC, dD, varargin_{:});            
            
            % Assign required parameters
            obj.N = p.Results.N;
            obj.Nu = p.Results.Nu;
            obj.ny = p.Results.numberOfOutputs;
            obj.nu = p.Results.numberOfInputs;
            obj.nx = p.Results.numberOfStateVariables;
            obj.dA = obj.v.validateAStateMatrix(p.Results.dA, obj.nx);
            obj.dB = obj.v.validateStateMatrix(p.Results.dB, 'dB', obj.nx, obj.nu);
            obj.dC = obj.v.validateStateMatrix(p.Results.dC, 'dC', obj.ny, obj.nx);
            obj.dD = obj.v.validateStateMatrix(p.Results.dD, 'dD', obj.ny, obj.nu);

            % Assign optional parameters
            obj.mi = obj.v.validateArray('mi', p.Results.mi, obj.ny);
            obj.lambda = obj.v.validateArray('lambda', p.Results.lambda, obj.nu);
            obj.uMin = p.Results.uMin;
            obj.uMax = p.Results.uMax;
            obj.duMin = p.Results.duMin;
            obj.duMax = p.Results.duMax;
            % algType is not saved as a class property
        end
    end
end
