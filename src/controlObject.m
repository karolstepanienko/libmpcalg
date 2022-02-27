%% controlObject
% Class containing information about sample MIMO or SISO object
classdef controlObject
    %% Properties
    properties (Access=public)
        ny
        nu
        stepResponse
    end

    %% Methods
    methods (Access=public)
        function obj = controlObject(ny, nu, stepResponse)
            obj.ny = ny;
            obj.nu = nu;
            obj.stepResponse = stepResponse;
        end
    end
end